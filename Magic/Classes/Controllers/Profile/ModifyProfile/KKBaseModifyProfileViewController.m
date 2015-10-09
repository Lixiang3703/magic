//
//  KKBaseModifyProfileViewController.m
//  Magic
//
//  Created by lixiang on 15/5/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBaseModifyProfileViewController.h"
#import "KKUserInfoItem.h"

@interface KKBaseModifyProfileViewController ()

@end

@implementation KKBaseModifyProfileViewController

#pragma mark -
#pragma mark Accessor

- (KKPersonItem *)personItem {
    if (_personItem == nil) {
        _personItem = [KKUserInfoItem sharedItem].personItem;
    }
    return _personItem;
}

- (KKPersonItem *)modifyPersonItem {
    if (_modifyPersonItem == nil) {
        _modifyPersonItem = [[KKPersonItem alloc] init];
    }
    return _modifyPersonItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
