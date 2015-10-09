//
//  DDDataMonitor.h
//  Wuya
//
//  Created by Tong on 12/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface DDDataMonitor : DDSingletonObject

/** Singleton */
+ (DDDataMonitor *)getInstance;

- (void)starMonitoring;

- (void)onEvent:(NSString *)eventName;
- (void)onIncreasingCounterWithEventName:(NSString *)eventName;
- (void)onIncreasingCounterWithEventName:(NSString *)eventName withParams:(NSDictionary *)params flurrySupport:(BOOL)flurrySupport;


- (void)logViewWillAppearWithViewController:(UIViewController *)viewController;
- (void)logViewWillDisappearWithViewController:(UIViewController *)viewController;

@end
