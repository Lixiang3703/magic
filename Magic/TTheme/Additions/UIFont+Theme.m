//
//  UIFont+Theme.m
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "UIFont+Theme.h"

@implementation  UIFont(Theme)

+ (UIFont *)fontWithThemeUIType:(NSString *)type {
    return [[LBThemeCenter getInstance] fontOfThemeType:type];
}

+ (UIFont *)textFieldFont {
    return [UIFont systemFontOfSize:15];
}

@end
