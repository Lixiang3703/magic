//
//  YYMainTabContainerViewController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYMainTabContainerViewController.h"

#import "KKTest1ViewController.h"
#import "KKIndexViewController.h"
#import "KKCallViewController.h"
#import "KKMessageListViewController.h"
#import "KKMineViewController.h"

#import "KKLoginManager.h"
#import "KKUnreadInfoItem.h"

#import "DDTabBarGlobal.h"
#import "KKLauncher.h"
#import "KKBasePhoneManager.h"

@interface YYMainTabContainerViewController () <DDTabBarDelegate>

@property (nonatomic, strong) DDTabBar *tabBar;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YYMainTabContainerViewController


#pragma mark -
#pragma mark Initialization

- (void)initSettings {
    [super initSettings];
    
    UIViewController *vc0 = [[KKIndexViewController alloc] init];
    UIViewController *vc1 = [[KKMessageListViewController alloc] init];
    UIViewController *vc2 = [[KKCallViewController alloc] init];
    UIViewController *vc3 = [[KKMineViewController alloc] init];
    
    [self initSettingsWithViewControllers:@[vc0, vc1, vc2, vc3]];
    
    self.containerEdgeInset = UIEdgeInsetsMake(0, 0, kDDTabBarHeight, 0);
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    //  TabBar
    DDTabBarItem *tabBarItem0 = [[DDTabBarItem alloc] initWithTitle:_(@"首页") imageName:@"tabbar_icon_index" selectedImageName:@"tabbar_icon_index_h"];
    tabBarItem0.badgeViewtype = DDBadgeViewTypeSmall;
    
    DDTabBarItem *tabBarItem1 = [[DDTabBarItem alloc] initWithTitle:_(@"通知") imageName:@"tabbar_icon_message" selectedImageName:@"tabbar_icon_message_h"];
    tabBarItem1.badgeViewtype = DDBadgeViewTypeLarge;
    
    DDTabBarItem *tabBarItem2 = [[DDTabBarItem alloc] initWithTitle:_(@"客服") imageName:@"icon_gray_call" selectedImageName:@"icon_gray_call"];
    tabBarItem2.badgeViewtype = DDBadgeViewTypeSmall;
    
    DDTabBarItem *tabBarItem3 = [[DDTabBarItem alloc] initWithTitle:_(@"我的") imageName:@"tabbar_icon_mine" selectedImageName:@"tabbar_icon_mine_h"];
    tabBarItem3.badgeViewtype = DDBadgeViewTypeLarge;
    
    // Tabbar
    self.tabBar = [[DDTabBar alloc] initWithTabBarItems:@[tabBarItem0, tabBarItem1, tabBarItem2, tabBarItem3] backgrounImage:[UIImage yyMainBlackColorImage] bottom:self.view.height height:kDDTabBarHeight topLineColor:[UIColor YYMainTabbarTopLineColor]];
    self.tabBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.tabBar.delegate = self;
    
    [self.view addSubview:self.tabBar];
    
    [self addAlwaysOnTopView:self.tabBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [[KKLauncher getInstance] checkUnreadInfo];
    
    //  Revert ViewController
    self.navigationController.viewControllers = @[self];
}

#pragma mark -
#pragma mark Notifications
- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadInfoUpdate:) name:kLinkNotification_Unread_Update object:nil];
}


- (void)unreadInfoUpdate:(NSNotification *)notification {
    KKUnreadInfoItem *unreadInfoItem = [KKUnreadInfoItem sharedItem];
    
    [self.tabBar setBadgeCount:unreadInfoItem.newFansCount forIndex:KKMainTabIndexMine badgeCenterPoint:CGPointMake(70, 11)];
    [self.tabBar setBadgeCount:unreadInfoItem.newMsg forIndex:KKMainTabIndexMessage badgeCenterPoint:CGPointMake(70, 11)];
}

#pragma mark -
#pragma mark Instance
+ (YYMainTabContainerViewController *)sharedViewController {
    YYMainTabContainerViewController *viewController = [[UINavigationController appNavigationController].viewControllers firstObject];
    if (![viewController isKindOfClass:[YYMainTabContainerViewController class]]) {
        viewController = nil;
    }
    return viewController;
}


#pragma mark -
#pragma mark DDTabBarDelegate

- (void)tabBar:(DDTabBar *)caller anotherTabDidPressed:(NSUInteger)theTag {
    
    if (theTag == KKMainTabIndexCall) {
        self.tabBar.currentIndex = self.currentIndex;
        [[self.tabBar tabBarButtonForIndex:self.currentIndex] setTabHighLighted:YES];
        
        [[KKBasePhoneManager getInstance] makePhoneForService];
        return;
    }
    
    if ( ![KKLoginManager getInstance].isLoggedIn && (theTag == KKMainTabIndexMine || theTag == KKMainTabIndexMessage )) {
        [[KKLoginManager getInstance] showLoginControllerWithAnimated:YES];
        
        self.tabBar.currentIndex = self.currentIndex;
        [[self.tabBar tabBarButtonForIndex:self.currentIndex] setTabHighLighted:YES];
        
        return;
    }
    
    [self gotoIndex:theTag];
    
    [[KKLauncher getInstance] checkUnreadInfo];
}

- (void)tabBar:(DDTabBar *)caller sameTabDidPressed:(NSUInteger)theTag {
    [[KKLauncher getInstance] checkUnreadInfo];
    
    DDBaseTableViewController *tableViewController = (DDBaseTableViewController *)self.currentChildViewController;
    if (tableViewController && [tableViewController isKindOfClass:[DDBaseTableViewController class]]) {
        [tableViewController dragDownRefresh];
    }
}

#pragma mark -
#pragma mark ChildViewController Operations

- (void)pushSwitchToIndex:(NSInteger)index {
//    YYBaseTableViewController *viewController = (YYBaseTableViewController *)[self viewControllerForIndex:index];
//    viewController.needRefreshWhenViewDidAppear = YES;
    
    [self gotoIndex:index];
    self.tabBar.currentIndex = index;
}

- (void)gotoIndex:(NSInteger)index {
    self.currentIndex = index;
    self.tabBar.currentIndex = index;
    [self switchToIndex:index];
}


@end
