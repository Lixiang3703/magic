//
//  UIColor+Theme.m
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "UIColor+Theme.h"

@implementation UIColor (Theme)

+ (UIColor *)navigationTintColor {
    return RGBCOLOR(10, 50, 90);
}

+ (UIColor *)colorWithThemeUIType:(NSString *)type {
    return [[LBThemeCenter getInstance] colorOfThemeType:type];
}

+ (UIColor *)mainMenuTableViewSeperatorColor {
    return RGBCOLOR(47, 47, 47);
}

+ (UIColor *)textFiledTextColor {
    return RGBCOLOR(34, 34, 34);
}

+ (UIColor *)imagePlaceholderColor {
    return RGBCOLOR(243, 241, 240);
}

+ (UIColor *)imageDidLoadColor {
    return [UIColor whiteColor];
}


@end

@implementation UIColor (Ext)

+ (UIColor *)colorWithGray:(CGFloat) gray{
    return [UIColor colorWithRed:gray/255.0f green:gray/255.0f blue:gray/255.0f alpha:1.0f];
}

@end