//
//  DDIntroManager.m
//  Wuya
//
//  Created by Tong on 25/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDIntroManager.h"
#import "AppDelegate.h"
#import "DDAppSettings.h"
#import "DDLauncher.h"
#import "DDDataMonitor.h"
#import "UIAlertView+Blocks.h"

@interface DDIntroManager ()

@property (nonatomic, copy) DDIntroBlock prepareBlock;
@property (nonatomic, copy) DDIntroBlock cancelBlock;
@property (nonatomic, copy) DDIntroBlock confirmBlock;

@property (nonatomic, strong) DDIntroView *introView;
//@property (nonatomic, weak) id<DDViewControllerIntroSupporting> customDisplayViewController;

@end

@implementation DDIntroManager
SYNTHESIZE_SINGLETON_FOR_CLASS(DDIntroManager);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
        
        [self reloadIntroItem];
    }
    return self;
}


- (void)showIntroWithPrepareBlock:(DDIntroBlock)prepareBlock cancelBlock:(DDIntroBlock)cancelBlock confirmBlock:(DDIntroBlock)confirmBlock customDisplayViewController:(id<DDViewControllerIntroSupporting>)customDisplayViewController {
    DDLog(@"will show Intro");
    
    if (self.introView.superview) {
        return;
    }
    
    DDLog(@"Show Intro");
    
    self.prepareBlock = prepareBlock;
    self.cancelBlock = cancelBlock;
    self.confirmBlock = confirmBlock;
    
    UIWindow *window = [AppDelegate sharedAppDelegate].window;
    
    self.introView = nil;
    
    if (nil == self.introView) {
        self.customDisplayViewController = customDisplayViewController;
        self.customDisplayViewController.prepareBlock = prepareBlock;
        self.customDisplayViewController.confirmBlock = confirmBlock;
        self.customDisplayViewController.cancelBlock = cancelBlock;
        self.customDisplayViewController.introManager = self;
        
        self.introView = (customDisplayViewController == nil ? [[DDIntroView alloc] initWithFrame:window.frame] : [[DDIntroView alloc] initWithFrame:window.frame viewControllerView:[customDisplayViewController introContentView]]);
        self.introView.alpha = 0.0f;
        [self.introView.topMaskView addTarget:self tapAction:@selector(maskViewPressed:)];
        [self.introView.bottomMaskView addTarget:self tapAction:@selector(maskViewPressed:)];
        [self.introView.leftMaskView addTarget:self tapAction:@selector(maskViewPressed:)];
        [self.introView.rightMaskView addTarget:self tapAction:@selector(maskViewPressed:)];
//        [self.introView.tipBgImageView addTarget:self tapAction:@selector(tipPressed:)];
        [self.introView.confirmButton addTarget:self action:@selector(tipPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (nil != prepareBlock) {
        prepareBlock(self, self.introView);
    }
    
    if (nil == self.introView.superview) {
        [window addSubview:self.introView];
    }
    
    __weak typeof(self)weakSelf = self;
    self.introView.alpha = 0.0f;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.introView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showIntroWithPrepareBlock:(DDIntroBlock)prepareBlock cancelBlock:(DDIntroBlock)cancelBlock confirmBlock:(DDIntroBlock)confirmBlock {

    return [self showIntroWithPrepareBlock:prepareBlock cancelBlock:cancelBlock confirmBlock:confirmBlock customDisplayViewController:nil];
}

- (void)dismissIntroView {
    [self.introView removeFromSuperview];
    self.customDisplayViewController = nil;
}

#pragma mark -
#pragma mark Notification
- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [self saveIntroItem];
    if (!self.noDismissWhenAppDidEnterBackground) {
        [self dismissIntroView];
    }
}

- (void)applicationWillEnterForeground:(NSNotification *)notification {
    
}


- (void)appDidLogout:(NSNotification *)notification {
    [self saveIntroItem];
}

- (void)appDidLogin:(NSNotification *)notification {
    [self reloadIntroItem];
}


#pragma mark -
#pragma mark Buttons
- (void)maskViewPressed:(id)sender {
    
    [self introButtonPressedWithBlock:self.cancelBlock];
}

- (void)tipPressed:(id)sender {
    
    [self introButtonPressedWithBlock:self.confirmBlock];
}

- (void)introButtonPressedWithBlock:(DDIntroBlock)block {
    self.introView.alpha = 1.0f;
    
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.2f animations:^{
        weakSelf.introView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [weakSelf dismissIntroView];
        if (nil != block) {
            block(weakSelf, weakSelf.introView);
        }
    }];
}

#pragma mark -
#pragma mark Save
- (void)saveIntroItem {
    [DDAppSettings getInstance].introItemInfo = [self.introItem infoDict];
}

- (void)resetIntroItem {
    self.introItem = [[DDIntroItem alloc] init];
    [self saveIntroItem];
}


- (void)reloadIntroItem {
    self.introItem = [[DDIntroItem alloc] initWithDict:[DDAppSettings getInstance].introItemInfo];
}

@end
