//
//  KKCaseOperationView.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseOperationView.h"

@interface KKCaseOperationView()

@property (nonatomic, strong) UIImageView *separateLineImageView;

@end

@implementation KKCaseOperationView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = NO;

        self.mineOperationContainer = [[UIView alloc] initWithFrame:self.bounds];
        
        UIView *bgView = [[UIView alloc] initWithFrame:self.bounds];
        bgView.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:0.98];
        
        CGFloat itemWidth = self.width/2 - 1;
        
        self.callButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, itemWidth, self.height)];
        [self.callButton setThemeUIType:kThemeBasicButton_Blue16];
        [self.callButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        self.callButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        self.callButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        [self.callButton setTitleColor:[UIColor KKBlueColor] forState:UIControlStateNormal];
        [self.callButton.imageView setWidth:40];
        [self.callButton.imageView setHeight:40];
        [self.callButton setImage:[UIImage imageNamed:@"icon_blue_call"] forState:UIControlStateNormal];
        [self.callButton setImage:[UIImage imageNamed:@"icon_blue_call"] forState:UIControlStateSelected];
        [self.callButton setImage:[UIImage imageNamed:@"icon_blue_call"] forState:UIControlStateHighlighted];
        
        [self.callButton setTitle:_(@"拨打电话") forState:UIControlStateNormal];
        
        CGFloat lineHeight = 30;
        self.separateLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(itemWidth, 0, 1, lineHeight)];
        self.separateLineImageView.image = [UIImage imageWithColor:[UIColor YYLineColor]];
        self.separateLineImageView.left = self.callButton.right;
        self.separateLineImageView.top = (self.height - lineHeight)/2;
        
        self.insertButton = [[UIButton alloc] initWithFrame:CGRectMake((itemWidth + 1), 0, itemWidth, self.height)];
        [self.insertButton setThemeUIType:kThemeBasicButton_Blue16];
        [self.insertButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        self.insertButton.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        self.insertButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 6);
        [self.insertButton setImage:[UIImage imageNamed:@"icon_blue_share"] forState:UIControlStateNormal];
        [self.insertButton setImage:[UIImage imageNamed:@"icon_blue_share"] forState:UIControlStateSelected];
        [self.insertButton setImage:[UIImage imageNamed:@"icon_blue_share"] forState:UIControlStateHighlighted];
        
        [self.insertButton setTitle:_(@"提交") forState:UIControlStateNormal];
        [self.insertButton setHitTestEdgeInsets:UIEdgeInsetsMake(-20, -20, -20, -20)];
        
        [self.mineOperationContainer addSubview:bgView];
        [self.mineOperationContainer addSubview:self.callButton];
        [self.mineOperationContainer addSubview:self.separateLineImageView];
        [self.mineOperationContainer addSubview:self.insertButton];
        
        UIView *topSeparateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], 1)];
        topSeparateLineView.backgroundColor = [UIColor YYLineColor];
        
        [self addSubview:self.mineOperationContainer];
        [self addSubview:topSeparateLineView];
    }
    return self;
}

@end
