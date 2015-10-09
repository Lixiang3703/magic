//
//  UIView+Theme.m
//  PAPA
//
//  Created by Tong on 27/12/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

static const char *ThemeType = "ThemeType";

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "LBThemeCenter.h"

@implementation UIView (Theme)

- (void)setThemeType:(NSString *)themeType {
    objc_setAssociatedObject(self, (void *) ThemeType, themeType, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)themeType {
    return (NSString *)objc_getAssociatedObject(self, (void *) ThemeType);
}

- (void)setThemeUIType:(NSString *)type {
    [[LBThemeCenter getInstance] setUIView:self withThemeUIType:type];
}

@end


@implementation UIView (ThemeAdditions)

- (BOOL)isVisible {
    return nil != [self window];
}

@end