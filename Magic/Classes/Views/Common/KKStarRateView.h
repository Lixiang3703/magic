//
//  KKStarRateView.h
//  Link
//
//  Created by Lixiang on 14/11/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDView.h"
#import "CWStarRateView.h"

@interface KKStarRateView : DDView

@property (nonatomic, strong) CWStarRateView *starRateView;
@property (nonatomic, assign) CGFloat scorePercent;

- (instancetype)initWithFrame:(CGRect)frame scorePercent:(CGFloat)scorePercent;

@end
