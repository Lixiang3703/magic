//
//  KKCaseContainerViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseContainerViewController.h"
#import "DDTabBarGlobal.h"

#import "KKCaseListViewController.h"

@interface KKCaseContainerViewController ()<DDTabBarDelegate>

@property (nonatomic, strong) DDTabBar *tabBar;

@end

@implementation KKCaseContainerViewController

#pragma mark -
#pragma mark Initialization

- (void)initSettings {
    [super initSettings];
    
    UIViewController *vc0 = [[KKCaseListViewController alloc] init];
    UIViewController *vc1 = [[KKCaseListViewController alloc] init];
    
    [self initSettingsWithViewControllers:@[vc0, vc1]];
    
    self.containerEdgeInset = UIEdgeInsetsMake(kDDSegmentBarHeight, 0, 0, 0);
}


#pragma mark -
#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  TabBar
    DDTabBarItem *tabBarItem0 = [[DDTabBarItem alloc] initWithTitle:_(@"新创建")
                                                          imageName:nil
                                                  selectedImageName:nil
                                                    backgroundImage:[UIImage yyDarkUnderlineImage]
                                                               font:[UIFont systemFontOfSize:16]
                                              backgroundNormalColor:nil
                                             backgroundInverseColor:nil
                                                   titleNormalColor:nil
                                                  titleInverseColor:[UIColor blackColor]];
    tabBarItem0.edgeInsets = UIEdgeInsetsMake(2, 0, 5, 0);
    tabBarItem0.badgeViewtype = DDBadgeViewTypeSmall;
    
    
    
    DDTabBarItem *tabBarItem1 = [[DDTabBarItem alloc] initWithTitle:_(@"待支付")
                                                          imageName:nil
                                                  selectedImageName:nil
                                                    backgroundImage:[UIImage yyDarkUnderlineImage]
                                                               font:[UIFont systemFontOfSize:16]
                                              backgroundNormalColor:nil
                                             backgroundInverseColor:nil
                                                   titleNormalColor:nil
                                                  titleInverseColor:[UIColor blackColor]];
    tabBarItem1.edgeInsets = UIEdgeInsetsMake(2, 0, 5, 0);
    tabBarItem1.badgeViewtype = DDBadgeViewTypeMiddle;
    
    DDTabBarItem *tabBarItem2 = [[DDTabBarItem alloc] initWithTitle:_(@"已支付")
                                                          imageName:nil
                                                  selectedImageName:nil
                                                    backgroundImage:[UIImage yyDarkUnderlineImage]
                                                               font:[UIFont systemFontOfSize:16]
                                              backgroundNormalColor:nil
                                             backgroundInverseColor:nil
                                                   titleNormalColor:nil
                                                  titleInverseColor:[UIColor blackColor]];
    tabBarItem2.edgeInsets = UIEdgeInsetsMake(2, 0, 5, 0);
    tabBarItem2.badgeViewtype = DDBadgeViewTypeMiddle;
    
    
    // Tabbar
    CGFloat bottom = kDDSegmentBarHeight;
    self.tabBar = [[DDTabBar alloc] initWithTabBarItems:@[tabBarItem0, tabBarItem1, tabBarItem2] backgrounImage:[UIImage yyLightUnderlineImage] bottom:bottom height:kDDSegmentBarHeight];
    self.tabBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    self.tabBar.delegate = self;
    
    [self.view addSubview:self.tabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark DDTabBarDelegate

- (void)tabBar:(DDTabBar *)caller anotherTabDidPressed:(NSUInteger)theTag {
    
    [self switchToIndex:theTag];
}

- (void)tabBar:(DDTabBar *)caller sameTabDidPressed:(NSUInteger)theTag {
    
}
@end
