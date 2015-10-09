//
//  UIViewController+Tools.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIViewController+Tools.h"
#import <objc/runtime.h>
#import "AppDelegate.h"
#import "DDBaseViewController.h"
#import "DDStat.h"

static char const * const kViewControllerKey_GatherLogEnable = "kVC_GatherLogEnable";
static char const * const kViewControllerKey_ViewDidAppear = "kVC_ViewDidAppear";
static char const * const kViewControllerKey_ViewAppearDate = "kVC_ViewAppearDate";

@implementation UIViewController (Tools)

- (BOOL)gatherLogEnable {
    NSNumber *number = objc_getAssociatedObject(self, kViewControllerKey_GatherLogEnable);
    return [number boolValue];
}

- (void)setGatherLogEnable:(BOOL)gatherLogEnable {
    NSNumber *number = [NSNumber numberWithBool:gatherLogEnable];
    objc_setAssociatedObject(self, kViewControllerKey_GatherLogEnable, number , OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)viewDidAppear {
    NSNumber *number = objc_getAssociatedObject(self, kViewControllerKey_ViewDidAppear);
    return [number boolValue];
}

- (void)setViewDidAppear:(BOOL)viewDidAppear {
    NSNumber *number = [NSNumber numberWithBool:viewDidAppear];
    objc_setAssociatedObject(self, kViewControllerKey_ViewDidAppear, number , OBJC_ASSOCIATION_RETAIN);
}

- (NSDate *)viewAppearDate {
    NSDate *date = objc_getAssociatedObject(self, kViewControllerKey_ViewAppearDate);
    return date;
}

- (void)setViewAppearDate:(NSDate *)viewAppearDate {
    objc_setAssociatedObject(self, kViewControllerKey_ViewAppearDate, viewAppearDate , OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)vcName {
    if (![self isKindOfClass:[DDBaseViewController class]]) {
        return @"UIVC";
    }
    NSString *className = [[self class] description];
    return [NSString stringWithFormat:@"%@|%@", [className substringWithRange:NSMakeRange(2, className.length - 2 - 14)], self.navigationItem.title];
}

- (NSString *)vcClassName {
    if (![self isKindOfClass:[DDBaseViewController class]]) {
        return @"UIVC";
    }
    NSString *className = [[self class] description];
    return [NSString stringWithFormat:@"%@", [className substringWithRange:NSMakeRange(2, className.length - 2 - 14)]];
}

- (void)uploadViewControllerGatherLog {
    if (!self.gatherLogEnable) {
        return;
    }
    [[DDStat getInstance] addStatObject:@{@"vcName":self.vcName, @"vcLength":@([[NSDate date] safeTimeIntervalSinceDate:self.viewAppearDate])} forType:DDGatherLogTypeViewControllerLength];
}

@end


@implementation UIViewController (TStoryBoard)

+ (UIViewController *)viewControllerWithClass:(Class)className {
    return [[self class] viewControllerWithClassName:[className description]];
}

+ (UIViewController *)viewControllerWithClassName:(NSString *)className {
    if (nil == className) {
        return nil;
    }

    return [[NSClassFromString(className) alloc] init];
}

@end
