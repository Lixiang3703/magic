//
//  KKLawListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKLawListViewController.h"
#import "KKLawListRequestModel.h"

@interface KKLawListViewController ()

@end

@implementation KKLawListViewController

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    self.requestModel = [[KKLawListRequestModel alloc] init];
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
    [self setNaviTitle:_(@"法律法规")];
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
}

#pragma mark -
#pragma mark UITableView

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
    
    for (KKDynamicCellItem *cellItem in cellItems) {
        if ([cellItem isKindOfClass:[KKDynamicCellItem class]]) {
            cellItem.singleLine = YES;
            cellItem.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
    }
}

@end
