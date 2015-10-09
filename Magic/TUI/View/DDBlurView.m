//
//  DDBlurView.m
//  Wuya
//
//  Created by Tong on 08/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBlurView.h"

@interface DDBlurView ()

@property (nonatomic, strong) UIToolbar *toolbar;

@end

@implementation DDBlurView


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    // If we don't clip to bounds the toolbar draws a thin shadow on top
    [self setClipsToBounds:YES];
    if (nil == self.toolbar) {
        self.toolbar = [[UIToolbar alloc] initWithFrame:self.bounds];
        [self.toolbar fullfillPrarentView];
        [self.layer insertSublayer:self.toolbar.layer atIndex:0];
    }
}

- (void)setBlurTintColor:(UIColor *)blurTintColor {
    if (![UIDevice below7]) {
        [self.toolbar setBarTintColor:blurTintColor];
    }
}

@end
