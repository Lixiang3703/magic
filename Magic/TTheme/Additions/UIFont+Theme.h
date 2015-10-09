//
//  UIFont+Theme.h
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
@interface UIFont(Theme)

+ (UIFont *)fontWithThemeUIType:(NSString *)type;
+ (UIFont *)textFieldFont;

@end