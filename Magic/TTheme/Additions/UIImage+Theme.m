//
//  UIImage+Theme.m
//  iPhone
//
//  Created by Cui Tong on 10/02/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "UIImage+Theme.h"
#import "LBThemeCenter.h"

@implementation UIImage (Theme)

+ (UIImage *)imageWithThemeUIType:(NSString *)name {
    
    return [[LBThemeCenter getInstance] imageOfThemeType:name];
}

+ (NSString *)imageNameWithThemeUIType:(NSString *)name {
    return [[LBThemeCenter getInstance] imageNameOfThemeType:name];
}

@end

