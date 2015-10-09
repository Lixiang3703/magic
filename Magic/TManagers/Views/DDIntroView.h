//
//  DDIntroductionView.h
//  PAPA
//
//  Created by Tong Cui on 03/09/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDDIntroView_Tag (200)

typedef void (^DDIntroFadeCompletedBlock)();

@interface DDIntroView : UIView

@property (nonatomic, strong) UIView *topMaskView;
@property (nonatomic, strong) UIView *bottomMaskView;
@property (nonatomic, strong) UIView *leftMaskView;
@property (nonatomic, strong) UIView *rightMaskView;

@property (nonatomic, strong) UIImageView *tipBgImageView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *seperatorLine;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIImageView *arrowView;

- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithFrame:(CGRect)frame viewControllerView:(UIView *)view;

- (void)setTransparentFrame:(CGRect)frame;
- (void)setBubbleTop:(BOOL)top;

@end
