//
//  KKCaseTypeListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseTypeListViewController.h"
#import "KKCaseTypeCellItem.h"
#import "KKCaseTypeCell.h"
#import "KKCaseTypeItem.h"
#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKCaseTypeListRequestModel.h"

#import "KKTrademarkCaseInsertViewController.h"
#import "KKCaseInsertViewController.h"
#import "YYEmbedURLViewController.h"

#import "KKClassicsManager.h"
#import "KKLoginManager.h"

@interface KKCaseTypeListViewController ()<KKCaseTypeCellActions>

@property (nonatomic, strong) KKCaseTypeListRequestModel *caseTypeListRequestModel;

@end

@implementation KKCaseTypeListViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseTypeListRequestModel *)caseTypeListRequestModel {
    if (_caseTypeListRequestModel == nil) {
        _caseTypeListRequestModel = [[KKCaseTypeListRequestModel alloc] init];
    }
    return _caseTypeListRequestModel;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
//    self.requestModel = self.caseTypeListRequestModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
    [[KKClassicsManager getInstance] loadIndustryList:^(KKClassicsItem *classicsItem) {
        
    }];
    
//    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"业务办理")];
    
}

#pragma mark -
#pragma mark YYBaseTableViewController Templates

- (Class)cellItemClass {
    return [KKCaseTypeCellItem class];
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
}

- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(YYBaseCellItem *)cellItem {
    return YES;
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(KKCaseTypeCellItem *)cellItem cell:(KKCaseTypeCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    if ( ![KKLoginManager getInstance].isLoggedIn ) {
        [[KKLoginManager getInstance] showLoginControllerWithAnimated:YES];
        return;
    }
    
    KKCaseTypeItem *caseTypeItem = cellItem.rawObject;
    if (![caseTypeItem isKindOfClass:[KKCaseTypeItem class]]) {
        return;
    }
    
    KKBaseCaseInsertViewController *viewController = nil;
    if (caseTypeItem.type == KKCaseTypeTrademark) {
        viewController = [[KKTrademarkCaseInsertViewController alloc] init];
        
    }
    else {
        viewController = [[KKCaseInsertViewController alloc] init];
    }
    
    if (viewController) {
        viewController.caseType = caseTypeItem.type;
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self insertDefaultCellItems];
}

- (void)insertDefaultCellItems {
    [self.dataSource clear];
    
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    KKCaseTypeCellItem *cellItem = nil;
    KKCaseTypeItem *caseTypeItem = nil;
    YYGroupHeaderCellItem *groupCellItem = nil;
    
    cellItem = [[KKCaseTypeCellItem alloc] init];
    caseTypeItem = [[KKCaseTypeItem alloc] init];
    caseTypeItem.type = KKCaseTypeTrademark;
    caseTypeItem.name = @"商标服务";
    cellItem.rawObject = caseTypeItem;
    [defaultCellItems addSafeObject:cellItem];
    
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginW title:nil];
    [defaultCellItems addSafeObject:groupCellItem];
    
    cellItem = [[KKCaseTypeCellItem alloc] init];
    caseTypeItem = [[KKCaseTypeItem alloc] init];
    caseTypeItem.type = KKCaseTypePatent;
    caseTypeItem.name = @"专利服务";
    cellItem.rawObject = caseTypeItem;
    [defaultCellItems addSafeObject:cellItem];
    
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginW title:nil];
    [defaultCellItems addSafeObject:groupCellItem];
    
    cellItem = [[KKCaseTypeCellItem alloc] init];
    caseTypeItem = [[KKCaseTypeItem alloc] init];
    caseTypeItem.type = KKCaseTypeCopyright;
    caseTypeItem.name = @"版权服务";
    cellItem.rawObject = caseTypeItem;
    [defaultCellItems addSafeObject:cellItem];
    
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginW title:nil];
    [defaultCellItems addSafeObject:groupCellItem];
    
    cellItem = [[KKCaseTypeCellItem alloc] init];
    caseTypeItem = [[KKCaseTypeItem alloc] init];
    caseTypeItem.type = KKCaseTypeLegal;
    caseTypeItem.name = @"律师服务";
    cellItem.rawObject = caseTypeItem;
    [defaultCellItems addSafeObject:cellItem];
    
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginW title:nil];
    [defaultCellItems addSafeObject:groupCellItem];
    
    [self.dataSource addCellItems:defaultCellItems];
}


#pragma mark -
#pragma mark KKCaseTypeCellActions

- (void)kkCaseTypeMoreInfoPressed:(NSDictionary *)info {
    NSString *url = @"http://www.baidu.com";
    YYEmbedURLViewController *viewController = [[YYEmbedURLViewController alloc] initWithURLString:url];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end

