//
//  YYAlertSimpleViewer.m
//  Wuya
//
//  Created by lixiang on 15/3/27.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAlertSimpleViewer.h"
#import "AppDelegate.h"

@interface YYAlertSimpleViewer()

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *okButtonTitle;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *mainContentView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *okButton;

@end

@implementation YYAlertSimpleViewer

SYNTHESIZE_SINGLETON_FOR_CLASS(YYAlertSimpleViewer);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Accessors

- (UIView *)containerView {
    if (nil == _containerView) {
        _containerView = [[UIView alloc] initWithFrame:[AppDelegate sharedAppDelegate].window.bounds];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.tag = kTag_Global_ImageViewer;
        
        self.bgView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.userInteractionEnabled = NO;
        [self.bgView addTarget:self tapAction:@selector(viewDidTap:)];
        
        [_containerView addSubview:self.bgView];
        [_containerView addSubview:self.mainContentView];
    }
    return _containerView;
}

- (UIView *)mainContentView {
    if (_mainContentView == nil) {
        
        CGFloat alertMainContent_Margin_Left = 40;
        
        CGFloat width = [UIDevice screenWidth] - 2*alertMainContent_Margin_Left;
        CGFloat height = width;
        CGFloat top = ([AppDelegate sharedAppDelegate].window.bounds.size.height - height) / 2;
        
        _mainContentView = [[UIView alloc] initWithFrame:CGRectMake(alertMainContent_Margin_Left, top, width, height)];
        _mainContentView.backgroundColor = [UIColor whiteColor];
        _mainContentView.layer.cornerRadius = 10;
        _mainContentView.clipsToBounds = YES;
        
        [self buildMainContentView];
    }
    return _mainContentView;
}

- (void)buildMainContentView {
    
    CGFloat buttonHeight = 40;
    CGFloat buttonWidth = self.mainContentView.width;
    CGFloat buttonBottomMargin = 10;
    CGFloat buttonRightMargin = 10;
    
    CGFloat middleContentHeight = self.mainContentView.height - buttonHeight - 2*buttonBottomMargin;
    CGFloat middleContentLeftPadding = 25;
    CGFloat middleContentTop = 30;
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(middleContentLeftPadding, middleContentTop, self.mainContentView.width - 2*middleContentLeftPadding, middleContentHeight)];
    self.contentLabel.text = self.content;
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel setTextColor:[UIColor grayColor]];
    [self.contentLabel sizeToFit];
    
    CGFloat buttonTop = self.mainContentView.height - buttonHeight - buttonBottomMargin;

    CGFloat iconImageWidth = 36;
    CGFloat iconImageHeight = 22;
    
    UIImageView *rightIconView = [[UIImageView alloc] initWithFrame:CGRectMake(self.mainContentView.width - iconImageWidth - 30, self.contentLabel.bottom + 10, iconImageWidth, iconImageHeight)];
    rightIconView.image = [UIImage imageNamed:@"alert_simple_icon"];
    
    UIView *separateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, rightIconView.bottom, self.mainContentView.width, 1)];
    separateLineView.backgroundColor = [UIColor YYLineColor];
    
    buttonTop = separateLineView.bottom + buttonBottomMargin;
    
    self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonRightMargin, buttonTop, buttonWidth - 2*buttonRightMargin, buttonHeight)];
    self.okButton.backgroundColor = [UIColor clearColor];
    [self.okButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.okButton setTitle:self.okButtonTitle forState:UIControlStateNormal];
    [self.okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.okButton.layer.cornerRadius = 5;
    self.okButton.clipsToBounds = YES;
    
    [self.mainContentView addSubview:self.contentLabel];
    [self.mainContentView addSubview:rightIconView];
    [self.mainContentView addSubview:separateLineView];
    [self.mainContentView addSubview:self.okButton];
    
    CGFloat mainHeight = buttonTop + buttonHeight + buttonBottomMargin;
    CGFloat top = ([AppDelegate sharedAppDelegate].window.bounds.size.height - mainHeight) / 2;
    
    self.mainContentView.height = mainHeight;
    self.mainContentView.top = top;
}

#pragma mark -
#pragma mark Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        
    }
    return self;
}

#pragma mark -
#pragma mark Show Action

- (void)showAlertViewWithContent:(NSString *)content okButtonTitle:(NSString *)okButtonTitle animated:(BOOL)animated {
    self.content = content;
    self.okButtonTitle = okButtonTitle;
    
    //  Window
    [[AppDelegate sharedAppDelegate].window addSubview:self.containerView];
    [self displayWithAnimated:animated];
}

#pragma mark -
#pragma mark Notification

- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [self dismissWithAnimated:NO];
}

#pragma mark -
#pragma mark Buttons

- (void)viewDidTap:(UITapGestureRecognizer *)gesture {
    if (self.ignoreTapAction) {
        return;
    }
    [self dismissWithAnimated:YES];
}

- (void)okButtonClick:(id)sender {
    if (self.okButtonPressBlock) {
        self.okButtonPressBlock(nil);
    }
    [self dismissWithAnimated:YES];
}

#pragma mark -
#pragma mark Display & Dismiss

- (void)displayWithAnimated:(BOOL)animated {
    //  Prepare
    self.bgView.alpha = 0.0f;
    
    [UIView animateWithDuration:0.3 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        self.bgView.alpha = 0.4f;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissWithAnimated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.15 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            self.bgView.alpha = 0.0f;
            self.mainContentView.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            [self.containerView removeFromSuperview];
            self.containerView = nil;
            
            [self.mainContentView removeFromSuperview];
            self.mainContentView = nil;
        }];
    }
    else {
        [UIView animateWithDuration:0.1 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            self.bgView.alpha = 0.0f;
            
        } completion:^(BOOL finished) {
            [self.containerView removeFromSuperview];
            self.containerView = nil;
            
            [self.mainContentView removeFromSuperview];
            self.mainContentView = nil;
        }];
    }
    
}

@end
