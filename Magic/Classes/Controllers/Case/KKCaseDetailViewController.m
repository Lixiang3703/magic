//
//  KKCaseDetailViewController.m
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseDetailViewController.h"


#import "KKSimpleTitleCellItem.h"
#import "KKSimpleTitleCell.h"

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKTagGroupHeaderCellItem.h"
#import "KKTagGroupHeaderCell.h"

#import "KKShowTagCellItem.h"
#import "KKShowTagCell.h"

#import "KKSettingCellItem.h"
#import "KKSettingCell.h"
#import "KKCaseDetailTitleCellItem.h"
#import "KKCaseDetailTitleCell.h"
#import "KKCaseDetailMenuCellItem.h"
#import "KKCaseDetailMenuCell.h"
#import "KKSingleButtonCellItem.h"
#import "KKSingleButtonCell.h"

#import "KKChatSessionDetailViewController.h"
#import "KKCaseMessageListViewController.h"
#import "KKCaseUserImageListViewController.h"
#import "KKCaseTrademarkViewController.h"
#import "KKUserInfoItem.h"

#import "KKCaseFieldManager.h"

#import "KKCaseDeleteRequestModel.h"
#import "KKCaseOneRequestModel.h"
#import "KKWeixinPayManager.h"

#import "DDTActionSheet.h"
#import "UIAlertView+Blocks.h"

#import "KKPrePayRequestModel.h"
#import "AppDelegate.h"
#import "KKWeixinPrePayItem.h"
#import "KKOneSettingCellItem.h"
#import "KKOneSettingCell.h"

#import "KKAliPrePayRequestModel.h"
#import "KKAliPrePayItem.h"
#import "KKAliPayManager.h"
#import "KKBasePhoneManager.h"

@interface KKCaseDetailViewController ()<KKSingleButtonCellActions>

@property (nonatomic, strong) KKCaseItem *caseItem;
@property (nonatomic, strong) KKSimpleTitleCellItem *simpleTitleCellItem;

@property (nonatomic, strong) KKCaseDetailTitleCellItem *titleCellItem;
@property (nonatomic, strong) KKCaseDetailMenuCellItem *menuCellItem;
@property (nonatomic, strong) KKSingleButtonCellItem *buttonCellItem;
@property (nonatomic, strong) KKShowTagCellItem *contentCellItem;
@property (nonatomic, strong) KKOneSettingCellItem *messageCellItem;
@property (nonatomic, strong) KKOneSettingCellItem *userImageCellItem;
@property (nonatomic, strong) KKOneSettingCellItem *trademarkCellItem;

@property (nonatomic, strong) KKShowTagCellItem *priceCellItem;

@property (nonatomic, assign) NSInteger itemId;
@property (nonatomic, strong) KKCaseOneRequestModel *oneRequestModel;
@property (nonatomic, strong) KKPrePayRequestModel *prepayRequestModel;
@property (nonatomic, strong) KKAliPrePayRequestModel *aliPrepayRequestModel;
@end

@implementation KKCaseDetailViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseOneRequestModel *)oneRequestModel {
    if (_oneRequestModel == nil) {
        __weak __typeof(self)weakSelf = self;
        _oneRequestModel = [[KKCaseOneRequestModel alloc] init];
        _oneRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKCaseOneRequestModel* requestModel) {
            weakSelf.caseItem = requestModel.resultItem;
            [weakSelf reloadMyDataSource];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.refreshControl endRefreshing];
        };
        _oneRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKCaseOneRequestModel* requestModel){
            [UIAlertView postAlertWithMessage:@"fail"];
            [weakSelf.tableView.refreshControl endRefreshing];
        };
    }
    return _oneRequestModel;
}

- (KKPrePayRequestModel *)prepayRequestModel {
    if (_prepayRequestModel == nil) {
        _prepayRequestModel = [[KKPrePayRequestModel alloc] init];
        _prepayRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKPrePayRequestModel* requestModel) {
            KKWeixinPrePayItem *payItem = (KKWeixinPrePayItem *)requestModel.resultItem;
            if (payItem && [payItem isKindOfClass:[KKWeixinPrePayItem class]]) {
                [[KKWeixinPayManager getInstance] payWithWeixinPrePayItem:payItem];
            }
            [UIAlertView HUDAlertDismiss];
        };
        _oneRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKCaseOneRequestModel* requestModel){
            [UIAlertView postAlertWithMessage:@"生成订单失败"];
            [UIAlertView HUDAlertDismiss];
        };

    }
    return _prepayRequestModel;
}

- (KKAliPrePayRequestModel *)aliPrepayRequestModel {
    if (_aliPrepayRequestModel == nil) {
        _aliPrepayRequestModel = [[KKAliPrePayRequestModel alloc] init];
        _aliPrepayRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKAliPrePayRequestModel* requestModel) {
            KKAliPrePayItem *payItem = (KKAliPrePayItem *)requestModel.resultItem;
            if (payItem && [payItem isKindOfClass:[KKAliPrePayItem class]]) {
                [[KKAliPayManager getInstance] payWithAliPrePayItem:payItem];
            }
            
            [UIAlertView HUDAlertDismiss];
        };
        _aliPrepayRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKAliPrePayRequestModel* requestModel){
            [UIAlertView postAlertWithMessage:@"生成订单失败"];
            [UIAlertView HUDAlertDismiss];
        };
    }
    return _aliPrepayRequestModel;
}

- (KKOneSettingCellItem *)messageCellItem {
    if (_messageCellItem == nil) {
        _messageCellItem = [KKOneSettingCellItem cellItemWithTitle:@"官方回执" iconImageName:@"icon_gray_small_house"];
        _messageCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController* viewController) {
            
        };
    }
    return _messageCellItem;
}

- (KKOneSettingCellItem *)userImageCellItem {
    if (_userImageCellItem == nil) {
        _userImageCellItem = [KKOneSettingCellItem cellItemWithTitle:@"申请文件" iconImageName:@"icon_gray_small_pencil"];

    }
    return _userImageCellItem;
}

- (KKOneSettingCellItem *)trademarkCellItem {
    if (_trademarkCellItem == nil) {
        _trademarkCellItem = [KKOneSettingCellItem cellItemWithTitle:@"商标列表" iconImageName:@"icon_gray_trademark"];
    }
    return _trademarkCellItem;
}

- (KKSingleButtonCellItem *)KKSingleButtonCellItem {
    if (_buttonCellItem == nil) {
        _buttonCellItem = [[KKSingleButtonCellItem alloc] init];
    }
    return _buttonCellItem;
}

- (KKCaseDetailTitleCellItem *)titleCellItem {
    if (_titleCellItem == nil) {
        _titleCellItem = [[KKCaseDetailTitleCellItem alloc] init];
    }
    return _titleCellItem;
}

- (KKCaseDetailMenuCellItem *)menuCellItem {
    if (_menuCellItem == nil) {
        _menuCellItem = [[KKCaseDetailMenuCellItem alloc] init];
    }
    return _menuCellItem;
}

- (KKShowTagCellItem *)contentCellItem {
    if (_contentCellItem == nil) {
        _contentCellItem = [[KKShowTagCellItem alloc] init];
        _contentCellItem.cellLayoutType = KKShowTagCellLayoutTypeFloatTop;
    }
    return _contentCellItem;
}

- (KKSimpleTitleCellItem *)simpleTitleCellItem {
    if (_simpleTitleCellItem == nil) {
        _simpleTitleCellItem = [[KKSimpleTitleCellItem alloc] init];
    }
    return _simpleTitleCellItem;
}

- (KKShowTagCellItem *)priceCellItem {
    if (_priceCellItem == nil) {
        _priceCellItem = [[KKShowTagCellItem alloc] init];
    }
    return _priceCellItem;
}

- (KKSingleButtonCellItem *)buttonCellItem {
    if (_buttonCellItem == nil) {
        _buttonCellItem = [[KKSingleButtonCellItem alloc] init];
    }
    return _buttonCellItem;
}

#pragma mark -
#pragma mark init

- (instancetype)initWithItemId:(NSInteger)itemId {
    self = [self init];
    if (self) {
        self.itemId = itemId;
        self.oneRequestModel.itemId = itemId;
    }
    return self;
}

- (instancetype)initWithCaseItem:(KKCaseItem *)caseItem {
    self = [self init];
    if (self) {
        self.caseItem = caseItem;
        self.oneRequestModel.itemId = caseItem.kkId;
    }
    return self;
}

#pragma mark -
#pragma mark life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
    
    [self reloadMyDataSource];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.caseItem) {
        if (self.messageId > 0) {
            self.oneRequestModel.messageId = self.messageId;
        }
        [self.oneRequestModel load];
    }
    else {
        // back from weixin pay
        self.oneRequestModel.itemId = self.caseItem.kkId;
        [self.oneRequestModel load];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark -
#pragma mark Notification

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(casePaySuccess:) name:kNotification_Case_Pay_Success object:nil];
}

- (void)casePaySuccess:(NSNotification *)notification {
    self.oneRequestModel.itemId = self.caseItem.kkId;
    [self.oneRequestModel load];
}


#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"业务详情")];
    
    if (self.caseItem.status == KKCaseStatusTypeNew) {
        [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"删除") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
    }
    
}

#pragma mark -
#pragma mark TableView

- (void)tableviewWillReload:(UIRefreshControl *)refreshControl {
    [super tableviewWillReload:refreshControl];
    
    [self.oneRequestModel load];
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    if (cellItem == self.messageCellItem) {
        KKCaseMessageListViewController *vc = [[KKCaseMessageListViewController alloc] initWithCaseItem:self.caseItem];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (cellItem == self.userImageCellItem) {
        KKCaseUserImageListViewController *viewController = [[KKCaseUserImageListViewController alloc] initWithCaseId:self.caseItem.kkId];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    else if (cellItem == self.trademarkCellItem) {
        KKCaseTrademarkViewController *viewController = [[KKCaseTrademarkViewController alloc] initWithCaseId:self.caseItem.kkId];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark -
#pragma mark DataSource

- (void)reloadMyDataSource {
    [self.dataSource clear];
    
    if (!self.caseItem) {
        return;
    }
    
    self.titleCellItem.caseItem = self.caseItem;
    if (self.caseItem.status == KKCaseStatusTypeNeedPay) {
        self.buttonCellItem.buttonTitle = @"立即支付";
        self.buttonCellItem.buttonColor = [UIColor KKGreenColor];
    }
    else if (self.caseItem.status == KKCaseStatusTypePayed) {
        self.buttonCellItem.buttonTitle = @"已完成支付";
        self.buttonCellItem.buttonColor = [UIColor YYGrayColor];
    }
    
    NSMutableArray *cellItemArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    YYGroupHeaderCellItem *groupCellItem = nil;
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    
    [cellItemArray addSafeObject:self.titleCellItem];
    
    if (self.caseItem.price > 0 && (self.caseItem.status == KKCaseStatusTypeNeedPay || self.caseItem.status == KKCaseStatusTypePayed) ) {
        [cellItemArray addSafeObject:self.buttonCellItem];
    }
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    [cellItemArray addSafeObject:self.menuCellItem];
    
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil]];
    [cellItemArray addSafeObject:self.userImageCellItem];
    [cellItemArray addSafeObject:self.messageCellItem];
    [cellItemArray addSafeObject:self.trademarkCellItem];
    
    KKTagGroupHeaderCellItem *groupHeaderCellItem0 = [[KKTagGroupHeaderCellItem alloc] initWithTagName:@"业务信息" buttonName:@""];
    groupHeaderCellItem0.rawObject = @"KKModifyProfileViewController";
    [cellItemArray addSafeObject:groupHeaderCellItem0];
    
    KKShowTagCellItem *showTagCellItem = nil;
    KKShowTagItem *showTagItem = nil;
    for (int tagType = KKCaseFieldTypeTitle; tagType < KKCaseFieldTypeCount; tagType ++) {
        
        if (![[KKCaseFieldManager getInstance] shouldShowForCaseType:self.caseItem.type subType:self.caseItem.subType caseFieldType:tagType]) {
            continue;
        }
        
        showTagCellItem = [[KKShowTagCellItem alloc] init];
        showTagCellItem.tagLabelWidth = 80;
        
        showTagItem = [[KKShowTagItem alloc] init];
        showTagItem.tagName = [[KKCaseFieldManager getInstance] titleForCaseFieldType:tagType];
        showTagItem.titleName = [[KKCaseFieldManager getInstance] contentForCaseFiedlType:tagType caseItem:self.caseItem];
        showTagItem.cellLayoutType = KKShowTagCellLayoutTypeFloatLeft;
        
        [showTagCellItem updateCellItemWithTagItem:showTagItem];
        
        [cellItemArray addSafeObject:showTagCellItem];
    }
    
    KKShowTagItem *priceTagItem = [[KKShowTagItem alloc] init];
    priceTagItem.tagName = @"金额";
    priceTagItem.titleName = [NSString stringWithFormat:@"%0.2f",self.caseItem.price];
    priceTagItem.cellLayoutType = KKShowTagCellLayoutTypeFloatLeft;
    
    [self.priceCellItem updateCellItemWithTagItem:priceTagItem];
    [cellItemArray addSafeObject:self.priceCellItem];
    
    KKTagGroupHeaderCellItem *groupHeaderCellItem2 = [[KKTagGroupHeaderCellItem alloc] initWithTagName:@"备注" buttonName:@""];
    [cellItemArray addSafeObject:groupHeaderCellItem2];
    
    KKShowTagItem *showTagItem1 = [[KKShowTagItem alloc] init];
    showTagItem1.tagName = @"";
    showTagItem1.titleName = @"集体商标是指由社团、协会或其他合作组织，用以表示联合组织及其成员身份的标志；由其组织成员使用于商品或服务项目上，以便与非成员所提供的商品或服务相区别，该种商标称之为集体商标。注册、使用集体商标，有利于中小企业的联合，促进其集约经营，形成在市场中有竞争力的销售渠道，有利于产品和商标的宣传，促进规模经营。";
    
    showTagItem1.titleName = [self.caseItem.content hasContent] ? self.caseItem.content : @"无";
    
    showTagItem1.cellLayoutType = KKShowTagCellLayoutTypeFloatTop;
    
    [self.contentCellItem updateCellItemWithTagItem:showTagItem1];
    
    [cellItemArray addSafeObject:self.contentCellItem];
    
    //  bottom Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:40 title:nil];
    [cellItemArray addSafeObject:groupCellItem];
    
    [self.dataSource addCellItems:cellItemArray];
}

#pragma mark -
#pragma mark KKCaseDetailMenuCellItem

- (void)kkCaseDetailMenuButtonPressed:(NSDictionary *)info {
    UIButton *button = [info objectForSafeKey:kDDTableView_Action_Key_Control];
    
    NSLog(@"buttonTag:%ld",(long)button.tag);
    
    switch (button.tag) {
        case KKCaseDetailMenuTagTypeChat:
        {
            KKChatSessionDetailViewController *viewController = [[KKChatSessionDetailViewController alloc] initWithPersonItem:[KKUserInfoItem sharedItem].servicePersonItem];
            [self.navigationController pushViewController:viewController animated:YES];
        }
            break;
        case KKCaseDetailMenuTagTypeCall:
        {
            [[KKBasePhoneManager getInstance] makePhoneForService];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark KKSingleButtonCellActions

- (void)kkSingleButtonPressed:(NSDictionary *)info {
    NSLog(@"KKSingleButtonCellActions");
//    [UIAlertView postAlertWithMessage:@"支付功能请稍后"];
    
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] init];
    DDTActionSheetItem *actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"微信支付");
    actionSheetItem.selector = @selector(payWithWeixin);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"支付宝支付");
    actionSheetItem.selector = @selector(payWithAli);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];
    actionSheet.lbDelegate = self;
    [actionSheet showInView:[UINavigationController appNavigationController].view];
    
    
//    [[AppDelegate sharedAppDelegate] payWithOrderItem];
}

- (void)payWithWeixin {
    self.prepayRequestModel.type = KKPayTypeWeixin;
    [UIAlertView postHUDAlertWithMessage:@"正在生成订单"];
    self.prepayRequestModel.caseId = self.caseItem.kkId;
    [self.prepayRequestModel load];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIAlertView HUDAlertDismiss];
    });
    
}

- (void)payWithAli {
//    [[KKAliPayManager getInstance] testPay];
    
    [UIAlertView postHUDAlertWithMessage:@"正在生成订单"];
    self.aliPrepayRequestModel.caseId = self.caseItem.kkId;
    [self.aliPrepayRequestModel load];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIAlertView HUDAlertDismiss];
    });
}


#pragma mark -
#pragma mark Navi actions

- (void)rightBarButtonItemClick:(id)sender {
    __weak __typeof(self)weakSelf = self;
    KKCaseDeleteRequestModel *requestModel = [[KKCaseDeleteRequestModel alloc] init];
    requestModel.itemId = self.caseItem.kkId;
    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
        [UIAlertView postAlertWithMessage:@"删除成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Case_Delete_Success object:nil];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel){
        [UIAlertView postAlertWithMessage:@"删除失败"];
    };
    
    [requestModel load];
}

@end


