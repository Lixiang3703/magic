//
//  YYPlaceholderViewController.m
//  Wuya
//
//  Created by Tong on 28/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYPlaceholderViewController.h"

@interface YYPlaceholderViewController ()

@end

@implementation YYPlaceholderViewController

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setTitle:_(@"乌鸦")];
}

@end
