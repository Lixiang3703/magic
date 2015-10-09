//
//  UIColor+Tools.h
//  PMP
//
//  Created by Tong on 08/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

@interface UIColor (Tools)

+ (UIColor *)appTintColor;

+ (UIColor *)colorWithString:(NSString *)string defaultColor:(UIColor *)defaultColor;
- (NSString *)colorString;

@end
