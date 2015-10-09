//
//  YYBaseViewController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseViewController.h"
#import "DDTActionSheet.h"
#import "KKStatManager.h"

@interface YYBaseViewController ()

@end

@implementation YYBaseViewController

#pragma mark -
#pragma mark Initalization
- (void)initSettings {
    [super initSettings];
    
}

#pragma mark -
#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    self.view.backgroundColor = [UIColor YYViewBgColor];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //  Stat
    if (self.gatherLogEnable) {
        [[KKStatManager getInstance] addStatObject:self.vcName forType:KKGatherLogTypeViewControllerWillAppear];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Stat
    [self uploadLinkViewControllerGatherLog];
    
    if (self.gatherLogEnable) {
        [[KKStatManager getInstance] addStatObject:self.vcName forType:KKGatherLogTypeViewControllerWillDisappear];
    }
}

@end
