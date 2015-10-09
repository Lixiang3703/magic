//
//  UINavigationController+Tools.m
//  Wuya
//
//  Created by Tong on 13/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UINavigationController+Tools.h"
#import "AppDelegate.h"


@implementation UINavigationController (Tools)

+ (UINavigationController *)appNavigationController {
    return (UINavigationController *)[AppDelegate sharedAppDelegate].window.rootViewController;
}

- (void)safePushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (nil != viewController) {
        [self pushViewController:viewController animated:animated];
    }
}

+ (void)dismissAllViewControllerAnimated:(BOOL)animated {
    UINavigationController *rootNavigationController = [UINavigationController appNavigationController];
    [rootNavigationController.visibleViewController dismissViewControllerAnimated:animated completion:^{}];
    [rootNavigationController.topViewController dismissViewControllerAnimated:animated completion:^{}];
    [rootNavigationController dismissViewControllerAnimated:animated completion:^{}];
}

@end
