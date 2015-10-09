//
//  DDContainerViewController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDContainerViewController.h"
#import "DDBaseTableViewController.h"
#import "DDBaseViewController.h"

@interface DDContainerViewController ()

/** Container */
@property (nonatomic, strong) UIView *containerView;

/** Views that will be always on top */
@property (nonatomic, strong) NSMutableArray *alwaysOnTopViews;

@end

@implementation DDContainerViewController

#pragma mark -
#pragma mark Initialization
- (id)initWithViewControllers:(NSArray *)viewControllers {
    self = [super init];
    if (self) {
        [self initSettingsWithViewControllers:viewControllers];
    }
    return self;
}


- (void)initSettingsWithViewControllers:(NSArray *)viewControllers {
    for (DDBaseViewController *viewController in viewControllers) {
        if (!self.customHandleNavigatonBar) {
            viewController.shouldUpdateNavigationBarEveryTime = YES;
        } else {
            viewController.shouldUpdateNavigationBarEveryTime = NO;
            viewController.shouldIgnoreNavigationBarUpdate = YES;
        }
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    
    self.alwaysOnTopViews = [NSMutableArray array];
}

- (void)initSettings {
    [super initSettings];
    
    self.containerEdgeInset = UIEdgeInsetsZero;
    self.gatherLogEnable = NO;
}

#pragma mark -
#pragma mark Child view controllers
- (UIViewController *)currentChildViewController {
    return [self.childViewControllers objectAtSafeIndex:self.currentViewControllerIndex];
}

- (UIViewController *)visibleViewController{
	UIViewController *childViewController = [self.childViewControllers objectAtSafeIndex:self.currentViewControllerIndex];
    
	if ([childViewController isKindOfClass:[DDContainerViewController class]]) {
		return [(DDContainerViewController *)childViewController visibleViewController];
	} else {
		return childViewController;
	}
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    return [self.childViewControllers indexOfObject:viewController];
}

- (DDBaseViewController *)viewControllerForIndex:(NSInteger)index {
    return (DDBaseViewController *)[self.childViewControllers objectAtSafeIndex:index];
}

#pragma mark -
#pragma mark Validation
- (BOOL)isValidIndex:(NSInteger)index {
    return index >= 0 && index < [self.childViewControllers count];
}

#pragma mark -
#pragma mark AlwaysOnTopView
- (void)addAlwaysOnTopView:(UIView *)view {
    [self.alwaysOnTopViews addSafeObject:view];
}

- (void)adjustAlwaysOnTopViews {
    for (UIView *theView in self.alwaysOnTopViews) {
        [self.view bringSubviewToFront:theView];
    }
}

#pragma mark -
#pragma mark ChildViewController Operations
- (void)switchToIndex:(NSInteger)index {
    [self adjustCurrentChildrenViewControllerFromIndex:self.currentViewControllerIndex toIndex:index];
}

- (void)replaceChildViewControllerAtIndex:(NSInteger)index withChildViewController:(DDBaseViewController *)viewController {
    
    NSInteger totalCount = [self.childViewControllers count];
    
    NSMutableArray *leftChildViewController = [NSMutableArray arrayWithCapacity:totalCount - index];
    
    for (NSInteger i = index ; i < totalCount; i++) {
        DDBaseViewController *childViewController = [self.childViewControllers objectAtIndex:index];
        [leftChildViewController addObject:childViewController];
        [childViewController removeFromParentViewController];
    }
    
    DDBaseViewController *oldViewController = [leftChildViewController firstObject];
    UIView *parentView = oldViewController.view.superview;
    [oldViewController.view removeFromSuperview];
    
    [self addChildViewController:viewController];
    
    viewController.view.frame = oldViewController.view.frame;
    
    viewController.shouldUpdateNavigationBarEveryTime = oldViewController.shouldUpdateNavigationBarEveryTime;
    
    [leftChildViewController replaceObjectAtIndex:0 withObject:viewController];
    
    [leftChildViewController enumerateObjectsUsingBlock:^(DDBaseViewController *obj, NSUInteger idx, BOOL *stop) {
        [self addChildViewController:obj];
    }];
    
    if (index == self.currentViewControllerIndex) {
        [parentView addSubview:viewController.view];
    }
}

#pragma mark -
#pragma mark Templates
- (void)adjustToViewController:(UIViewController *)viewController {
//    if ([viewController isKindOfClass:[DDBaseTableViewController class]] && ![UIDevice below7]) {
//        DDBaseTableViewController *tableViewController = (DDBaseTableViewController *)viewController;
//        
//        tableViewController.tableView.contentInset = UIEdgeInsetsMake(kDevice_iOS7_DefaultTopHeight, 0, 0, 0);
//        tableViewController.tableView.contentOffset = CGPointMake(0, -kDevice_iOS7_DefaultTopHeight);
//        tableViewController.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(kDevice_iOS7_DefaultTopHeight, 0, 0, 0);
//    }
}

#pragma mark -
#pragma mark ChildViewController life cycle

- (void)adjustCurrentChildrenViewControllerFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    DDBaseViewController *fromViewController = [self viewControllerForIndex:fromIndex];
    DDBaseViewController *toViewController = [self viewControllerForIndex:toIndex];
    
    self.currentViewControllerIndex = toIndex;
    
    [self adjustToViewController:toViewController];

    [self viewControllersWillTransitFrom:fromViewController to:toViewController];
    
    // Remove previous viewcontroller's view
    [fromViewController.view removeFromSuperview];
    [self.containerView removeFromSuperview];
    
    // Adjust view container
    
    toViewController.view.frame = self.containerView.bounds;
    
    // Add new viewcontroller's view to container
    [self.containerView addSubview:toViewController.view];
    [self.view addSubview:self.containerView];
    [self.view bringSubviewToFront:self.containerView];
    [self viewControllersDidTransitFrom:fromViewController to:toViewController];
    
    //  Adjust Top Views
    [self adjustAlwaysOnTopViews];
}

- (void)viewControllersWillTransitFrom:(UIViewController *)fromViewController to:(UIViewController *)toViewController {
    
}

- (void)viewControllersDidTransitFrom:(UIViewController *)fromViewController to:(UIViewController *)toViewController {
    
   
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(self.containerEdgeInset.left, self.containerEdgeInset.top, self.view.width - self.containerEdgeInset.left - self.containerEdgeInset.right, self.view.height - self.containerEdgeInset.top - self.containerEdgeInset.bottom)];
    [self.containerView fullfillPrarentView];
    self.containerView.autoresizesSubviews = YES;
    [self.view addSubview:self.containerView];
    
    //  Load Child ViewController View
    [self switchToIndex:self.currentViewControllerIndex];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark Management




#pragma mark -
#pragma mark Override

-(void)dismissModalViewControllerAnimated:(BOOL)animated{
	[self.visibleViewController dismissModalViewControllerAnimated:animated];
	[super dismissModalViewControllerAnimated:animated];
}

@end
