//
//  DDBaseViewController.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDBaseItem.h"

#define kUI_StatusBarView_Tag                      (178)

@protocol DDBaseViewControllerBlurBg <NSObject>

@property (nonatomic, strong) UIImageView *blurBgImageView;
@property (nonatomic, strong) UIImage *blurBgImage;

@optional;
- (void)blurBgImageDidUpdate;
- (void)generateDefaultBlurBgImage;

@end

@interface DDBaseViewController : UIViewController 

/** Navigation Bar */
@property (nonatomic, assign) BOOL restoredNavigationBarHidden;
@property (nonatomic, assign) BOOL navigationBarHidden;
@property (nonatomic, assign) BOOL restoredStatusBarHidden;
@property (nonatomic, assign) BOOL statusBarHidden;
@property (nonatomic, assign) BOOL ignoreNavigationBarHidden;
@property (nonatomic, strong) UIColor *statusBarColor;
@property (nonatomic, strong) UIColor *navigationBarColor;

/** ViewController Stat */
@property (nonatomic, assign) NSInteger tag;

/** Leaf Node */
@property (nonatomic, readonly) BOOL isLeafViewController;

/** Initial Settings */
- (void)initSettings;

/** UpdateNavigationBar */
@property (nonatomic, assign) BOOL shouldUpdateNavigationBarEveryTime;
@property (nonatomic, assign) BOOL shouldIgnoreNavigationBarUpdate;

/** Blur */
@property (nonatomic, strong) UIImageView *blurBgImageView;
@property (nonatomic, strong) UIImage *blurBgImage;

/**   */
@property (nonatomic, assign) DDBaseItemBool viewAppearAnimate;
- (void)changeAppearAnimateForNavi;

- (void)updateNavigationBar:(BOOL)animated;
- (void)setNaviTitle:(NSString *)naviTitle;
- (void)setNaviTitleView:(UIView *)view;
- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated;
- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated;
- (void)setBackBarButtonItem:(UIBarButtonItem *)barButtonItem;


/** Register notifications */                        // Called in:
- (void)addGlobalNotification;           //   viewDidLoad
- (void)addViewAppearNotification;       //   willAppear
- (void)removeViewAppearNotification;    //   willDisappear

/** Navigation Bar */
- (UIBarButtonItem *)myLeftBarButtonItem;
- (void)backNaviButtonPressed:(id)sender;

@end
