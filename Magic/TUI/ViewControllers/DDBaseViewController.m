//
//  DDBaseViewController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDIntroManager.h"
#import "DDDataMonitor.h"
#import "DDStat.h"

@interface DDBaseViewController ()

@end

@implementation DDBaseViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

#pragma mark -
#pragma mark ViewController Stat

#pragma mark - 
#pragma mark Assessors

- (NSString *)viewControllerName {
    NSString *fullClassName = [[self class] description];
    return [[fullClassName stringByReplacingOccurrencesOfString:@"ViewController" withString:@""] stringByReplacingOccurrencesOfString:@"YY" withString:@""];
}

- (BOOL)isLeafViewController {
    return [self.childViewControllers count] == 0;
}

#pragma mark -
#pragma mark Initialization
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (void)initSettings {
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gatherLogEnable = YES;
    
    self.viewAppearAnimate = DDBaseItemBoolUnknown;
}

#pragma mark -
#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addGlobalNotification];
    
    self.view.backgroundColor = RGBACOLOR(255, 255, 255, 0.4f);
    
    if (!self.shouldIgnoreNavigationBarUpdate) {
        [self updateNavigationBar:NO];
    }
    
    if (self.gatherLogEnable && nil != self.statusBarColor) {
        UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
        statusBarView.tag = kUI_StatusBarView_Tag;
        statusBarView.backgroundColor = self.statusBarColor;
        statusBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.view addSubview:statusBarView];
    }
    
    if ([self conformsToProtocol:@protocol(DDBaseViewControllerBlurBg)]) {
        id<DDBaseViewControllerBlurBg> blurBgViewController = (id<DDBaseViewControllerBlurBg>)self;
        
        self.view.backgroundColor = [UIColor clearColor];
        
        blurBgViewController.blurBgImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        blurBgViewController.blurBgImageView.backgroundColor = [UIColor clearColor];
        blurBgViewController.blurBgImageView.userInteractionEnabled = NO;
        [blurBgViewController.blurBgImageView fullfillPrarentView];
        
        [self.view addSubview:blurBgViewController.blurBgImageView];
        [self.view sendSubviewToBack:blurBgViewController.blurBgImageView];
    }
}


- (void)viewWillAppear:(BOOL)animated {
    BOOL viewDidAppear = self.viewDidAppear;
    if (self.viewAppearAnimate == DDBaseItemBoolTrue) {
        animated = YES;
    }
    else if (self.viewAppearAnimate == DDBaseItemBoolFalse) {
        animated = NO;
    }
    
    [super viewWillAppear:animated];
    
    if (!viewDidAppear) {
        [self changeAppearAnimateForNavi];
    }
    
    if (self.shouldUpdateNavigationBarEveryTime) {
        [self setNaviTitle:nil];
        [self setNaviTitleView:nil];
        [self setLeftBarButtonItem:nil animated:NO];
        [self setRightBarButtonItem:nil animated:NO];
        [self updateNavigationBar:animated];
    }
    
    //  AppearDate
    self.viewAppearDate = [NSDate date];

    //  View-Level Notification
    [self addViewAppearNotification];

    //  Adjust Navigation Bar
    if (!self.ignoreNavigationBarHidden) {
        self.restoredNavigationBarHidden = self.navigationBarHidden;
        self.restoredStatusBarHidden = [UIApplication sharedApplication].statusBarHidden;
        [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:self.presentedViewController ? NO : animated];
//        [self.navigationController setNavigationBarHidden:self.navigationBarHidden animated:NO];
        [[UIApplication sharedApplication] setStatusBarHidden:self.statusBarHidden withAnimation:UIStatusBarAnimationSlide];
    }
    
    //  Stat
    if (self.gatherLogEnable) {
        [[DDStat getInstance] addStatObject:self.vcName forType:DDGatherLogTypeViewControllerWillAppear];
        [[DDDataMonitor getInstance] logViewWillAppearWithViewController:self];
    }
    
    //  StatusBar
    if (nil != self.statusBarColor) {
        [self.view bringSubviewToFront:[self.view viewWithTag:kUI_StatusBarView_Tag]];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    //  ViewDidAppear Flag
    self.viewDidAppear = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
//    if (!self.ignoreNavigationBarHidden && !self.presentedViewController) {
//        [self.navigationController setNavigationBarHidden:self.restoredNavigationBarHidden animated:animated];
//        [[UIApplication sharedApplication] setStatusBarHidden:self.restoredStatusBarHidden withAnimation:UIStatusBarAnimationSlide];
//    }
    
    //  Dismiss Intro if exists
    if (self.gatherLogEnable) {
        [[DDIntroManager getInstance] dismissIntroView];
    }
    
    //  Stat
    [self uploadViewControllerGatherLog];
    
    if (self.gatherLogEnable) {
        [[DDStat getInstance] addStatObject:self.vcName forType:DDGatherLogTypeViewControllerWillDisappear];
        [[DDDataMonitor getInstance] logViewWillDisappearWithViewController:self];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self removeViewAppearNotification];
}

#pragma mark -
#pragma mark AppearAnimate

- (void)changeAppearAnimateForNavi {
    if (self.navigationController.viewControllers.count > 1) {
        DDBaseViewController *lastViewController = [self.navigationController.viewControllers objectAtSafeIndex:(self.navigationController.viewControllers.count - 2)];
        if (!lastViewController || ![lastViewController isKindOfClass:[DDBaseViewController class]]) {
            return;
        }
        
        lastViewController.viewAppearAnimate = DDBaseItemBoolUnknown;
        self.viewAppearAnimate = DDBaseItemBoolUnknown;
        
        if (lastViewController.navigationBarHidden) {
            if (self.navigationBarHidden) {
                lastViewController.viewAppearAnimate = DDBaseItemBoolFalse;
                self.viewAppearAnimate = DDBaseItemBoolTrue;
            }
            else {
                lastViewController.viewAppearAnimate = DDBaseItemBoolTrue;
            }
        }
        else {
            if (self.navigationBarHidden) {
                lastViewController.viewAppearAnimate = DDBaseItemBoolTrue;
                self.viewAppearAnimate = DDBaseItemBoolTrue;
            }
            else {
                lastViewController.viewAppearAnimate = DDBaseItemBoolUnknown;
                self.viewAppearAnimate = DDBaseItemBoolUnknown;
            }
        }
    }
}

#pragma mark -
#pragma mark Navigation Bar
- (UIBarButtonItem *)myLeftBarButtonItem {
    UIBarButtonItem *leftBarButtonItem = self.navigationItem.leftBarButtonItem;
    UIViewController *parentViewController = self.parentViewController;
    while (nil == leftBarButtonItem && [parentViewController isKindOfClass:[DDBaseViewController class]]) {
        leftBarButtonItem = parentViewController.navigationItem.leftBarButtonItem;
        parentViewController = parentViewController.parentViewController;
    }
    
    return leftBarButtonItem;
}

- (void)backNaviButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


#pragma mark -
#pragma mark NavigationBar
- (void)updateNavigationBar:(BOOL)animated {
    //  Stat Navigation Bar
    /*
    self.navigationController.navigationBar.barTintColor = self.navigationBarColor;
    self.parentViewController.navigationController.navigationBar.barTintColor = self.navigationBarColor;
    [self.navigationController.navigationBar setNeedsDisplay];
    [self.parentViewController.navigationController.navigationBar setNeedsDisplay];
     */
}

- (void)setNaviTitle:(NSString *)naviTitle {
    [self setTitle:naviTitle];
    [self.parentViewController setTitle:naviTitle];
}

- (void)setNaviTitleView:(UIView *)view {
    [self.navigationItem setTitleView:view];
    [self.parentViewController.navigationItem setTitleView:view];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated {
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:animated];
    [self.parentViewController.navigationItem setLeftBarButtonItem:barButtonItem animated:animated];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem animated:(BOOL)animated {
    [self.navigationItem setRightBarButtonItem:barButtonItem animated:animated];
    [self.parentViewController.navigationItem setRightBarButtonItem:barButtonItem animated:animated];
}

- (void)setBackBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self.navigationItem setBackBarButtonItem:barButtonItem];
    [self.parentViewController.navigationItem setBackBarButtonItem:barButtonItem];
}


#pragma mark -
#pragma mark Notifications
- (void)addGlobalNotification {

}

- (void)addViewAppearNotification {

}

- (void)removeViewAppearNotification {

}

@end
