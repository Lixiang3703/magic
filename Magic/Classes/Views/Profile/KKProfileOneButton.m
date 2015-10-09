//
//  KKProfileOneButton.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKProfileOneButton.h"



@implementation KKProfileOneButton


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
//        self.layer.borderColor = [UIColor YYBlackColor].CGColor;
//        self.layer.borderWidth = 1.0f;
        
        CGFloat imageView_width = 35;
        CGFloat imageView_marginTop = 20;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - imageView_width)/2, imageView_marginTop, imageView_width, imageView_width)];
        self.iconImageView.image = [UIImage imageNamed:@"icon_gray_message"];
        
        CGFloat titleLabel_width = frame.size.width - 20;
        CGFloat titleLabel_marginBottom = 10;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - titleLabel_width)/2, frame.size.height - 20 - titleLabel_marginBottom, titleLabel_width, 20)];
        [self.titleLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        [self.titleLabel setFont:[UIFont systemFontOfSize:16]];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel setTextColor:[UIColor KKBlueColor]];
        self.titleLabel.text = @"title";
        
        self.button = [[UIButton alloc] initWithFrame:self.bounds];
        self.button.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.iconImageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.button];
    }
    
    return self;
}

@end
