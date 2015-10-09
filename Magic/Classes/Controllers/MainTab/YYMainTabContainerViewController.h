//
//  YYMainTabContainerViewController.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDContainerViewController.h"

@interface YYMainTabContainerViewController : DDContainerViewController

+ (YYMainTabContainerViewController *)sharedViewController;

- (void)pushSwitchToIndex:(NSInteger)index;

@end
