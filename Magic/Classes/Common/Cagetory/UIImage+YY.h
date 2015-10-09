//
//  UIImage+YY.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YY)

+ (UIImage *)yyMainBlackColorImage;
+ (UIImage *)yyImageWithColor:(UIColor *)color;
+ (UIImage *)yyLightUnderlineImage;
+ (UIImage *)yyDarkUnderlineImage;
+ (UIImage *)blur:(UIImage *)theImage;

@end
