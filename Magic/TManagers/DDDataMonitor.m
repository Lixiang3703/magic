//
//  DDDataMonitor.m
//  Wuya
//
//  Created by Tong on 12/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDDataMonitor.h"
#import "DDStat.h"
#import "MobClick.h"
#import "Flurry.h"

@implementation DDDataMonitor

SYNTHESIZE_SINGLETON_FOR_CLASS(DDDataMonitor);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        // - need remove annotation;
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidRegister:) name:kLoginManager_Notification_DidRegister object:nil];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidLogin:) name:kLoginManager_Notification_DidLogIn object:nil];
        
    }
    return self;
}

#pragma mark -
#pragma mark Operations
- (void)starMonitoring {
    
#ifdef NEI
    [Flurry startSession:@"N849S32ZPSSW4ZP5W42C"];
    [MobClick startWithAppkey:@"542903b3fd98c52e78003dd6" reportPolicy:BATCH channelId:@"App Store"];
    
    [MobClick setLogEnabled:YES];
#else
    [Flurry startSession:@"MN5846VH9GM4DVG3YHFW"];
    [MobClick startWithAppkey:@"542901dafd98c52e7c003774" reportPolicy:BATCH channelId:@"App Store"];
#endif
    
    //  Version
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
}

- (void)onEvent:(NSString *)eventName {
    [[DDStat getInstance] addStatObject:eventName forType:DDGatherLogTypeEventName];
}

- (void)onIncreasingCounterWithEventName:(NSString *)eventName {
    [self onIncreasingCounterWithEventName:eventName withParams:nil flurrySupport:NO];
}

- (void)onIncreasingCounterWithEventName:(NSString *)eventName withParams:(NSDictionary *)params flurrySupport:(BOOL)flurrySupport {
    [[DDStat getInstance] addStatObject:eventName forType:DDGatherLogTypeEventCounter];
    if (flurrySupport) {
        [Flurry logEvent:[NSString stringWithFormat:@"WY|%@", eventName] withParameters:params];
        [MobClick event:[NSString stringWithFormat:@"WY|%@", eventName] attributes:params];
    }
}

- (void)logViewWillAppearWithViewController:(UIViewController *)viewController {
    [Flurry logPageView];
    [Flurry logEvent:viewController.vcName timed:YES];
    
    [MobClick beginLogPageView:viewController.vcName];
}

- (void)logViewWillDisappearWithViewController:(UIViewController *)viewController {
    [Flurry endTimedEvent:viewController.vcName withParameters:nil];
    
    [MobClick endLogPageView:viewController.vcName];
}

#pragma mark -
#pragma mark Notification

- (void)handleDidRegister:(NSNotification *)notification {
    
    [[DDDataMonitor getInstance] onEvent:@"onRegister"];
}

- (void)handleDidLogin:(NSNotification *)notification {

    [[DDDataMonitor getInstance] onEvent:@"onLogin"];
}

@end
