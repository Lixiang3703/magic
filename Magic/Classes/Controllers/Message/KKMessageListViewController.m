//
//  KKMessageListViewController.m
//  Magic
//
//  Created by lixiang on 15/4/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMessageListViewController.h"

#import "KKMessageCellItem.h"
#import "KKMessageCell.h"
#import "KKMessageItem.h"

#import "KKMessageListRequestModel.h"
#import "KKMessageClearRequestModel.h"
#import "KKUnreadInfoItem.h"

#import "KKCaseDetailViewController.h"
#import "KKCaseMessageViewController.h"

@interface KKMessageListViewController ()

@end

@implementation KKMessageListViewController

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
    
    //  Request Model
    self.requestModel = [[KKMessageListRequestModel alloc] init];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"通知中心")];
    
//    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"清空") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

- (void)rightBarButtonItemClick:(id)sender {
    
    [UIAlertView postAlertWithMessage:@"因为数据不多，暂时先禁掉这个功能"];
    return;
    
//    KKMessageClearRequestModel *requestModel = [[KKMessageClearRequestModel alloc] init];
//    
//    __weak __typeof(self) weakSelf = self;
//    
//    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKMessageClearRequestModel *requestModel) {
//        [weakSelf dragDownRefresh];
//        
//        [KKUnreadInfoItem sharedItem].newMsg = 0;
//        [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_Unread_Update object:nil userInfo:nil];
//        
//    };
//    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKMessageClearRequestModel *requestModel) {
//        
//    };
//    [requestModel load];
}


#pragma mark -
#pragma mark RequestModel Handler Templates

- (void)tableViewDidUpdateWithRequestModel:(YYBaseRequestModel *)requestModel {
    [super tableViewDidUpdateWithRequestModel:requestModel];
    
    if (!requestModel.isLoadingMore) {
        [self updateNavigationBar:NO];
    }
}


- (Class)cellItemClass {
    return [KKMessageCellItem class];
}

- (void)cellItemsDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsDidAddWithRequestModel:requestModel cellItems:cellItems];
    
    if (!requestModel.isLoadingMore && !requestModel.didUseLocalData) {
        [self updateUnreadStateAnimated:NO];
    }
}

- (void)tableViewWillUpdateWithRequestModel:(YYBaseRequestModel *)requestModel {
    [super tableViewWillUpdateWithRequestModel:requestModel];
    
    
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    if ([cellItem isKindOfClass:[KKMessageCellItem class]]) {
        
        KKMessageItem *messageItem = cellItem.rawObject;
        if (![messageItem isKindOfClass:[KKMessageItem class]]) {
            return;
        }
        if (messageItem.type == KKMessageTypeCaseStatus && messageItem.caseItem) {
            KKCaseDetailViewController *viewController = [[KKCaseDetailViewController alloc] initWithItemId:messageItem.caseId];
            if (messageItem.hasRead != DDBaseItemBoolTrue) {
                viewController.messageId = messageItem.kkId;
                [KKUnreadInfoItem sharedItem].newMsg --;
                [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_Unread_Update object:nil userInfo:nil];
                messageItem.hasRead = DDBaseItemBoolTrue;
                [self.tableView reloadData];
            }
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else if (messageItem.type == KKMessageTypeCaseMessage) {
            KKCaseMessageViewController *viewController = [[KKCaseMessageViewController alloc] initWithItemId:messageItem.caseMsgId];
            if (messageItem.hasRead != DDBaseItemBoolTrue) {
                viewController.messageId = messageItem.kkId;
                [KKUnreadInfoItem sharedItem].newMsg --;
                [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_Unread_Update object:nil userInfo:nil];
                messageItem.hasRead = DDBaseItemBoolTrue;
                [self.tableView reloadData];
            }
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}


#pragma mark -
#pragma mark

- (void)updateUnreadStateAnimated:(BOOL)animated {
    
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
        KKMessageCellItem *cellItem = [[KKMessageCellItem alloc] init];
        [defaultCellItems addSafeObject:cellItem];
    }
    
    [self.dataSource addCellItems:defaultCellItems];
}


@end
