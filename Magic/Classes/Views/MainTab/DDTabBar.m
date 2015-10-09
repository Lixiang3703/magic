//
//  DDTabBar.m
//  PAPA
//
//  Created by Tong on 28/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import "DDTabBarGlobal.h"

@interface DDTabBar ()

@property (nonatomic, strong) NSArray *tabBarButtons;
@property (nonatomic, strong) NSArray *tabBarItems;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIView *topLineView;

@end

@implementation DDTabBar

#pragma mark -
#pragma mark Accessors

- (void)setCurrentIndex:(NSInteger)currentIndex {
    if (_currentIndex != currentIndex) {
        
        DDTabBarButton *oldTabBarButton = [self tabBarButtonForIndex:_currentIndex];
        DDTabBarButton *newTabBarButton = [self tabBarButtonForIndex:currentIndex];
        
        [oldTabBarButton setTabHighLighted:NO];
        [newTabBarButton setTabHighLighted:YES];
        
        _currentIndex = currentIndex;
    }
}

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems bottom:(CGFloat)bottom height:(CGFloat)height {
    self = [self initWithTabBarItems:tabBarItems backgrounImage:nil bottom:bottom height:height];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems backgrounImage:(UIImage *)image bottom:(CGFloat)bottom height:(CGFloat)height topLineColor:(UIColor *)topLineColor {
    self = [self initWithTabBarItems:tabBarItems backgrounImage:image bottom:bottom height:height];
    if (self) {
        self.topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 1)];
        self.topLineView.backgroundColor = topLineColor ? topLineColor : [UIColor clearColor];
        [self addSubview:self.topLineView];
    }
    return self;
}

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems backgrounImage:(UIImage *)image bottom:(CGFloat)bottom height:(CGFloat)height {
    self = [self initWithTabBarItems:tabBarItems backgrounImage:image bottom:bottom frame:CGRectMake(0, 0, [UIDevice screenWidth], height)];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTabBarItems:(NSArray *)tabBarItems backgrounImage:(UIImage *)image bottom:(CGFloat)bottom frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // UI elements
        self.backgroundColor = [UIColor clearColor];
        
        self.backgroundImageView.backgroundColor = [UIColor clearColor];
        self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.backgroundImageView.image = image ? image :nil;
        [self addSubview:self.backgroundImageView];
        
        //  Default values
        self.clipsToBounds = YES;
        _currentIndex = -1;
        
        //  UI
        self.bottom = bottom;
        [self reloadWithTabBarItems:tabBarItems];
        self.currentIndex = 0;
    }
    return self;
}


#pragma mark -
#pragma mark Logic

- (DDTabBarButton *)tabBarButtonForIndex:(NSInteger)index {
    if (index < 0 || index >= [self.tabBarButtons count]) {
        return nil;
    }
    return [self.tabBarButtons objectAtIndex:index];
}

- (DDTabBarItem *)tabBarItemForIndex:(NSInteger)index{
    if (index < 0 || index >= [self.tabBarButtons count]) {
        return nil;
    }
    return [self.tabBarItems objectAtIndex:index];
}

- (void)reloadData{
    if ([self.tabBarItems count]) {
        [self reloadWithTabBarItems:self.tabBarItems];
    }
}

- (void)reloadWithTabBarItems:(NSArray *)tabBarItems{
    if ([tabBarItems count] == 0) {
        return;
    }
    if (self.tabBarItems != tabBarItems) {
        self.tabBarItems = [tabBarItems copy];
    }
    
    //clear dataSoure
    if ([self.tabBarButtons count]) {
        [self.tabBarButtons enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            DDTabBarButton *tabbarButton = (DDTabBarButton *)obj;
            [tabbarButton removeFromSuperview];
        }];
        self.tabBarButtons = nil;
    }
    
    //create  BarButtons
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = roundf(self.width / [tabBarItems count]);
    CGFloat h = self.height;
    
    DDTabBarButton *tabBarButton = nil;
    NSMutableArray *tabBarButtons = [NSMutableArray arrayWithCapacity:[tabBarItems count]];
    int index = 0;
    for (DDTabBarItem *tabBarItem in tabBarItems) {
        tabBarButton = [[DDTabBarButton alloc] initWithFrame:CGRectMake(x, y, w, h) tabBarItem:tabBarItem];
        //  Tap
        if (tabBarItem.customHandle) {
            [tabBarButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        } else {
            [tabBarButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchDown];
        }
        
        if (tabBarItem.doubleTapHandle) {
            UILongPressGestureRecognizer *longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(buttonLongPressed:)];
            [tabBarButton addGestureRecognizer:longPressGestureRecognizer];
        }
        tabBarButton.tag = index;
        x += w;
        [self addSubview:tabBarButton];
        [tabBarButtons addObject:tabBarButton];
        index++;
    }
    
    self.tabBarButtons = tabBarButtons;
    DDTabBarButton *newTabBarButton = [self tabBarButtonForIndex:self.currentIndex];
    [newTabBarButton setTabHighLighted:YES];
}

#pragma mark -
#pragma mark Buttons

- (void)buttonPressed:(DDTabBarButton *)sender {
    DDTabBarItem *tabBarItem = sender.tabBarItem;
    
    if (tabBarItem.customHandle && [self.delegate respondsToSelector:@selector(tabBar:customHandleTabDidPressed:)]) {
        [self.delegate tabBar:self customHandleTabDidPressed:sender.tag];
        return;
    }
    
    if (self.currentIndex == sender.tag) {
        if ([self.delegate respondsToSelector:@selector(tabBar:sameTabDidPressed:)]) {
            [self.delegate tabBar:self sameTabDidPressed:sender.tag];
        }
    } else {

        self.currentIndex = sender.tag;
        
        if ([self.delegate respondsToSelector:@selector(tabBar:anotherTabDidPressed:)]) {
            [self.delegate tabBar:self anotherTabDidPressed:sender.tag];
        }
        
    }
}

- (void)buttonLongPressed:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan && [self.delegate respondsToSelector:@selector(tabBar:tabDidLongPressed:)]) {
        UIView *button = gesture.view;
        [self.delegate tabBar:self tabDidLongPressed:button.tag];
    }
}

#pragma mark -
#pragma mark Badge
- (void)setBadgeCount:(NSInteger)badgeCount forIndex:(NSInteger)index {
    DDTabBarButton *button = [self tabBarButtonForIndex:index];
    
    [button.badgeView setBadgeCount:badgeCount];
}

- (void)setBadgeCount:(NSInteger)badgeCount forIndex:(NSInteger)index badgeCenterPoint:(CGPoint)centerPoint {
    DDTabBarButton *button = [self tabBarButtonForIndex:index];
    centerPoint.x = button.width/2 + 10;
    button.badgeView.centerPoint = centerPoint;
    [button.badgeView setBadgeCount:badgeCount];
}


@end
