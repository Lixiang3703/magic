//
//  UIColor+Tools.m
//  PMP
//
//  Created by Tong on 08/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "UIColor+Tools.h"

@implementation UIColor (Tools)

+ (UIColor *)appTintColor {
    
    //  Wrong !!!
    return [[[UIApplication sharedApplication] delegate] window].tintColor;
}

+ (UIColor *)colorWithString:(NSString *)string defaultColor:(UIColor *)defaultColor {
    if (nil == string) {
        return defaultColor;
    }
    if ([string hasPrefix:@"("] && [string hasSuffix:@")"]) {
        string = [string substringWithRange:NSMakeRange(1, string.length - 2)];
        NSArray *array = [string componentsSeparatedByString:@","];
        if (array.count == 4) {
            return RGBACOLOR([array[0] integerValue], [array[1] integerValue], [array[2] integerValue], [array[3] integerValue] * 1.0 / 255);
        }
        
    }
    return nil;
}

- (NSString *)colorString {
    const CGFloat* colors = CGColorGetComponents(self.CGColor );

    CGFloat red     = colors[0];
    CGFloat green = colors[1];
    CGFloat blue   = colors[2];
    CGFloat alpha = colors[3];
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:4];
    array[0] = [NSString stringWithFormat:@"%.0f", red * 255];
    array[1] = [NSString stringWithFormat:@"%.0f", green * 255];
    array[2] = [NSString stringWithFormat:@"%.0f", blue * 255];
    array[3] = [NSString stringWithFormat:@"%.0f", alpha * 255];
    return [NSString stringWithFormat:@"(%@)", [array componentsJoinedByString:@","]];
}

@end
