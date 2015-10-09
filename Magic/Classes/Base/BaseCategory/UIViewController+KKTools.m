//
//  UIViewController+KKTools.m
//  Magic
//
//  Created by lixiang on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "UIViewController+KKTools.h"
#import "KKStatManager.h"

@implementation UIViewController (KKTools)

- (void)uploadLinkViewControllerGatherLog {
    if (!self.gatherLogEnable) {
        return;
    }
    
    [[KKStatManager getInstance] addStatObject:@{@"vcName":self.vcName, @"vcLength":@([[NSDate date] safeTimeIntervalSinceDate:self.viewAppearDate])} forType:KKGatherLogTypeViewControllerLength];
}

@end
