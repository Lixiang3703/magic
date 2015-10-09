//
//  UILabel+Theme.h
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Theme)

- (void)setThemeUIType:(NSString *)type;

+ (NSUInteger)lineNumberWithThemeUIType:(NSString *)type;

- (void)trimHeight;
- (void)trimHeightWithLineNumber:(NSUInteger)lineNumber;

@end
