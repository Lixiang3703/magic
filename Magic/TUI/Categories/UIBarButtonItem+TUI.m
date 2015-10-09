//
//  UIBarButtonItem+TUI.m
//  Wuya
//
//  Created by Tong on 11/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIBarButtonItem+TUI.h"
#import "DDNaviBgView.h"

#define kUI_Common_BarButtonItem_Margin_Left     (15)
#define kUI_Common_BarButtonItem_Margin_Right    (-12)

@implementation UIBarButtonItem (TUI)

+ (UIBarButtonItem *)placeHolderButtonItem {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
    return barButtonItem;
}

+ (UIBarButtonItem *)backButtonItemWithTarget:(id)target action:(SEL)selector {
    return [UIBarButtonItem iconBarbuttonItemWithTheme:kThemeNavigationBarBackButton target:target action:selector alignmentLeft:YES];
}

+ (UIBarButtonItem *)iconBarbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector {
    return [UIBarButtonItem iconBarbuttonItemWithTheme:theme target:target action:selector alignmentLeft:NO];
}

+ (UIBarButtonItem *)iconBarbuttonItemWithTheme:(NSString *)theme target:(id)target action:(SEL)selector alignmentLeft:(BOOL)left {
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 32)];
    [button setThemeUIType:theme];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if ([UIDevice below7]) {
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        DDNaviBgView *backgroundView = [[DDNaviBgView alloc] initWithFrame:button.frame];
        backgroundView.bounds = CGRectOffset(backgroundView.bounds, left ? kUI_Common_BarButtonItem_Margin_Left : kUI_Common_BarButtonItem_Margin_Right, 0);
        [backgroundView addSubview:button];
        return [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
    }
}

+ (UIBarButtonItem *)iconBarbuttonItemWithImage:(UIImage *)image target:(id)target action:(SEL)selector {
    if ([UIDevice below7]) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 46, 32)];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        return [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:selector];
    }
}

+ (UIBarButtonItem *)barButtonItemWithTitle:(NSString *)title target:(id)target action:(SEL)selector {
    
    if ([UIDevice below7]) {
        CGFloat titleLength = [title sizeWithThemeUIType:kThemeNavigationBarButton constrainedWidth:160].width;
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, MAX(51, titleLength + 20), 32)];
        [button setThemeUIType:kThemeNavigationBarButton];
        [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
        [button setTitle:title forState:UIControlStateNormal];
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        return [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:selector];
    }
}

+ (UIBarButtonItem *)barButtonItemWithWithTitle:(NSString *)title buttonTheme:(NSString *)buttonTheme target:(id)target action:(SEL)selector {
    return [[self class] barButtonItemWithWithTitle:title buttonTheme:buttonTheme target:target action:selector fixedWidth:0];
}

+ (UIBarButtonItem *)barButtonItemWithWithTitle:(NSString *)title buttonTheme:(NSString *)buttonTheme target:(id)target action:(SEL)selector fixedWidth:(CGFloat)fixedWidth {
    return [[self class] barButtonItemWithWithTitle:title buttonTheme:buttonTheme target:target action:selector fixedWidth:fixedWidth alignmentLeft:NO];
}

+ (UIBarButtonItem *)barButtonItemWithWithTitle:(NSString *)title buttonTheme:(NSString *)buttonTheme target:(id)target action:(SEL)selector fixedWidth:(CGFloat)fixedWidth alignmentLeft:(BOOL)left {
    CGFloat titleLength = [title sizeWithThemeUIType:buttonTheme constrainedWidth:160].width;
    CGFloat buttonWidth = fixedWidth > 0 ? fixedWidth : MAX(51, titleLength + 20);
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth , 32)];
    [button setThemeUIType:buttonTheme];
    [button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    
    return [[self class] barButtonItemWithButton:button alignmentLeft:left];
}

+ (UIBarButtonItem *)barButtonItemWithButton:(UIButton *)button alignmentLeft:(BOOL)left {

    if ([UIDevice below7]) {
        return [[UIBarButtonItem alloc] initWithCustomView:button];
    } else {
        DDNaviBgView *backgroundView = [[DDNaviBgView alloc] initWithFrame:button.frame];
        backgroundView.bounds = CGRectOffset(backgroundView.bounds, left ? kUI_Common_BarButtonItem_Margin_Left : kUI_Common_BarButtonItem_Margin_Right, 0);
        [backgroundView addSubview:button];
        return [[UIBarButtonItem alloc] initWithCustomView:backgroundView];
    }
}

@end
