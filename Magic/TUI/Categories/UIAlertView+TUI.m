//
//  UIAlertView+TUI.m
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIAlertView+TUI.h"
#import "TKAlertCenter.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#import "WSBaseRequestModel.h"

@implementation UIAlertView (TUI)

+ (BOOL)currentAlertViewDisplayed {
    if ([UIDevice below7]) {
        for (UIWindow* window in [UIApplication sharedApplication].windows){
            for (UIView *subView in [window subviews]){
                if ([subView isKindOfClass:[UIAlertView class]]) {
                    return YES;
                }
            }
        }
        return NO;
    } else {
        UIAlertView *topMostAlert = nil;
        SuppressPerformSelectorLeakWarning(topMostAlert = [NSClassFromString(@"_UIAlertManager") performSelector:NSSelectorFromString(@"topMostAlert")]);
        
        return nil != topMostAlert;
    }
}

+ (void)postAlertWithMessage:(NSString *)message image:(UIImage *)image animated:(BOOL)animated duration:(NSTimeInterval)duration {
    [TKAlertCenter postAlertWithMessage:(message == nil ? @"" : message) image:image withAnimation:animated forDuration:duration];
}

+ (void)postAlertWithMessage:(NSString *)message animated:(BOOL)animated duration:(NSTimeInterval)duration {
    [TKAlertCenter postAlertWithMessage:message withAnimation:animated forDuration:duration];
}

+ (void)postAlertWithMessage:(NSString *)message image:(UIImage *)image {
    [[TKAlertCenter defaultCenter] postAlertWithMessage:(message == nil ? @"" : message) image:image];
}

+ (void)postAlertWithMessage:(NSString *)message {
    if ([message hasContent]) {
        [TKAlertCenter postAlertWithMessage:message];
    }
}

+ (void)postHUDAlertWithMessage:(NSString *)message {
    [[self class] postHUDAlertWithMessage:message windowInteractionEnabled:NO];
}

+ (void)postHUDAlertWithMessage:(NSString *)message windowInteractionEnabled:(BOOL)windowInteractionEnabled {
    [SVProgressHUD showWithStatus:message];
    
    [AppDelegate sharedAppDelegate].window.userInteractionEnabled = windowInteractionEnabled;
}

+ (void)postHUDAlertWithMessage:(NSString *)message requestModel:(WSBaseRequestModel *)requestModel
{
    [UIAlertView postHUDAlertWithMessage:message requestModel:requestModel windowInteractionEnabled:NO];
}

+ (void)postHUDAlertWithMessage:(NSString *)message requestModel:(WSBaseRequestModel *)requestModel windowInteractionEnabled:(BOOL)windowInteractionEnabled
{
    __weak WSBaseRequestModel *weakRequestModel = requestModel;
    [AppDelegate sharedAppDelegate].window.userInteractionEnabled = windowInteractionEnabled;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (weakRequestModel.inProgress) {
            [SVProgressHUD showWithStatus:message];
        }
    });
}

+ (void)HUDAlertDismiss {
    [SVProgressHUD dismiss];
    [AppDelegate sharedAppDelegate].window.userInteractionEnabled = YES;
}

@end
