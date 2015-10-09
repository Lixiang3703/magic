//
//  UINavigationController+Tools.h
//  Wuya
//
//  Created by Tong on 13/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (Tools)

+ (UINavigationController *)appNavigationController;
- (void)safePushViewController:(UIViewController *)viewController animated:(BOOL)animated;

+ (void)dismissAllViewControllerAnimated:(BOOL)animated;

@end
