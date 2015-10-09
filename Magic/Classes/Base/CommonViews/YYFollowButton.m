//
//  YYFollowButton.m
//  Wuya
//
//  Created by Tong on 17/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYFollowButton.h"

@implementation YYFollowButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:CGRectMake(0, 0, 75, 25)];
    if (self) {
//        [self setThemeUIType:kThemeButtonFollowButton];
//        [self setTitle:@"关注" forState:UIControlStateNormal];
    }
    return self;
}

- (void)setFollowed:(BOOL)followed {
    if (followed) {
//        [self setThemeUIType:kThemeButtonUnFollowButton];
        [self setTitle:@"已关注" forState:UIControlStateNormal];
    } else {
//        [self setThemeUIType:kThemeButtonFollowButton];
        [self setTitle:@"关注" forState:UIControlStateNormal];
    }
}

@end
