//
//  KKRegisterEULAViewController.m
//  Link
//
//  Created by Lixiang on 15/1/10.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKRegisterEULAViewController.h"

@interface KKRegisterEULAViewController ()

@property (nonatomic, strong) UITextView *textView;

@end

@implementation KKRegisterEULAViewController

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    [self.textView fullfillPrarentView];
    
    self.textView.backgroundColor = [UIColor whiteColor];
    self.textView.editable = NO;
    
    [self.view addSubview:self.textView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"eula" ofType:@"txt"];
    NSString *rawString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    self.textView.text = [NSString stringWithFormat:@"\n%@", rawString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setNaviTitle:@"使用协议"];
    
//    [self setLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"返回") target:self action:@selector(backButtonPressed:)] animated:animated];
    
}

#pragma mark -
#pragma mark Buttons

- (void)backButtonPressed:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
