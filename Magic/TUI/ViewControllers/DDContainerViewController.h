//
//  DDContainerViewController.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDViewControllerBase.h"

@interface DDContainerViewController : DDBaseViewController {
    NSInteger _currentViewControllerIndex;
}

/** Initialization */
- (id)initWithViewControllers:(NSArray *)viewControllers;
- (void)initSettingsWithViewControllers:(NSArray *)viewControllers;


/** Margin */
@property (nonatomic, assign) UIEdgeInsets containerEdgeInset;

/** Child view controllers */
@property (nonatomic, assign) NSInteger currentViewControllerIndex;
@property (nonatomic, readonly) UIViewController *visibleViewController;
@property (nonatomic, readonly) UIViewController *currentChildViewController;

- (NSUInteger)indexOfViewController:(UIViewController *)viewController;
- (DDBaseViewController *)viewControllerForIndex:(NSInteger)index;


/** Navigation */
@property (nonatomic, assign) BOOL customHandleNavigatonBar;

/** Validation */
- (BOOL)isValidIndex:(NSInteger)index;

/** Views that will be always on top */
- (void)addAlwaysOnTopView:(UIView *)view;

/** ChildViewController Operations */
- (void)switchToIndex:(NSInteger)index;
- (void)replaceChildViewControllerAtIndex:(NSInteger)index withChildViewController:(UIViewController *)viewController;

/** Template Methods */
- (void)adjustToViewController:(UIViewController *)viewController;

/** ChildViewController life cycle */
- (void)viewControllersWillTransitFrom:(UIViewController *)fromViewController to:(UIViewController *)toViewController;
- (void)viewControllersDidTransitFrom:(UIViewController *)fromViewController to:(UIViewController *)toViewController;

@end
