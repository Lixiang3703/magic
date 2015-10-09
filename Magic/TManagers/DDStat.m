//
//  PMGatherLogManager.m
//  PMP
//
//  Created by Tong on 20/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDStat.h"
#import "AppDelegate.h"
#import "DDMultiSet.h"

@interface DDStat ()

@property (weak, nonatomic, readonly) NSString *logPath;

@end

@implementation DDStat

SYNTHESIZE_SINGLETON_FOR_CLASS(DDStat);

#pragma mark -
#pragma mark Accessors
- (DDSessionItem *)currentSession {
    return (DDSessionItem *)[self.sessions lastObject];
}

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

#pragma mark -
#pragma mark Log Path
- (NSString *)logPath {
    return [NSString filePathOfDocumentFolderWithName:@"missuk"];
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
    
}

- (void)gatherLogWillEnd {
    //  Submit ViewController Info
    UIViewController *viewController = [UINavigationController appNavigationController].visibleViewController;
    [viewController uploadViewControllerGatherLog];
    
    //  Submit Session Length
    [self.currentSession sessionWillEnd];
    
    
    //  Save Sessions
    [self saveGatherLogToFile];
}

#pragma mark -
#pragma mark Session
- (void)addNewSessionWithLastCrashed:(NSString *)lastCrashedVCName {
    DDSessionItem *sessonItem = [[DDSessionItem alloc] init];
    sessonItem.startTimeStamp = [[NSDate date] timeIntervalSince1970] * 1000;
    sessonItem.lastCrashedVCName = lastCrashedVCName;
    
    [self.sessions addObject:sessonItem];
}

#pragma mark -
#pragma mark Stat
- (void)addStatObject:(id)object forType:(DDGatherLogType)type {
    switch (type) {
        case DDGatherLogTypeViewControllerWillAppear:
            [self gatherLogViewControllerWillAppearWithObject:object];
            break;
        case DDGatherLogTypeViewControllerWillDisappear:
            [self gatherLogViewControllerWillDisappearWithObject:object];
            break;
        case DDGatherLogTypeViewControllerLength:
            [self gatherLogViewControllerLengthWithObject:object];
            break;
        case DDGatherLogTypeCrashVCFromCA:
            self.currentSession.lastCrashedVCNameFromCA = object;
            break;
        case DDGatherLogTypeServerFailRequests:
            [self gatherLogViewControllerServerFailWithObject:object];
            break;
        case DDGatherLogTypeEventName:
            [self gatherLogEventWithName:object];
            break;
        case DDGatherLogTypeEventCounter:
            [self gatherLogCounterWithName:object];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark Gather Log Operations
- (void)gatherLogViewControllerWillAppearWithObject:(id)object {
    //  3rd party log
}

- (void)gatherLogViewControllerWillDisappearWithObject:(id)object {
    //  3rd party log
}


- (void)gatherLogViewControllerLengthWithObject:(id)object {
    [self.currentSession.userPathes addObject:object];
}

- (void)gatherLogViewControllerServerFailWithObject:(id)requestModelName {
    if ([self.currentSession.serverFailRequestInfo count] <= 10) {
        [DDMultiSet addObjectWithDict:self.currentSession.serverFailRequestInfo object:requestModelName];
    }
}

- (void)gatherLogEventWithName:(NSString *)eventName {
    [self.currentSession.events addSafeObject:eventName];
}

- (void)gatherLogCounterWithName:(NSString *)eventName {
    [DDMultiSet addObjectWithDict:self.currentSession.eventCounter object:eventName];
}

#pragma mark -
#pragma mark Save or restore sessions
- (void)uploadGatherLog {
    //  need overwrite by subClass.
}

- (void)saveGatherLogToFile {
    __block NSMutableArray *sessionInfos = [NSMutableArray arrayWithCapacity:[self.sessions count]];
    [self.sessions enumerateObjectsUsingBlock:^(DDSessionItem *obj, NSUInteger idx, BOOL *stop) {
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
        [sessions addObject:[DDSessionItem itemWithDict:obj]];
    }];
    self.sessions = sessions;
}

#pragma mark -
#pragma mark Upload
- (NSString *)stringOfGatherLog {
    //  need overwrite by subClass.
    return @"stringOfGatherLog";
}

#pragma mark -
#pragma mark Delete Log
- (void)removeOldLogFile {
    [[NSFileManager defaultManager] removeItemAtPath:self.logPath error:NULL];
}

@end
