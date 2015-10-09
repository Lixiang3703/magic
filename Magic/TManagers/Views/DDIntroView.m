//
//  DDIntroductionView.m
//  PAPA
//
//  Created by Tong Cui on 03/09/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

#import "DDIntroView.h"
#import <QuartzCore/QuartzCore.h>

@interface DDIntroView ()

@property (nonatomic, assign) BOOL bubbleStyle;

@end

@implementation DDIntroView

#pragma mark -
#pragma mark Properties

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark Initialzation
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.bubbleStyle = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        
        self.topMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0)];
        self.topMaskView.backgroundColor = [UIColor YYIntroMaskViewLightColor];

        
        self.bottomMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height, self.width, 0)];
        self.bottomMaskView.backgroundColor = [UIColor YYIntroMaskViewLightColor];
        
        self.leftMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.leftMaskView.backgroundColor = [UIColor YYIntroMaskViewLightColor];
        
        self.rightMaskView = [[UIView alloc] initWithFrame:CGRectMake(self.width, 0, 0, 0)];
        self.rightMaskView.backgroundColor = [UIColor YYIntroMaskViewLightColor];

        
        self.tipBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, 0, self.width - 2 * kUI_TableView_Common_Margin, 80)];
        self.tipBgImageView.clipsToBounds = YES;
        self.tipBgImageView.layer.cornerRadius = 3.0f;
        
        self.tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_TableView_Common_MarginW, 23, 210, 40)];
        [self.tipLabel setThemeUIType:kThemeIntroTipLabel];
        
        self.seperatorLine = [[UIView alloc] initWithFrame:CGRectMake(self.tipLabel.right + kUI_TableView_Common_Margin, self.tipLabel.top, 1, self.tipLabel.height)];
        self.seperatorLine.backgroundColor = [UIColor YYLineColor];
        
        self.confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(self.tipBgImageView.width - 60, self.tipLabel.top, 60, self.tipLabel.height)];
        [self.confirmButton setThemeUIType:kThemeBasicLabel_MiddleGray14];
        
        self.arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(100, self.tipBgImageView.bottom, 48, 28)];
        self.arrowView.image = [UIImage imageNamed:@"intro_icon_clip"];
        
        [self.tipBgImageView addSubview:self.tipLabel];
        [self.tipBgImageView addSubview:self.seperatorLine];
        [self.tipBgImageView addSubview:self.confirmButton];
        
        [self addSubview:self.topMaskView];
        [self addSubview:self.bottomMaskView];
        [self addSubview:self.leftMaskView];
        [self addSubview:self.rightMaskView];
        [self addSubview:self.tipBgImageView];
        [self addSubview:self.arrowView];
        
        [self.confirmButton setTitle:@"好的" forState:UIControlStateNormal];
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame viewControllerView:(UIView *)view {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.topMaskView = [[UIView alloc] initWithFrame:self.bounds];
        self.topMaskView.backgroundColor = [UIColor YYIntroMaskViewLightColor];
        
        [self addSubview:self.topMaskView];
        
        view.frame = self.bounds;
        [self addSubview:view];
        
    }
    return self;
}

- (void)setTransparentFrame:(CGRect)frame {
    CGFloat x = frame.origin.x;
    CGFloat y = frame.origin.y;
    CGFloat w = frame.size.width;
    CGFloat h = frame.size.height;
    
    self.topMaskView.height = y;
    
    self.bottomMaskView.top = self.topMaskView.bottom + h;
    self.bottomMaskView.height = self.height - self.bottomMaskView.top;
    
    self.leftMaskView.frame = CGRectMake(0, y, x, h);
    
    self.rightMaskView.frame = CGRectMake(x + w, y, self.width - x - w, h);
}

- (void)setBubbleTop:(BOOL)top {
    CGFloat tipTop = top ? 23 : 16;

    self.tipLabel.top = tipTop;
    self.seperatorLine.top = tipTop;
    self.confirmButton.top = tipTop;
}


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    
    if (!self.bubbleStyle) {
        return [super hitTest:point withEvent:event];
    }

    CGFloat y = point.y;
    CGFloat x = point.x;
    
    if (x > self.leftMaskView.right && x < self.rightMaskView.left && y > self.topMaskView.bottom && y < self.bottomMaskView.top) {
        return nil;
    }
    
    return [super hitTest:point withEvent:event];
}


@end
