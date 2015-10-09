//
//  KKOneClassicsView.m
//  Magic
//
//  Created by lixiang on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKOneClassicsView.h"

@implementation KKOneClassicsView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;
        
        CGFloat imageView_width = frame.size.width - 2*10;
        
        self.imageView = [[DDTImageView alloc] initWithFrame:CGRectMake(10, 10, imageView_width, imageView_width)];
        self.imageView.clipsToBounds = YES;
        self.imageView.layer.cornerRadius = 5.0f;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width, frame.size.width, 20)];
        [self.titleLabel setThemeUIType:kThemeBasicLabel_MiddleGray10];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        self.titleLabel.middleX = self.imageView.middleX;
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)injectDataWithImageUrl:(NSString *)imageUrl local:(BOOL)local title:(NSString *)title {
    [self.imageView loadImageWithUrl:imageUrl localImage:local];
    self.titleLabel.text = title;
}

@end
