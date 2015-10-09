//
//  UIColor+YY.m
//  Wuya
//
//  Created by Tong on 15/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIColor+YY.h"

@implementation UIColor (YY)

+ (UIColor *)YYNavigationColor {
//    return [UIColor redColor];
    return [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
}

+ (UIColor *)YYMainTabbarColor {
    return [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
}

+ (UIColor *)YYMainTabbarTopLineColor {
    return [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
}

// Gray Black
+ (UIColor *)YYBlackColor {
    return RGBACOLOR(51, 51, 51, 1);
}

+ (UIColor *)YYGrayColor {
    return RGBACOLOR(199, 199, 204, 1);
}

+ (UIColor *)YYMiddleGrayColor {
    return RGBACOLOR(153, 153, 153, 1);
}

+ (UIColor *)YYLightGrayColor {
    return RGBACOLOR(204, 204, 204, 1);
}


+ (UIColor *)YYViewBgColor {
    return RGBACOLOR(247, 247, 247, 1);
}

+ (UIColor *)YYLineColor {
    return RGBACOLOR(229, 229, 229, 1);
}

+ (UIColor *)YYYellowColor {
    return RGBACOLOR(255, 199, 20, 1);
}


+ (UIColor *)YYTableCellHighlightedColor {
    return RGBACOLOR(255, 250, 235, 1);
}

+ (UIColor *)YYImageBgColor {
    return RGBACOLOR(204, 204, 204, 1);
}

+ (UIColor *)YYTextBlackColor {
    return [UIColor blackColor];
}

+ (UIColor *)YYTextLightGrayColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)YYTextGrayColor {
    return [UIColor grayColor];
}

+ (UIColor *)YYTextWhiteColor {
    return [UIColor whiteColor];
}

+ (UIColor *)YYTextLightWhiteColor {
    return [UIColor lightGrayColor];
}

+ (UIColor *)YYSwitchColor {
    return RGBACOLOR(162, 216, 91, 1);
}

#pragma mark -
#pragma mark PM

+ (UIColor *)YYPMMineColor {
    return [UIColor YYYellowColor];
}

+ (UIColor *)YYPMOtherColor {
    return [UIColor whiteColor];
}

#pragma mark -
#pragma mark KB

+ (UIColor *)YYCustomKeyboardBgColor{
    return RGBACOLOR(250, 250, 250, 1);
}

+ (UIColor *)YYKBEmojiSelectedColor{
    return RGBACOLOR(191, 191, 191, 1);
}

#pragma mark -
#pragma mark Other

+ (UIColor *)YYTextFieldBorderColor {
    return RGBACOLOR(204, 204, 204, 1);
}

+ (UIColor *)YYPostMaskColor {
    return RGBACOLOR(0, 0, 0, 0.2);
}

+ (UIColor *)YYCommentOwnerColor {
    return RGBACOLOR(20, 191, 255, 1);
}

+ (UIColor *)YYIntroMaskViewLightColor {
    return RGBACOLOR(0, 0, 0, 0.6);
}

+ (UIColor *)YYIntroMaskViewDarkColor {
    return RGBACOLOR(40, 38, 42, 0.88);
}

+ (UIColor *)YYProfileOperationBgColor{
    return RGBACOLOR(79, 79, 79, 1);
}

+ (UIColor *)YYProfilePlaceholdColor{
    return RGBACOLOR(201, 201, 201, 1);
}
@end
