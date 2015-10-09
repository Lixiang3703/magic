//
//  YYLoginBgView.m
//  Wuya
//
//  Created by Tong on 19/09/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYLoginBgView.h"

@interface YYLoginBgView ()

@property (nonatomic, strong) UIImageView *topLineImageView;
@property (nonatomic, strong) UIImageView *bottomLineImageView;

@end

@implementation YYLoginBgView

- (void)setTopLineHidden:(BOOL)topLineHidden {
    _topLineHidden = topLineHidden;
    self.topLineImageView.hidden = topLineHidden;
}

- (void)setBottomLineHidden:(BOOL)bottomLineHidden {
    _bottomLineHidden = bottomLineHidden;
    self.bottomLineImageView.hidden = bottomLineHidden;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.topLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        self.topLineImageView.autoresizesSubviews = UIViewAutoresizingFlexibleBottomMargin;
        self.topLineImageView.image = [UIImage yyImageWithColor:[UIColor YYLineColor]];
        
        self.bottomLineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
        self.bottomLineImageView.autoresizesSubviews = UIViewAutoresizingFlexibleTopMargin;
        self.bottomLineImageView.image = [UIImage yyImageWithColor:[UIColor YYLineColor]];
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.topLineImageView];
        [self addSubview:self.bottomLineImageView];
    }
    return self;
}

@end
