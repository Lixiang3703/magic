//
//  DDSpinView.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDSpinImageView.h"

#define kDDSpinImageView_AnimationKey       (@"SpinAnimation")

@interface DDSpinImageView ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DDSpinImageView

#pragma mark -
#pragma mark Life cycle
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self.imageView fullfillPrarentView];
        self.imageView.image = [UIImage imageNamed:@"refresh_button"];
        self.imageView.contentMode = UIViewContentModeCenter;
        
        [self addSubview:self.imageView];
    }
    return self;
}

#pragma mark -
#pragma mark Animation
- (void)startSpinAnimation {
    if ([self.imageView.layer animationForKey:kDDSpinImageView_AnimationKey] == nil) {
        CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.fromValue = [NSNumber numberWithFloat:0.0f];
        animation.toValue = [NSNumber numberWithFloat: 2 * M_PI];
        animation.duration = 3.0f;
        animation.repeatCount = INFINITY;
        [self.imageView.layer addAnimation:animation forKey:kDDSpinImageView_AnimationKey];
        self.animating = YES;
    }
}

- (void)stopSpinAnimation {
    self.animating = NO;
    [self.imageView.layer removeAnimationForKey:kDDSpinImageView_AnimationKey];
}

@end
