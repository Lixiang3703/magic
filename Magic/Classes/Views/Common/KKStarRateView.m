//
//  KKStarRateView.m
//  Link
//
//  Created by Lixiang on 14/11/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKStarRateView.h"

@implementation KKStarRateView

#pragma mark -
#pragma mark Accessor

- (CWStarRateView *)starRateView {
    if (_starRateView == nil) {
        _starRateView = [[CWStarRateView alloc] initWithFrame:CGRectMake(0, 0, self.width - 2*kUI_TableView_Common_Margin, self.height) numberOfStars:5];
        _starRateView.scorePercent = 0.6;
        _starRateView.allowIncompleteStar = NO;
        _starRateView.hasAnimation = YES;
    }
    return _starRateView;
}

#pragma mark -
#pragma mark life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame scorePercent:(CGFloat)scorePercent {
    self = [self initWithFrame:frame];
    if (self) {
        self.starRateView.scorePercent = scorePercent;
        [self addSubview:self.starRateView];
    }
    return self;
}

- (void)setScorePercent:(CGFloat)scorePercent {
    if (scorePercent > 1) {
        scorePercent = 1;
    }
    _scorePercent = scorePercent;
    self.starRateView.scorePercent = scorePercent;
}

@end
