//
//  KKStatManager.h
//  Magic
//
//  Created by lixiang on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKSessionItem.h"

typedef NS_ENUM(NSUInteger, KKGatherLogType) {
    KKGatherLogTypeUnknown,
    KKGatherLogTypeViewControllerWillAppear,
    KKGatherLogTypeViewControllerWillDisappear,
    KKGatherLogTypeViewControllerLength,
    DDGatherLogTypeEventCount
};

@interface KKStatManager : DDSingletonObject

+ (KKStatManager *)getInstance;

/** Application Level Operations */
- (void)applicationDidFinishLaunchingWithApplication:(UIApplication *)application;
- (void)applicationDidEnterBackgroundWithApplication:(UIApplication *)application;
- (void)applicationWillEnterForegroundWithApplication:(UIApplication *)application;
- (void)applicationWillTerminateWithApplication:(UIApplication *)application;

//  添加统计事件
- (void)addStatObject:(id)object forType:(KKGatherLogType)type;
@end
