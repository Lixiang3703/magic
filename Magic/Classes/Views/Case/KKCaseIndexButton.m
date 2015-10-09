//
//  KKCaseIndexButton.m
//  Magic
//
//  Created by lixiang on 15/5/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseIndexButton.h"

@implementation KKCaseIndexButton


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor KKButtonColor]];
//        self.layer.cornerRadius = 5.0f;
//        self.clipsToBounds = YES;

        
        CGFloat imageView_width = frame.size.height * 5/11;
//        CGFloat imageView_marginTop = 50;
        
        CGFloat imageView_marginTop = frame.size.height * 1/7;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake((frame.size.width - imageView_width)/2, imageView_marginTop, imageView_width, imageView_width)];
        self.iconImageView.image = [UIImage imageNamed:@"icon_gray_message"];
        
        CGFloat titleLabel_width = frame.size.width - 10;
        CGFloat titleLabel_marginBottom = frame.size.height * 1/7;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((frame.size.width - titleLabel_width)/2, frame.size.height - titleLabel_marginBottom - 16, titleLabel_width, 16)];
        [self.titleLabel setThemeUIType:kThemeBasicLabel_Black17];
        self.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
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
