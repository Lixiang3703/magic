//
//  KKBonusListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBonusListViewController.h"
#import "KKBonusCellItem.h"
#import "KKBonusCell.h"
#import "KKBonusHeaderCellItem.h"
#import "KKBonusHeaderCell.h"

#import "KKBonusListRequestModel.h"

@interface KKBonusListViewController ()<KKBonusHeaderCellActions>

@property (nonatomic, strong) KKBonusHeaderCellItem *headerCellItem;

@property (nonatomic, strong) KKBonusListRequestModel *listRequestModel;
@property (nonatomic, assign) NSInteger personId;

@end

@implementation KKBonusListViewController

#pragma mark -
#pragma mark Accessor

- (KKBonusListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKBonusListRequestModel alloc] init];
    }
    return _listRequestModel;
}

- (KKBonusHeaderCellItem *)headerCellItem {
    if (_headerCellItem == nil) {
        _headerCellItem = [[KKBonusHeaderCellItem alloc] init];
    }
    return _headerCellItem;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    self.requestModel = self.listRequestModel;
}

- (instancetype)initWithPersonId:(NSInteger)personId {
    self = [self init];
    if (self) {
        self.personId = personId;
        self.listRequestModel.userId = personId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"积分中心")];
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
}

- (void)insertTestCellItems {
    [self.dataSource clear];
    
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    [defaultCellItems addSafeObject:self.headerCellItem];
    
    for (int i = 0; i < 10; i ++) {
        KKBonusCellItem *cellItem = [[KKBonusCellItem alloc] init];
        [defaultCellItems addSafeObject:cellItem];
    }
    
    [self.dataSource addCellItems:defaultCellItems];
}

#pragma mark -
#pragma mark TableView

- (Class)cellItemClass {
    return [KKBonusCellItem class];
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
    
    if (!requestModel.isLoadingMore) {
        self.headerCellItem.bonus = self.listRequestModel.bonus;
        [self.dataSource insertCellItem:self.headerCellItem atIndex:0];
    }
    
}

#pragma mark -
#pragma mark KKBonusHeaderCellActions

- (void)kkBonusHeaderButtonPressed:(NSDictionary *)info {
    [UIAlertView postAlertWithMessage:@"功能还未开通，敬请期待"];
}

@end
