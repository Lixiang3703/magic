//
//  UIColor+Theme.h
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LBThemeCenter.h"

/**
 * Theme
 */

@interface UIColor (Theme)


+ (UIColor *)navigationTintColor;

+ (UIColor *)colorWithThemeUIType:(NSString *)type;

+ (UIColor *)mainMenuTableViewSeperatorColor;

+ (UIColor *)textFiledTextColor;

+ (UIColor *)imagePlaceholderColor;

+ (UIColor *)imageDidLoadColor;

@end

@interface UIColor (Ext)

+ (UIColor *)colorWithGray:(CGFloat) gray;

@end
