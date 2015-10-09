//
//  KKIndexViewController.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKIndexViewController.h"

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"
#import "KKSettingCellItem.h"
#import "KKSettingCell.h"

#import "KKMultiImageCellItem.h"
#import "KKMultiImageCell.h"

#import "KKCaseNewIndexCellItem.h"
#import "KKCaseNewIndexCell.h"


#import "KKCaseListViewController.h"
#import "KKCaseTypeListViewController.h"
#import "KKNewsListViewController.h"
#import "KKLawListViewController.h"
#import "YYEmbedURLViewController.h"
#import "KKInfoViewController.h"
#import "KKDynamicDetailViewController.h"

#import "KKBroadcastListRequestModel.h"

@interface KKIndexViewController ()<KKMultiImageCellActions,KKCaseNewIndexCellActions>

@property (nonatomic, strong) KKMultiImageCellItem *bannerCellItem;
@property (nonatomic, strong) KKCaseNewIndexCellItem *myIndexCellItem;
@property (nonatomic, strong) KKBroadcastListRequestModel *broadcastRequestModel;

@end

@implementation KKIndexViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseNewIndexCellItem *)myIndexCellItem {
    if (_myIndexCellItem == nil) {
        _myIndexCellItem = [[KKCaseNewIndexCellItem alloc] init];
    }
    return _myIndexCellItem;
}

- (KKMultiImageCellItem *)bannerCellItem {
    if (_bannerCellItem == nil) {
        _bannerCellItem = [[KKMultiImageCellItem alloc] init];
        _bannerCellItem.cellHeight = kMultiImageCell_Relative_Height * [UIDevice screenWidth] / 320;
    }
    return _bannerCellItem;
}

- (KKBroadcastListRequestModel *)broadcastRequestModel {
    if (_broadcastRequestModel == nil) {
        __weak __typeof(self)weakSelf = self;
        _broadcastRequestModel = [[KKBroadcastListRequestModel alloc] init];
        _broadcastRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKBroadcastListRequestModel* requestModel) {
            weakSelf.bannerCellItem.imageItemArray = requestModel.imageItemArray;
            
            [weakSelf reloadMyDataSource];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.refreshControl endRefreshing];
        };
        _broadcastRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
            [weakSelf.tableView.refreshControl endRefreshing];
        };
    }
    return _broadcastRequestModel;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = NO;
    self.tableView.hasRefreshControl = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"width:%f",[UIDevice screenWidth]);
    NSLog(@"height:%f",[UIDevice screenHeight]);
    
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL viewDidAppear = self.viewDidAppear;
    [super viewWillAppear:animated];
    if (!viewDidAppear) {
        [self.broadcastRequestModel load];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"知产通")];
    
}

#pragma mark -
#pragma mark TableView

- (void)tableviewWillReload:(UIRefreshControl *)refreshControl {
    [super tableviewWillReload:refreshControl];
    
    [self.broadcastRequestModel load];
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self reloadMyDataSource];
}

- (void)reloadMyDataSource {
    [self.dataSource clear];
    
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    if (self.bannerCellItem.imageItemArray && self.bannerCellItem.imageItemArray.count > 0) {
        [defaultCellItems addSafeObject:self.bannerCellItem];
    }
    else {
        [defaultCellItems addSafeObject:self.bannerCellItem];
    }
    
//    YYGroupHeaderCellItem *groupCellItem = nil;
//    //  Placeholder
//    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_Height title:nil];
//    [defaultCellItems addSafeObject:groupCellItem];
    
//    [defaultCellItems addSafeObject:self.indexCellItem];
    [defaultCellItems addSafeObject:self.myIndexCellItem];
    
//    KKSettingCellItem *baseCellItem = nil;
//    //  Mine Feed
//    baseCellItem = [KKSettingCellItem cellItemWithTitle:_(@"业务办理") detail:nil imageName:@"icon_gray_list2"];
//    baseCellItem.cellStyle = UITableViewCellStyleValue1;
//    baseCellItem.groupBottomSeperatorLineHidden = NO;
//    baseCellItem.groupTopSeperatorLineHidden = NO;
//    baseCellItem.defaultWhiteBgColor = YES;
//    baseCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        
//    };
//    baseCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
//        cell.imageView.left = kUI_TableView_Common_Margin;
//        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
//    };
//    baseCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        KKCaseTypeListViewController *vc = [[KKCaseTypeListViewController alloc] init];
//        [viewController.navigationController pushViewController:vc animated:YES];
//    };
//    [defaultCellItems addSafeObject:baseCellItem];
//    
//    //  Placeholder
//    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
//    [defaultCellItems addSafeObject:groupCellItem];
//    
//    //  Mine Feed
//    baseCellItem = [KKSettingCellItem cellItemWithTitle:_(@"知产动态") detail:nil imageName:@"icon_gray_list2"];
//    baseCellItem.cellStyle = UITableViewCellStyleValue1;
//    baseCellItem.groupBottomSeperatorLineHidden = NO;
//    baseCellItem.groupTopSeperatorLineHidden = NO;
//    baseCellItem.defaultWhiteBgColor = YES;
//    baseCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        
//    };
//    baseCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
//        cell.imageView.left = kUI_TableView_Common_Margin;
//        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
//    };
//    baseCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        KKNewsListViewController *vc = [[KKNewsListViewController alloc] init];
//        [viewController.navigationController pushViewController:vc animated:YES];
//    };
//    [defaultCellItems addSafeObject:baseCellItem];
//    
//    //  Placeholder
//    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
//    [defaultCellItems addSafeObject:groupCellItem];
//    
//    //  Dynamic
//    baseCellItem = [KKSettingCellItem cellItemWithTitle:_(@"法律法规") detail:nil imageName:@"icon_gray_list2"];
//    baseCellItem.cellStyle = UITableViewCellStyleValue1;
//    baseCellItem.groupBottomSeperatorLineHidden = NO;
//    baseCellItem.groupTopSeperatorLineHidden = NO;
//    baseCellItem.seperatorLineHidden = NO;
//    baseCellItem.defaultWhiteBgColor = YES;
//    baseCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        
//    };
//    baseCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
//        cell.imageView.left = kUI_TableView_Common_Margin;
//        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
//    };
//    baseCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        KKLawListViewController *vc = [[KKLawListViewController alloc] init];
//        [viewController.navigationController pushViewController:vc animated:YES];
//    };
//    [defaultCellItems addSafeObject:baseCellItem];
//    
//    //  Placeholder
//    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
//    [defaultCellItems addSafeObject:groupCellItem];
//    
//    //  Dynamic
//    baseCellItem = [KKSettingCellItem cellItemWithTitle:_(@"中理通简介") detail:nil imageName:@"icon_gray_list2"];
//    baseCellItem.cellStyle = UITableViewCellStyleValue1;
//    baseCellItem.groupBottomSeperatorLineHidden = NO;
//    baseCellItem.groupTopSeperatorLineHidden = NO;
//    baseCellItem.seperatorLineHidden = NO;
//    baseCellItem.defaultWhiteBgColor = YES;
//    baseCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        
//    };
//    baseCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
//        cell.imageView.left = kUI_TableView_Common_Margin;
//        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
//    };
//    baseCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
//        NSString *url = @"http://www.baidu.com";
//        YYEmbedURLViewController *vc = [[YYEmbedURLViewController alloc] initWithURLString:url];
//        [viewController.navigationController pushViewController:vc animated:YES];
//    };
//    [defaultCellItems addSafeObject:baseCellItem];
//    
//    // bottom place holder
//    [defaultCellItems addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:50 title:nil]];
    
    [self.dataSource insertTopCellItems:defaultCellItems];
}

#pragma mark -
#pragma mark KKMultiImageCellActions

- (void)kkMultiImagePressed:(NSDictionary *)info {
    UIView *sender = [info objectForSafeKey:kDDTableView_Action_Key_Control];
    
    NSLog(@"sender.tag:%ld", (long)sender.tag);
    
    KKBroadcastItem *item = [self.broadcastRequestModel.resultItems objectAtSafeIndex:sender.tag];
    
    KKDynamicDetailViewController *viewController = [[KKDynamicDetailViewController alloc] initWithDynamicItem:item];
    [self.navigationController pushViewController:viewController animated:YES];
    
//    if (item && [item isKindOfClass:[KKBroadcastItem class]]) {
//        YYEmbedURLViewController *vc = [[YYEmbedURLViewController alloc] initWithURLString:item.url];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
    
}

#pragma mark -
#pragma mark KKCaseNewIndexCellActions

- (void)kkCaseNewIndexButtonPressed:(NSDictionary *)info {
    UIView *sender = [info objectForSafeKey:kDDTableView_Action_Key_Control];
    
    NSLog(@"sender.tag:%ld", (long)sender.tag);
    
    switch (sender.tag) {
        case KKCaseIndexTagTypeInsert:
        {
            KKCaseTypeListViewController *vc = [[KKCaseTypeListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKCaseIndexTagTypeNews:
        {
            KKNewsListViewController *vc = [[KKNewsListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKCaseIndexTagTypeLaw:
        {
            KKLawListViewController *vc = [[KKLawListViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKCaseIndexTagTypeInfo:
        {
//            [UIAlertView postAlertWithMessage:@"此静态界面稍后完成"];
            KKInfoViewController *vc = [[KKInfoViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKCaseIndexTagTypeCompanySearch:
        {
            YYEmbedURLViewController *vc = [[YYEmbedURLViewController alloc] initWithURLString:@"http://zlt.qichacha.com/ECIUI"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKCaseIndexTagTypeTrademarkSearch:
        {
            YYEmbedURLViewController *vc = [[YYEmbedURLViewController alloc] initWithURLString:@"http://zlt.qichacha.com/SAICUI"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end


