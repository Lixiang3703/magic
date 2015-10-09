//
//  KKNewsListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKNewsListViewController.h"
#import "KKNewsListRequestModel.h"

@interface KKNewsListViewController ()


@end

@implementation KKNewsListViewController

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    self.requestModel = [[KKNewsListRequestModel alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"新闻中心")];
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
}

@end


