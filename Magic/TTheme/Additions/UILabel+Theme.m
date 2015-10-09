//
//  UILabel+Theme.m
//  LBiPhone
//
//  Created by Cui Tong on 11/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "UILabel+Theme.h"
#import "LBThemeCenter.h"

@implementation UILabel (Theme)

- (void)setThemeUIType:(NSString *)type {
    [[LBThemeCenter getInstance] setLabel:self withThemeUIType:type];
}

+ (NSUInteger)lineNumberWithThemeUIType:(NSString *)type {
    return [[LBThemeCenter getInstance] lineNumberOfThemeType:type];
}

- (void)trimHeight {
    [self trimHeightWithLineNumber:1];
}


- (void)trimHeightWithLineNumber:(NSUInteger)lineNumber {
    self.height = self.font.ceilLineHeight * lineNumber;
}

@end
