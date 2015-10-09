//
//  UIColor+KK.m
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "UIColor+KK.h"

@implementation UIColor (KK)

+ (UIColor *)KKMainColor {
    return [UIColor KKBlueColor];
}

+ (UIColor *)KKMainLightColor{
    return [UIColor KKBlueColor];
}

+ (UIColor *)KKMainDarkColor{
    return [UIColor KKBlueColor];
}

+ (UIColor *)KKButtonColor {
    return [UIColor KKBlueColor];
}

/** */
+ (UIColor *)ChatBgGreenColor {
    return [UIColor colorWithRed:0.63 green:0.9 blue:0.36 alpha:1];
}

/** PM */
+ (UIColor *)KKPMMineColor {
    return [UIColor ChatBgGreenColor];
}

+ (UIColor *)KKPMOtherColor {
    return RGBACOLOR(244, 244, 244, 1);
}

+ (UIColor *)KKWhiteColor {
    return RGBACOLOR(244, 244, 244, 1);
}

+ (UIColor *)KKRedColor {
    return [UIColor colorWithRed:0.96 green:0.27 blue:0.28 alpha:1];
}

+ (UIColor *)KKGreenColor {
    return [UIColor colorWithRed:0.42 green:0.76 blue:0.38 alpha:1];
}

+ (UIColor *)KKBlueColor {
    return [UIColor colorWithRed:0.04 green:0.42 blue:0.71 alpha:1];
//    return RGBACOLOR(3, 10, 184, 1);
}

+ (UIColor *)KKNameColor {
    return [UIColor colorWithRed:0 green:0.35 blue:0.49 alpha:1];
}

+ (UIColor *)KKLineColor {
    return RGBACOLOR(235, 235, 235, 1);
}
@end
