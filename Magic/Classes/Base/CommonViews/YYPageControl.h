//
//  YYPageControl.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "SMPageControl.h"

typedef NS_ENUM(NSUInteger, YYPageControlType) {
    YYPageControlTypeBlack,
    YYPageControlTypeRed,
    YYPageControlTypeLight,
};

@interface YYPageControl : SMPageControl

- (id)initWithFrame:(CGRect)frame type:(YYPageControlType)type;

@end
