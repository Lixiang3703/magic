//
//  UIAlertView+TUI.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WSBaseRequestModel;
@interface UIAlertView (TUI)

+ (BOOL)currentAlertViewDisplayed;

+ (void)postAlertWithMessage:(NSString *)message image:(UIImage *)image animated:(BOOL)animated duration:(NSTimeInterval)duration;

+ (void)postAlertWithMessage:(NSString *)message animated:(BOOL)animated duration:(NSTimeInterval)duration;

+ (void)postAlertWithMessage:(NSString *)message image:(UIImage *)image;

+ (void)postAlertWithMessage:(NSString *)message;

+ (void)postHUDAlertWithMessage:(NSString *)message;
+ (void)postHUDAlertWithMessage:(NSString *)message windowInteractionEnabled:(BOOL)windowInteractionEnabled;
+ (void)postHUDAlertWithMessage:(NSString *)message requestModel:(WSBaseRequestModel *)requestModel;
+ (void)postHUDAlertWithMessage:(NSString *)message requestModel:(WSBaseRequestModel *)requestModel windowInteractionEnabled:(BOOL)windowInteractionEnabled;

+ (void)HUDAlertDismiss;

@end
