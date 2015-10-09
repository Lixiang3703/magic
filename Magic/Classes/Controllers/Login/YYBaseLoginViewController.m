//
//  YYBaseLoginViewController.m
//  Link
//
//  Created by Lixiang on 14/11/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseLoginViewController.h"

@interface YYBaseLoginViewController () <UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;

@end

@implementation YYBaseLoginViewController

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
    
}

#pragma mark -
#pragma mark Gesture
- (void)gesture:(UIGestureRecognizer *)gesture {
    UITextField *textField = (UITextField *)[self.view.window findFirstResponder];
    if ([textField isKindOfClass:[UITextField class]]) {
        [textField resignFirstResponder];
    }
}

@end
