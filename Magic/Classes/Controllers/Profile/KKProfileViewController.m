//
//  KKProfileViewController.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKProfileViewController.h"

#import "KKTagGroupHeaderCellItem.h"
#import "KKTagGroupHeaderCell.h"

#import "KKSingleBigImageCellItem.h"
#import "KKSingleBigImageCell.h"

#import "KKShowTagCellItem.h"
#import "KKShowTagCell.h"

#import "YYTextCenterCellItem.h"
#import "YYTextCenterCell.h"

#import "KKModifyProfileViewController.h"
#import "KKModifyParentViewController.h"
#import "KKModifyCompanyViewController.h"
#import "KKApplyForAgentViewController.h"

#import "KKLauncher.h"
#import "KKUserInfoItem.h"

#define kProfileModifyKeyBasicInfo              (@"BasicInfo")

@interface KKProfileViewController ()

@property (nonatomic, strong) YYTextCenterCellItem *applyForAgentCellItem;


@end

@implementation KKProfileViewController

#pragma mark -
#pragma mark Accessor

- (YYTextCenterCellItem *)applyForAgentCellItem {
    if (_applyForAgentCellItem == nil) {
        _applyForAgentCellItem = [YYTextCenterCellItem cellItemWithTitle:@"申请成为合作伙伴"];
        _applyForAgentCellItem.seperatorLineHidden = YES;
        _applyForAgentCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
            cell.textLabel.textColor = [UIColor KKRedColor];
        };
        _applyForAgentCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController* viewController) {
            KKApplyForAgentViewController *vc = [[KKApplyForAgentViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        };
        
    }
    return _applyForAgentCellItem;
}


#pragma mark -
#pragma mark life cycle

- (void)initSettings {
    [super initSettings];
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self reloadDataSource];
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (self.needRefreshWhenViewDidAppear) {
        [self sendUserInfoRequest];
    }
    
}


#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"")];
    
    if (self.personItem) {
        [self setNaviTitle:self.personItem.name];
    }
    
}

#pragma mark -
#pragma mark Notification

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileUpdateSuccess:) name:kNotification_Profile_Update_BasicInfo_Success object:nil];
}

- (void)profileUpdateSuccess:(NSNotification *)notification {
    self.needRefreshWhenViewDidAppear = YES;
}

#pragma mark -
#pragma mark

- (void)reloadDataSource {
    [self.dataSource clear];
    
    if (self.personItem.role == KKPersonRoleTypeNormal) {
        self.applyForAgentCellItem.textLabelText = @"申请成为合作伙伴";
    }
    else if (self.personItem.role == KKPersonRoleTypeAgent){
        self.applyForAgentCellItem.textLabelText = @"重新上传公司执照";
    }
    
    YYGroupHeaderCellItem *groupCellItem = nil;
    
    NSMutableArray *cellItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    KKTagGroupHeaderCellItem *groupHeaderCellItem0 = [[KKTagGroupHeaderCellItem alloc] initWithTagName:@"个人信息" buttonName:@""];
    groupHeaderCellItem0.rawObject = kProfileModifyKeyBasicInfo;
    [cellItemArray addSafeObject:groupHeaderCellItem0];
    
    KKShowTagCellItem *showTagCellItem = nil;
    KKShowTagItem *showTagItem = nil;
    for (int tagType = KKProfileTagTypeName; tagType < KKProfileTagTypeCount; tagType ++) {
        if (![self shouldShowWithType:tagType personItem:self.personItem]) {
            continue;
        }
        showTagCellItem= [[KKShowTagCellItem alloc] init];
        showTagCellItem.cellAccessoryType = [self accessoryTypeWithType:tagType];
        showTagCellItem.cellSelectionBlock = [self profileCellActionBlockWithType:tagType];
        
        showTagItem = [[KKShowTagItem alloc] init];
        showTagItem.tagName = [self profileTagNameWithType:tagType modifyTag:NO];
        showTagItem.titleName = [self profileTagTitleWithPersonItem:self.personItem byType:tagType modifyTag:NO];
        showTagItem.cellLayoutType = KKShowTagCellLayoutTypeFloatLeft;
        
        [showTagCellItem updateCellItemWithTagItem:showTagItem];
        
        [cellItemArray addSafeObject:showTagCellItem];
    }
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    [cellItemArray addSafeObject:self.applyForAgentCellItem];
    
    
    [self.dataSource addCellItems:cellItemArray];
}

- (BOOL)shouldShowWithType:(KKProfileTagType)type personItem:(KKPersonItem *)personItem{
    
    if (personItem.role == KKPersonRoleTypeAgent && type == KKProfileTagTypeParentName) {
        return NO;
    }
    
    if (personItem.role == KKPersonRoleTypeNormal && type == KKProfileTagTypeCode) {
        return NO;
    }
    
    return YES;
}

- (UITableViewCellAccessoryType)accessoryTypeWithType:(KKProfileTagType)type {
    switch (type) {
        case KKProfileTagTypeName:
            return UITableViewCellAccessoryDisclosureIndicator;
            break;
        case KKProfileTagTypeParentName:
            return UITableViewCellAccessoryDisclosureIndicator;
            break;
        case KKProfileTagTypeCompanyName:
            return UITableViewCellAccessoryDisclosureIndicator;
            break;
        default:
            return UITableViewCellAccessoryNone;
            break;
    }
}

- (DDCellActionBlock)profileCellActionBlockWithType:(KKProfileTagType)type {
    switch (type) {
        case KKProfileTagTypeName:
            return ^(id cellItem, id cell, NSIndexPath *indexPath, DDBaseTableViewController* viewController){
                KKModifyProfileViewController *vc = [[KKModifyProfileViewController alloc] init];
                vc.isNaviPush = YES;
                [viewController.navigationController pushViewController:vc animated:YES];
            };
            break;
        case KKProfileTagTypeCompanyName:
        {
            return ^(id cellItem, id cell, NSIndexPath *indexPath, DDBaseTableViewController* viewController){
                KKModifyCompanyViewController *vc = [[KKModifyCompanyViewController alloc] init];
                vc.isNaviPush = YES;
                [viewController.navigationController pushViewController:vc animated:YES];
            };
        }
            break;
        case KKProfileTagTypeCode:
            return nil;
            break;
        case KKProfileTagTypeParentName:
        {
            return ^(id cellItem, id cell, NSIndexPath *indexPath, DDBaseTableViewController* viewController){
                KKModifyParentViewController *vc = [[KKModifyParentViewController alloc] init];
                vc.isNaviPush = YES;
                [viewController.navigationController pushViewController:vc animated:YES];
            };
        }
            break;
        default:
            return nil;
            break;
    }
    return nil;
}

- (NSString *)profileTagNameWithType:(KKProfileTagType)type modifyTag:(BOOL)isModifyTag {
    switch (type) {
        case KKProfileTagTypeName:
            return @"名字";
            break;
        case KKProfileTagTypeCode:
            return @"推荐码";
            break;
        case KKProfileTagTypeCompanyName:
            return @"公司名称";
            break;
        case KKProfileTagTypeParentName:
            return @"Parent";
            break;
        default:
            return @"unknown";
            break;
    }
}

- (NSString *)profileTagTitleWithPersonItem:(KKPersonItem *)personItem byType:(KKProfileTagType)type modifyTag:(BOOL)isModifyTag {
    if (!personItem) {
        return @"";
    }
    switch (type) {
        case KKProfileTagTypeName:
            return personItem.name;
            break;
        case KKProfileTagTypeCode:
            return personItem.code;
            break;
        case KKProfileTagTypeCompanyName:
            return personItem.company;
            break;
        case KKProfileTagTypeParentName:
            return (personItem.parentItem.name) ? personItem.parentItem.name : @"" ;
            break;
        default:
            return @"unknown";
            break;
    }
}

#pragma mark -
#pragma mark YYBaseTableViewController templates

- (void)tableviewWillReload:(UIRefreshControl *)refreshControl {
    [self sendUserInfoRequest];
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
}

- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(YYBaseCellItem *)cellItem {
    return YES;
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    if ([cellItem isKindOfClass:[KKShowTagCellItem class]]) {
        
    }
    
}

#pragma mark -
#pragma mark Send Requests

- (void)sendUserInfoRequest {
    __weak __typeof(self)weakSelf = self;
    [weakSelf.tableView.refreshControl endRefreshing];
    
    [[KKLauncher getInstance] checkUserInfoWithSuccessBlock:^(id responseObject, NSDictionary *headers, id requestModel) {
        weakSelf.personItem = [KKUserInfoItem sharedItem].personItem;
        [weakSelf reloadDataSource];
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.refreshControl endRefreshing];
        
    } failBlock:^(NSError *error, NSDictionary *headers, id requestModel) {
        [weakSelf.tableView.refreshControl endRefreshing];
    }];
}


@end
