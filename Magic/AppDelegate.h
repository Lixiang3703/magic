//
//  AppDelegate.h
//  Magic
//
//  Created by lixiang on 15/4/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (AppDelegate *)sharedAppDelegate;

- (void)payWithOrderItem;
@end

