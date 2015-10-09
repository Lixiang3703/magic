//
//  KKStatManager.m
//  Magic
//
//  Created by lixiang on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKStatManager.h"
#import "KKGatherLogRequestModel.h"

@interface KKStatManager()

@property (weak, nonatomic, readonly) NSString *logPath;

@property (nonatomic, strong) NSMutableArray *sessions;
@property (nonatomic, strong) KKSessionItem *currentSession;
@property (nonatomic, strong) KKGatherLogRequestModel *gatherLogRequestModel;

@end

@implementation KKStatManager

SYNTHESIZE_SINGLETON_FOR_CLASS(KKStatManager);

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark -
#pragma mark Accessor

- (NSString *)logPath {
    return [NSString filePathOfDocumentFolderWithName:@"missuk"];
}

- (KKGatherLogRequestModel *)gatherLogRequestModel {
    if (_gatherLogRequestModel == nil) {
        _gatherLogRequestModel = [[KKGatherLogRequestModel alloc] init];
    }
    return _gatherLogRequestModel;
}

#pragma mark -
#pragma mark Add

- (void)addStatObject:(id)object forType:(KKGatherLogType)type {
    switch (type) {
        case KKGatherLogTypeViewControllerWillAppear:
            
            break;
        case KKGatherLogTypeViewControllerWillDisappear:
            break;
        case KKGatherLogTypeViewControllerLength:
            [self gatherLogViewControllerLengthWithObject:object];
            break;
        default:
            break;
    }
}

- (void)gatherLogViewControllerLengthWithObject:(id)object {
    if (self.currentSession) {
        [self.currentSession.userPathes addObject:object];
    }
}

#pragma mark -
#pragma mark Application Level Operations

- (void)applicationDidFinishLaunchingWithApplication:(UIApplication *)application {
    [self gatherLogWillBegin];
}

- (void)applicationDidEnterBackgroundWithApplication:(UIApplication *)application {
    [self gatherLogWillEnd];
}

- (void)applicationWillEnterForegroundWithApplication:(UIApplication *)application {
    [self gatherLogWillBegin];
}

- (void)applicationWillTerminateWithApplication:(UIApplication *)application {
    [self gatherLogWillEnd];
}

- (void)gatherLogWillBegin {
    
    //  Reset AppearDate
    UIViewController *viewController = [UINavigationController appNavigationController].visibleViewController;
    
    viewController.viewAppearDate = [NSDate date];
    
    //  Load Sessions
    [self loadGatherLogFromFile];
    
    //  Upload Gather Log
    [self uploadGatherLog];
    
    self.currentSession = [[KKSessionItem alloc] init];
    self.currentSession.startTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    [self.sessions addSafeObject:self.currentSession];
}

- (void)gatherLogWillEnd {
    //  Submit ViewController Info
    UIViewController *viewController = [UINavigationController appNavigationController].visibleViewController;
    [viewController uploadLinkViewControllerGatherLog];
    
    //  Submit Session Length
    if (self.currentSession) {
        [self.currentSession sessionWillEnd];
    }
    
    //  Save Sessions
    [self saveGatherLogToFile];
}

#pragma mark -
#pragma mark Save or restore sessions

- (void)uploadGatherLog {

    //TODO: Add soon
//    NSString *gatherLogString = [self stringOfGatherLog];
//    NSMutableArray *tempSessions = [NSMutableArray arrayWithArray:self.sessions];
    [self.sessions removeAllObjects];
    
//    __weak __typeof(self)weakSelf = self;
//    self.gatherLogRequestModel.gatherlog = gatherLogString;
//    self.gatherLogRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
//        [weakSelf saveGatherLogToFile];
//    };
//    self.gatherLogRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
//        [tempSessions addObjectsFromArray:weakSelf.sessions];
//        weakSelf.sessions = tempSessions;
//    };
//    [self.gatherLogRequestModel load];
}

- (void)saveGatherLogToFile {
    __block NSMutableArray *sessionInfos = [NSMutableArray arrayWithCapacity:[self.sessions count]];
    [self.sessions enumerateObjectsUsingBlock:^(KKSessionItem *obj, NSUInteger idx, BOOL *stop) {
        [sessionInfos addObject:[obj infoDict]];
    }];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:sessionInfos];
    [[data dataByEncrypting] writeToFile:self.logPath atomically:YES];
}

- (void)loadGatherLogFromFile {
    NSData *data = [NSData dataWithContentsOfFile:self.logPath];
    
    NSArray *sessionInfos = (NSArray *)[NSKeyedUnarchiver unarchiveObjectWithData:[data dataByDecrypting]];
    
    __block NSMutableArray *sessions = [NSMutableArray array];
    [sessionInfos enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        [sessions addObject:[KKSessionItem itemWithDict:obj]];
    }];
    self.sessions = sessions;
}

#pragma mark -
#pragma mark Upload
- (NSString *)stringOfGatherLog {
    return @"stringOfGatherLog";
}

#pragma mark -
#pragma mark Delete Log
- (void)removeOldLogFile {
    [[NSFileManager defaultManager] removeItemAtPath:self.logPath error:NULL];
}

@end
