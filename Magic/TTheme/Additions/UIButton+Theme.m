//
//  UIButton+Theme.m
//  LBiPhone
//
//  Created by Cui Tong on 01/09/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "UIButton+Theme.h"

@implementation UIButton (Theme)

- (void)setThemeUIType:(NSString *)type {
    [[LBThemeCenter getInstance] setButton:self withThemeUIType:type];
}



@end
