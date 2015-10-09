//
//  DDPageControl.m
//  PAPA
//
//  Created by Tong on 14/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import "DDPageControl.h"

@interface DDPageControl()

@property (nonatomic, assign) DDPageControlType type;
@property (nonatomic, strong) UIImage *imagePageStateNormal;
@property (nonatomic, strong) UIImage *imagePageStateHighlighted;

@end

@implementation DDPageControl

#pragma mark -
#pragma mark Accessors
- (UIImage *)imagePageStateHighlighted {
    if (nil == _imagePageStateHighlighted) {
        NSString *imageName = nil;
        switch (self.type) {
            case DDPageControlTypeBlack:
                imageName = @"pagecontrol_black_icon_h";
                break;
            case DDPageControlTypeRed:
                imageName = @"pagecontrol_red_icon_h";
                break;
            case DDPageControlTypeLight:
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
            case DDPageControlTypeRed:
            case DDPageControlTypeBlack:
                imageName = @"pagecontrol_dark_icon";
                break;
            case DDPageControlTypeLight:
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

- (id)initWithFrame:(CGRect)frame type:(DDPageControlType)type {
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

//- (void)setCurrentPage:(NSInteger)currentPage {
//    [super setCurrentPage:currentPage];
//
//    NSArray *subview = self.subviews;
//    for(NSInteger i =0; i<[subview count]; i++) {
//        UIImageView *dot = [subview objectAtIndex:i];
//        dot.image = currentPage == i ? self.imagePageStateHighlighted : self.imagePageStateNormal;
//    }
//}
//
//- (void)drawRect:(CGRect)rect {
//    [self setCurrentPage:0];
//}

@end
