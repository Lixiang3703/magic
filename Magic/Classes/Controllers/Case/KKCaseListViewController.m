//
//  KKCaseListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseListViewController.h"
#import "KKCaseCell.h"
#import "KKCaseCellItem.h"
#import "KKCaseItem.h"
#import "KKCaseListRequestModel.h"
#import "KKCaseDetailViewController.h"
#import "KKCaseFieldManager.h"

@interface KKCaseListViewController ()

@property (nonatomic, strong) KKCaseListRequestModel *listRequestModel;
@property (nonatomic, assign) NSInteger personId;
@property (nonatomic, assign) KKCaseStatusType status;

@end

@implementation KKCaseListViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKCaseListRequestModel alloc] init];
    }
    return _listRequestModel;
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
        self.listRequestModel.authorId = personId;
    }
    return self;
}

- (instancetype)initWithPersonId:(NSInteger)personId status:(NSInteger)status {
    self = [self init];
    if (self) {
        self.personId = personId;
        self.status = status;
        self.listRequestModel.authorId = personId;
        self.listRequestModel.status = status;
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
#pragma mark Notification

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(caseDeleteSuccess:) name:kNotification_Case_Delete_Success object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(casePaySuccess:) name:kNotification_Case_Pay_Success object:nil];
}

- (void)caseDeleteSuccess:(NSNotification *)notification {
    self.needRefreshWhenViewDidAppear = YES;
}

- (void)casePaySuccess:(NSNotification *)notification {
    self.needRefreshWhenViewDidAppear = YES;
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"业务列表")];
    
    if (self.status > KKCaseStatusTypeUnKnown && self.status < KKCaseStatusTypeCount) {
        [self setNaviTitle:[[KKCaseFieldManager getInstance] titleForCaseStatusType:self.status]];
    }
}

#pragma mark -
#pragma mark YYBaseTableViewController Templates

- (Class)cellItemClass {
    return [KKCaseCellItem class];
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
}

- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(YYBaseCellItem *)cellItem {
    return YES;
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    KKCaseItem *caseItem = cellItem.rawObject;
    if (caseItem && [caseItem isKindOfClass:[KKCaseItem class]]) {
        KKCaseDetailViewController *viewController = [[KKCaseDetailViewController alloc] initWithCaseItem:caseItem];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

@end
