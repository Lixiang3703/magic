//
//  DDTabBarButton.h
//  PAPA
//
//  Created by Tong on 28/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTabBarItem;
@class DDBadgeView;

@interface DDTabBarButton : UIButton

@property (nonatomic, strong) DDTabBarItem *tabBarItem;
@property (nonatomic, strong) DDBadgeView *badgeView;


- (id)initWithFrame:(CGRect)frame tabBarItem:(DDTabBarItem *)tabBarItem;

- (void)setTabHighLighted:(BOOL)highLighted;

@end
