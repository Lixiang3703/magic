//
//  DDIntroManager.h
//  Wuya
//
//  Created by Tong on 25/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"
#import "DDIntroView.h"
#import "DDIntroItem.h"

@class DDIntroManager;

typedef void (^DDIntroBlock)(DDIntroManager *manager, DDIntroView *introView);



@protocol DDViewControllerIntroSupporting <NSObject>

@property (nonatomic, readonly) UIView *introContentView;
@property (nonatomic, weak) DDIntroManager *introManager;

@property (nonatomic, copy) DDIntroBlock prepareBlock;
@property (nonatomic, copy) DDIntroBlock cancelBlock;
@property (nonatomic, copy) DDIntroBlock confirmBlock;

@end


@interface DDIntroManager : DDSingletonObject


+ (DDIntroManager *)getInstance;

@property (nonatomic, strong) DDIntroItem *introItem;
@property (nonatomic, assign) BOOL noDismissWhenAppDidEnterBackground;


@property (nonatomic, weak) id<DDViewControllerIntroSupporting> customDisplayViewController;
@property (nonatomic, readonly) DDIntroView *introView;

- (void)showIntroWithPrepareBlock:(DDIntroBlock)prepareBlock cancelBlock:(DDIntroBlock)cancelBlock confirmBlock:(DDIntroBlock)confirmBlock;

- (void)showIntroWithPrepareBlock:(DDIntroBlock)prepareBlock cancelBlock:(DDIntroBlock)cancelBlock confirmBlock:(DDIntroBlock)confirmBlock customDisplayViewController:(id<DDViewControllerIntroSupporting>)customDisplayViewController;

- (void)introButtonPressedWithBlock:(DDIntroBlock)block;

- (void)dismissIntroView;

- (void)saveIntroItem;
- (void)resetIntroItem;
- (void)reloadIntroItem;

@end
