//
//  PMGatherLogManager.h
//  PMP
//
//  Created by Tong on 20/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDSingletonObject.h"
#import "DDSessionItem.h"

typedef NS_ENUM(NSUInteger, DDGatherLogType) {
    DDGatherLogTypeUnknown,
    DDGatherLogTypeViewControllerWillAppear,
    DDGatherLogTypeViewControllerWillDisappear,
    DDGatherLogTypeViewControllerLength,
    DDGatherLogTypeCrashVCFromCA,
    DDGatherLogTypeServerFailRequests,
    DDGatherLogTypeEventName,
    DDGatherLogTypeEventCounter,
};

@interface DDStat : DDSingletonObject

+ (DDStat *)getInstance;
@property (nonatomic, strong) NSMutableArray *sessions;
@property (nonatomic, readonly) DDSessionItem *currentSession;

/** Application Level Operations */
- (void)applicationDidFinishLaunchingWithApplication:(UIApplication *)application;
- (void)applicationDidEnterBackgroundWithApplication:(UIApplication *)application;
- (void)applicationWillEnterForegroundWithApplication:(UIApplication *)application;
- (void)applicationWillTerminateWithApplication:(UIApplication *)application;

//  模板方法
- (void)gatherLogWillBegin;
- (void)gatherLogWillEnd;

//  add new session
- (void)addNewSessionWithLastCrashed:(NSString *)lastCrashedVCName;

//  添加统计事件
- (void)addStatObject:(id)object forType:(DDGatherLogType)type;

// sava & load Log file
- (void)saveGatherLogToFile;
- (void)loadGatherLogFromFile;

//  上传数据
- (void)uploadGatherLog;
- (NSString *)stringOfGatherLog;

//  删除旧日志
- (void)removeOldLogFile;

@end
