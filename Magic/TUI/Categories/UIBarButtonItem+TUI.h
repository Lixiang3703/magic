//
//  UIBarButtonItem+TUI.h
//  Wuya
//
//  Created by Tong on 11/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TUI)

+ (UIBarButtonItem *)placeHolderButtonItem;
+ (UIBarButtonItem *)backButtonItemWithTarget:(id)target action:(SEL)selector;

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selector;
+ (UIBarButtonItem *)iconBarbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector;
+ (UIBarButtonItem *)iconBarbuttonItemWithImage:(UIImage *)image target:(id)target action:(SEL)selector;

+ (UIBarButtonItem *)barButtonItemWithWithTitle:(NSString *)title buttonTheme:(NSString *)buttonTheme target:(id)target action:(SEL)selector;
+ (UIBarButtonItem *)barButtonItemWithWithTitle:(NSString *)title buttonTheme:(NSString *)buttonTheme target:(id)target action:(SEL)selector fixedWidth:(CGFloat)fixedWidth;
+ (UIBarButtonItem *)barButtonItemWithWithTitle:(NSString *)title buttonTheme:(NSString *)buttonTheme target:(id)target action:(SEL)selector fixedWidth:(CGFloat)fixedWidth alignmentLeft:(BOOL)left;
+ (UIBarButtonItem *)barButtonItemWithButton:(UIButton *)button alignmentLeft:(BOOL)left;


@end
