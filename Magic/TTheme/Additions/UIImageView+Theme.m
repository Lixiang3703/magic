//
//  UIImageView+Theme.m
//  PAPA
//
//  Created by Cui Tong on 01/08/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

#import "UIImageView+Theme.h"
#import "LBThemeCenter.h"

@implementation UIImageView (Theme)

- (void)setThemeUIType:(NSString *)type {
    [[LBThemeCenter getInstance] setImageView:self withThemeUIType:type];
}

@end
