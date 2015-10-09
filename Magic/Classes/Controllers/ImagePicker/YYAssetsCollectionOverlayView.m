//
//  YYAssetsCollectionOverlayView.m
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetsCollectionOverlayView.h"
#import <QuartzCore/QuartzCore.h>

// Views
#import "YYAssetsCollectionCheckmarkView.h"

@interface YYAssetsCollectionOverlayView()

@property (nonatomic, strong) YYAssetsCollectionCheckmarkView *checkmarkView;

@end

@implementation YYAssetsCollectionOverlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // View settings
        self.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.4];
        
        // Create a checkmark view
//        YYAssetsCollectionCheckmarkView *checkmarkView = [[YYAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (4.0 + 24.0), self.bounds.size.height - (4.0 + 24.0), 24.0, 24.0)];
        YYAssetsCollectionCheckmarkView *checkmarkView = [[YYAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake(self.bounds.size.width - (4.0 + 24.0), 4.0, 24.0, 24.0)];
        checkmarkView.autoresizingMask = UIViewAutoresizingNone;
        
        checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
        checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
        checkmarkView.layer.shadowOpacity = 0.6;
        checkmarkView.layer.shadowRadius = 2.0;
        
        [self addSubview:checkmarkView];
        self.checkmarkView = checkmarkView;
    }
    
    return self;
}
@end
