//
//  KKUserListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKUserListViewController.h"
#import "KKUserOneCellItem.h"
#import "KKUserOneCell.h"

#import "KKUserChildrenListRequestModel.h"
#import "KKUserInfoItem.h"

#import "KKCaseListViewController.h"
#import "KKBonusListViewController.h"
#import "KKPersonItem.h"

@interface KKUserListViewController ()<KKUserOneCellActions>

@property (nonatomic, strong) KKUserChildrenListRequestModel *listRequestModel;

@end

@implementation KKUserListViewController

#pragma mark -
#pragma mark Accessor

- (KKUserChildrenListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKUserChildrenListRequestModel alloc] init];
    }
    return _listRequestModel;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    
    self.listRequestModel.parentId = [KKUserInfoItem sharedItem].personItem.kkId;
    self.requestModel = self.listRequestModel;
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
    [self setNaviTitle:_(@"我的客户")];
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
//    [self insertTestCellItems];
}

- (void)insertTestCellItems {
    [self.dataSource clear];
    
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    for (int i = 0; i < 10; i ++) {
        KKUserOneCellItem *cellItem = [[KKUserOneCellItem alloc] init];
        [defaultCellItems addSafeObject:cellItem];
    }
    
    [self.dataSource addCellItems:defaultCellItems];
}

#pragma mark -
#pragma mark YYBaseTableViewController Templates

- (Class)cellItemClass {
    return [KKUserOneCellItem class];
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
}

- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(YYBaseCellItem *)cellItem {
    return YES;
}

#pragma mark -
#pragma mark KKUserOneCellActions

- (void)kkUserOneCellButtonPressed:(NSDictionary *)info {
    UIButton *button = [info objectForSafeKey:kDDTableView_Action_Key_Control];
    KKUserOneCellItem *cellItem = [info objectForKey:kDDTableView_Action_Key_CellItem];
//    KKUserOneCell *cell = [info objectForKey:kDDTableView_Action_Key_Cell];
    
    KKPersonItem *personItem = cellItem.rawObject;
    if (!personItem || ![personItem isKindOfClass:[KKPersonItem class]]) {
        return;
    }
    
    if (button && [button isKindOfClass:[UIButton class]]) {
        switch (button.tag) {
            case 1:
            {
                KKCaseListViewController *vc = [[KKCaseListViewController alloc] initWithPersonId:personItem.kkId];
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                
            }
                break;
            default:
                break;
        }
    }
    
}

@end
