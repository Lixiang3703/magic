//
//  YYAlertViewer.m
//  Wuya
//
//  Created by lixiang on 15/3/25.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAlertViewer.h"
#import "AppDelegate.h"
#import "WSDownloadCache.h"

#define kYYAlertViewer_MainContent_LeftMargin   (40)

#define kYYAlertViewer_MainContent_Padding_Top   (20)
#define kYYAlertViewer_MainContent_Padding_Left   (20)

#define kYYAlertViewer_IconImage_Height            (54)

#define kYYAlertViewer_Button_Height            (40)
#define kYYAlertViewer_TitleLabel_Height        (50)
#define kYYAlertViewer_Button_Margin_Bottom            (20)


@interface YYAlertViewer()

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *cancelButtonTitle;
@property (nonatomic, strong) NSString *okButtonTitle;
@property (nonatomic, strong) UIImage *iconImage;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIView *mainContentView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;

@end

@implementation YYAlertViewer

SYNTHESIZE_SINGLETON_FOR_CLASS(YYAlertViewer);

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
        
        [_containerView addTarget:self tapAction:@selector(viewDidTap:)];
        
        self.bgView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.userInteractionEnabled = NO;
        
        [_containerView addSubview:self.bgView];
        [_containerView addSubview:self.mainContentView];
    }
    return _containerView;
}

- (UIView *)mainContentView {
    if (_mainContentView == nil) {
        
        CGFloat width = [UIDevice screenWidth] - 2*kYYAlertViewer_MainContent_LeftMargin;
        CGFloat height = width;
        CGFloat top = ([AppDelegate sharedAppDelegate].window.bounds.size.height - height) / 2;
        
        _mainContentView = [[UIView alloc] initWithFrame:CGRectMake(kYYAlertViewer_MainContent_LeftMargin, top, width, height)];
        _mainContentView.backgroundColor = [UIColor whiteColor];
        _mainContentView.layer.cornerRadius = 10;
        _mainContentView.clipsToBounds = YES;
        
        [self buildMainContentView];
    }
    return _mainContentView;
}

- (void)buildMainContentView {
    
    CGFloat titleLabelHeight = kYYAlertViewer_TitleLabel_Height;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.mainContentView.width, titleLabelHeight)];
    self.titleLabel.text = @"上传头像";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *separateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, titleLabelHeight, self.mainContentView.width, 1)];
    separateLineView.backgroundColor = [UIColor YYLineColor];
    
    [self.mainContentView addSubview:self.titleLabel];
    [self.mainContentView addSubview:separateLineView];
    
    CGFloat buttonHeight = kYYAlertViewer_Button_Height;
    CGFloat buttonWidth = 85;
    CGFloat buttonBottomMargin = kYYAlertViewer_Button_Margin_Bottom;
    CGFloat buttonRightMargin = 10;
    
    CGFloat middleContentHeight = self.mainContentView.height - titleLabelHeight - buttonHeight - 2*buttonBottomMargin;
    CGFloat middleContentTopPadding = 20;
    CGFloat iconImageViewWidth = 60;
    CGFloat iconImageViewHeight = kYYAlertViewer_IconImage_Height;
    CGFloat middleContentTop = self.titleLabel.bottom + middleContentTopPadding;
    
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kYYAlertViewer_MainContent_Padding_Left, middleContentTop, iconImageViewWidth, iconImageViewHeight)];
    self.iconImageView.image = [UIImage imageNamed:@"alert_icon"];
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconImageView.right + 10, middleContentTop, self.mainContentView.width - iconImageViewWidth - 2*kYYAlertViewer_MainContent_Padding_Left - 10, middleContentHeight - kYYAlertViewer_MainContent_Padding_Top)];
    self.contentLabel.text = @"";
    self.contentLabel.numberOfLines = 0;
    [self.contentLabel setTextColor:[UIColor grayColor]];
    
    CGFloat buttonTop = self.mainContentView.height - buttonHeight - buttonBottomMargin;
    
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonTop, buttonWidth, buttonHeight)];
    self.cancelButton.right = self.mainContentView.width / 2 - buttonRightMargin;
    self.cancelButton.backgroundColor = [UIColor lightGrayColor];
    [self.cancelButton setTitle:@"不乖" forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cancelButton.layer.cornerRadius = 5;
    self.cancelButton.clipsToBounds = YES;
    
    self.okButton = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonTop, buttonWidth, buttonHeight)];
    self.okButton.left = self.mainContentView.width / 2 + buttonRightMargin;
    self.okButton.backgroundColor = [UIColor YYYellowColor];
    [self.okButton setTitle:@"搞起来" forState:UIControlStateNormal];
    [self.okButton addTarget:self action:@selector(okButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.okButton.layer.cornerRadius = 5;
    self.okButton.clipsToBounds = YES;
    
    [self.mainContentView addSubview:self.iconImageView];
    [self.mainContentView addSubview:self.contentLabel];
    
    [self.mainContentView addSubview:self.cancelButton];
    [self.mainContentView addSubview:self.okButton];
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

- (void)showAlertViewWithIconImage:(UIImage *)iconImage title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle animated:(BOOL)animated {
    
    //  Check if displayed or not
    if ([self.containerView superview]) {
        return;
    }
    
    self.iconImage = iconImage;
    self.title = title;
    self.content = content;
    self.cancelButtonTitle = cancelButtonTitle;
    self.okButtonTitle = okButtonTitle;
    
    //  Window
    [[AppDelegate sharedAppDelegate].window addSubview:self.containerView];
    [self setupUI];
    
    [self displayWithAnimated:animated];
}

- (void)setupUI {
    self.titleLabel.text = self.title;
    self.contentLabel.text = self.content;
    [self.contentLabel sizeToFit];
    
    CGFloat contentLabelHeight = (self.contentLabel.height > kYYAlertViewer_IconImage_Height) ? self.contentLabel.height : kYYAlertViewer_IconImage_Height;
    
    self.mainContentView.height = kYYAlertViewer_TitleLabel_Height + kYYAlertViewer_MainContent_Padding_Top + contentLabelHeight + kYYAlertViewer_Button_Height + 2*kYYAlertViewer_Button_Margin_Bottom;
    
    CGFloat buttonTop = self.mainContentView.height - kYYAlertViewer_Button_Height - kYYAlertViewer_Button_Margin_Bottom;
    self.okButton.top = buttonTop;
    self.cancelButton.top = buttonTop;
    self.iconImageView.middleY = self.contentLabel.middleY;
    
    self.iconImageView.image = self.iconImage;
    [self.cancelButton setTitle:self.cancelButtonTitle forState:UIControlStateNormal];
    [self.okButton setTitle:self.okButtonTitle forState:UIControlStateNormal];
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

- (void)cancelButtonClick:(id)sender {
    if (self.cancelButtonPressBlock) {
        self.cancelButtonPressBlock(nil);
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
        
        }];
    }
    
}

@end
