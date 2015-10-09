//
//  NSString+Theme.m
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "NSString+Theme.h"
#import "UIFont+Theme.h"
#import "UILabel+Theme.h"

@implementation NSString (Theme)

- (NSTextAlignment)textAlignment {
    if ([self isEqualToString:kThemeAliasNSTextAlignmentLeft]) {
        return NSTextAlignmentLeft;
    }
    
    if ([self isEqualToString:kThemeAliasNSTextAlignmentCenter]) {
        return NSTextAlignmentCenter;
    }
    
    if ([self isEqualToString:kThemeAliasNSTextAlignmentRight]) {
        return NSTextAlignmentRight;
    }
    
    return NSTextAlignmentLeft;
}

- (UIViewContentMode)viewContentMode {
    if ([self isEqualToString:kThemeAliasUIViewContentModeScaleToFill]) {
        return UIViewContentModeScaleToFill;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeScaleAspectFit]) {
        return UIViewContentModeScaleAspectFit;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeScaleAspectFill]) {
        return UIViewContentModeScaleAspectFill;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeRedraw]) {
        return UIViewContentModeRedraw;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeCenter]) {
        return UIViewContentModeCenter;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeTop]) {
        return UIViewContentModeTop;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeBottom]) {
        return UIViewContentModeBottom;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeLeft]) {
        return UIViewContentModeLeft;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeRight]) {
        return UIViewContentModeRight;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeTopLeft]) {
        return UIViewContentModeTopLeft;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeTopRight]) {
        return UIViewContentModeTopRight;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeBottomLeft]) {
        return UIViewContentModeBottomLeft;
    }
    
    if ([self isEqualToString:kThemeAliasUIViewContentModeBottomRight]) {
        return UIViewContentModeBottomRight;
    }
    
    return UIViewContentModeScaleToFill;
}

- (CGFloat)heightWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width {
    return ceilf([self sizeConfinedToNumberOfLinesWithThemeUIType:type constrainedWidth:width].height);
}

- (CGSize)sizeWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width {
    //  Take NSLineBreakByTruncatingTail as default value, since we are using Chinese
    return [self boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithThemeUIType:type]} context:nil].size;
}

- (CGFloat)widthWithThemeUIType:(NSString *)type {
    return [self sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithThemeUIType:type]}].width;
}

- (CGFloat)heightConfinedToNumberOfLinesWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width {
    return ceilf([self sizeConfinedToNumberOfLinesWithThemeUIType:type constrainedWidth:width].height);
}

- (CGSize)sizeConfinedToNumberOfLinesWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width {
    CGFloat lineHeight = [UIFont fontWithThemeUIType:type].lineHeight;
    NSUInteger numberOfLines = [[LBThemeCenter getInstance] lineNumberOfThemeType:type];
    if (0 == numberOfLines) {
        numberOfLines = 50;
    }
    return [self boundingRectWithSize:CGSizeMake(width, lineHeight * numberOfLines) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont fontWithThemeUIType:type]} context:nil].size;
}


@end
