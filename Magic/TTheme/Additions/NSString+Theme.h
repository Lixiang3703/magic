//
//  NSString+Theme.h
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBThemeCenter.h"

@interface NSString (Theme)

- (NSTextAlignment)textAlignment;
- (UIViewContentMode)viewContentMode;

- (CGFloat)heightWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width;
- (CGSize)sizeWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width;
- (CGFloat)widthWithThemeUIType:(NSString *)type;

- (CGFloat)heightConfinedToNumberOfLinesWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width;
- (CGSize)sizeConfinedToNumberOfLinesWithThemeUIType:(NSString *)type constrainedWidth:(CGFloat)width;

@end
