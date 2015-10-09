//
//  YYPageControl.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYPageControl.h"

@interface YYPageControl ()

@property (nonatomic, assign) YYPageControlType type;
@property (nonatomic, strong) UIImage *imagePageStateNormal;
@property (nonatomic, strong) UIImage *imagePageStateHighlighted;

@end

@implementation YYPageControl

#pragma mark -
#pragma mark Accessors
- (UIImage *)imagePageStateHighlighted {
    if (nil == _imagePageStateHighlighted) {
        NSString *imageName = nil;
        switch (self.type) {
            case YYPageControlTypeBlack:
                imageName = @"pagecontrol_black_icon_h";
                break;
            case YYPageControlTypeRed:
                imageName = @"pagecontrol_red_icon_h";
                break;
            case YYPageControlTypeLight:
                imageName = @"pagecontrol_light_icon_h";
                break;
            default:
                break;
        }
        _imagePageStateHighlighted = [UIImage imageNamed:imageName];
    }
    return _imagePageStateHighlighted;
}

- (UIImage *)imagePageStateNormal {
    if (nil == _imagePageStateNormal) {
        NSString *imageName = nil;
        switch (self.type) {
            case YYPageControlTypeRed:
            case YYPageControlTypeBlack:
                imageName = @"pagecontrol_dark_icon";
                break;
            case YYPageControlTypeLight:
                imageName = @"pagecontrol_light_icon";
                break;
            default:
                break;
        }
        _imagePageStateNormal = [UIImage imageNamed:imageName];
    }
    return _imagePageStateNormal;
}

#pragma mark -
#pragma mark Life cycle

- (id)initWithFrame:(CGRect)frame type:(YYPageControlType)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        self.backgroundColor = [UIColor clearColor];
        self.imagePageStateNormal = nil;
        self.imagePageStateHighlighted = nil;
        
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
        [self setPageIndicatorImage:self.imagePageStateNormal];
        [self setCurrentPageIndicatorImage:self.imagePageStateHighlighted];
    }
    return self;
}


@end
