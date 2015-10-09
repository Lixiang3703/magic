//
//  UIViewController+Tools.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Tools)

@property (nonatomic, assign) BOOL gatherLogEnable;

@property (nonatomic, assign) BOOL viewDidAppear;
@property (nonatomic, strong) NSDate *viewAppearDate;

- (NSString *)vcName;
- (NSString *)vcClassName;
- (void)uploadViewControllerGatherLog;


@end


@interface UIViewController (TStoryBoard)

+ (UIViewController *)viewControllerWithClass:(Class)className;
+ (UIViewController *)viewControllerWithClassName:(NSString *)className;

@end