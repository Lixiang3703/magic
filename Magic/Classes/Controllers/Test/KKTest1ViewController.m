//
//  KKTest1ViewController.m
//  Magic
//
//  Created by lixiang on 15/4/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKTest1ViewController.h"

@interface KKTest1ViewController ()

@end

@implementation KKTest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setNaviTitle:@"Navi"];
}

@end
