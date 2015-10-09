//
//  DDTabBar.h
//  PAPA
//
//  Created by Tong on 28/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTabBar;
@class DDTabBarButton;
@class DDTabBarItem;

@protocol DDTabBarDelegate <NSObject>

@optional
- (void)tabBar:(DDTabBar *)caller anotherTabDidPressed:(NSUInteger)theTag;
- (void)tabBar:(DDTabBar *)caller tabDidLongPressed:(NSUInteger)theTag;
- (void)tabBar:(DDTabBar *)caller sameTabDidPressed:(NSUInteger)theTag;
- (void)tabBar:(DDTabBar *)caller customHandleTabDidPressed:(NSUInteger)theTag;

@end

@interface DDTabBar : UIView

@property (nonatomic, weak) id<DDTabBarDelegate> delegate;
@property (nonatomic, assign) NSInteger currentIndex;
@property (nonatomic, strong) UIColor *lineColor;

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems bottom:(CGFloat)bottom height:(CGFloat)height;

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems backgrounImage:(UIImage *)image bottom:(CGFloat)bottom height:(CGFloat)height topLineColor:(UIColor *)topLineColor;

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems backgrounImage:(UIImage *)image bottom:(CGFloat)bottom height:(CGFloat)height;

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems backgrounImage:(UIImage *)image bottom:(CGFloat)bottom frame:(CGRect)frame;

- (DDTabBarItem *)tabBarItemForIndex:(NSInteger)index;
- (DDTabBarButton *)tabBarButtonForIndex:(NSInteger)index;

- (void)reloadWithTabBarItems:(NSArray *)tabBarItems;

- (void)reloadData;

- (void)setBadgeCount:(NSInteger)badgeCount forIndex:(NSInteger)index;
- (void)setBadgeCount:(NSInteger)badgeCount forIndex:(NSInteger)index badgeCenterPoint:(CGPoint)centerPoint;

@end
