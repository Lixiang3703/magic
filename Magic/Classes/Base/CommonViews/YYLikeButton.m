//
//  YYLikeButton.m
//  Wuya
//
//  Created by Tong on 18/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYLikeButton.h"

@implementation YYLikeButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)setFaved:(DDBaseItemBool)faved {
    NSString *theme = self.themeType;
    if (faved == DDBaseItemBoolTrue) {
        theme = [theme stringByReplacingOccurrencesOfString:@"LikeButton" withString:@"LikedButton"];
    } else {
        theme = [theme stringByReplacingOccurrencesOfString:@"LikedButton" withString:@"LikeButton"];
    }
    [self setThemeUIType:theme];
}

@end
