//
//  KKMineViewController.m
//  Magic
//
//  Created by lixiang on 15/4/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMineViewController.h"
#import "KKLauncher.h"

#import "KKProfileIntroCellItem.h"
#import "KKProfileIntroCell.h"

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKProfileMenuCellItem.h"
#import "KKProfileMenuCell.h"

#import "KKSettingCellItem.h"
#import "KKSettingCell.h"

#import "KKUserInfoItem.h"
#import "KKUnreadInfoItem.h"
#import "KKShareManager.h"
#import "KKLoginManager.h"

#import "KKSettingViewController.h"
#import "KKCaseContainerViewController.h"
#import "KKBonusListViewController.h"
#import "KKCaseListViewController.h"
#import "KKProfileViewController.h"
#import "KKUserListViewController.h"
#import "KKMessageListViewController.h"
#import "KKChatSessionDetailViewController.h"
#import "KKCaseMessageListViewController.h"
#import "YYEmbedURLViewController.h"
#import "KKAboutViewController.h"

#import "DDTActionSheet.h"
#import "KKPhotoUploadManager.h"
#import "AppDelegate.h"
#import "DDImageViewer.h"

#import "KKOneSettingCellItem.h"
#import "KKOneSettingCell.h"
#import "DDTabBarGlobal.h"

@interface KKMineViewController ()<KKProfileMenuCellActions,KKProfileIntroCellActions>

@property (nonatomic, strong) KKProfileIntroCellItem *profileCellItem;

@property (nonatomic, strong) KKProfileMenuCellItem *menuCellItem;

@end

@implementation KKMineViewController

#pragma mark -
#pragma mark Accessors

- (KKProfileMenuCellItem *)menuCellItem {
    if (_menuCellItem == nil) {
        _menuCellItem = [[KKProfileMenuCellItem alloc] init];
    }
    return _menuCellItem;
}

-(KKProfileIntroCellItem *)profileCellItem{
    if (!_profileCellItem) {
        _profileCellItem = [[KKProfileIntroCellItem alloc] initWithRawItem:[KKUserInfoItem sharedItem].personItem];
    }
    return _profileCellItem;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    
    self.navigationBarHidden = YES;
    self.statusBarColor = [UIColor clearColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
    
    [self checkUserInfo];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.needRefreshUserInfoWhenAppear) {
        [self checkUserInfo];
    }
    self.needRefreshUserInfoWhenAppear = NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.view.height = [UIDevice screenHeight] - kDDTabBarHeight;
    self.tableView.height = self.view.height;
}

#pragma mark -
#pragma mark Notification

- (void)addGlobalNotification {
    [super addGlobalNotification];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(unreadInfoUpdate:) name:kLinkNotification_Unread_Update object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidLogin:) name:kLoginManager_Notification_DidLogIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(profileUpdateSuccess:) name:kNotification_Profile_Update_BasicInfo_Success object:nil];
}

- (void)profileUpdateSuccess:(NSNotification *)notification {
    if (self.view.isVisible) {
        [self dragDownRefresh];
    }
    else {
        self.needRefreshUserInfoWhenAppear = YES;
    }
}


- (void)appDidLogin:(NSNotification *)notification {
    [self checkUserInfo];
}

- (void)unreadInfoUpdate:(NSNotification *)notification {
    
}

#pragma mark -
#pragma mark CheckInfo

- (void)checkUserInfo {
    __weak __typeof(self) weakSelf = self;
    [[KKLauncher getInstance] checkUserInfoWithSuccessBlock:^(id responseObject, NSDictionary *headers, id requestModel) {
        weakSelf.profileCellItem.rawObject = [KKUserInfoItem sharedItem].personItem;
        [weakSelf.tableView reloadData];
        
        [weakSelf.tableView.refreshControl endRefreshing];
        
    } failBlock:^(NSError *error, NSDictionary *headers, id requestModel) {
        [weakSelf.tableView.refreshControl endRefreshing];
    }];
}

#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"")];
    
    if ([KKUserInfoItem sharedItem].personItem) {
        [self setNaviTitle:[KKUserInfoItem sharedItem].personItem.name];
    }
    
//    [self setRightBarButtonItem:[UIBarButtonItem iconBarbuttonItemWithTheme:kLinkThemeNavigationBarSettingsButton target:self action:@selector(settingsButtonPressed:)] animated:animated];
    
//    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"设置") target:self action:@selector(settingsButtonPressed:)] animated:animated];
}

#pragma mark -
#pragma mark Buttons

- (void)inviteButtonPressed:(id)sender {
    YYShareActivityView *shareActivityView = [KKShareManager defaultInviteWithStatPrefix:@"cc"];
    [shareActivityView showInView:self.navigationController.view];
}

- (void)settingsButtonPressed:(id)sender {
    KKSettingViewController *viewController = [[KKSettingViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self insertTestCellItems];
}

- (void)insertTestCellItems {
    [self.dataSource clear];
    
//    __weak __typeof(self)weakSelf = self;
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    YYGroupHeaderCellItem *groupCellItem = nil;
    KKOneSettingCellItem *oneSettingCellItem = nil;

    //ProfileCell
    [defaultCellItems addSafeObject:self.profileCellItem];
    
    [defaultCellItems addSafeObject:self.menuCellItem];
    
    if ([KKUserInfoItem sharedItem].personItem && [KKUserInfoItem sharedItem].personItem.role == KKPersonRoleTypeAgent) {
        //  Placeholder
        groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
        [defaultCellItems addSafeObject:groupCellItem];
        
        oneSettingCellItem = [KKOneSettingCellItem cellItemWithTitle:@"我的客户" iconImageName:@"icon_gray_small_mine"];
        oneSettingCellItem.cellStyle = UITableViewCellStyleValue1;
        oneSettingCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
            
        };
        oneSettingCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
            cell.imageView.left = kUI_TableView_Common_Margin;
            cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
        };
        oneSettingCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
            KKUserListViewController *vc = [[KKUserListViewController alloc] init];
            [viewController.navigationController pushViewController:vc animated:YES];
        };
        [defaultCellItems addSafeObject:oneSettingCellItem];
    }
    
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [defaultCellItems addSafeObject:groupCellItem];
    
    oneSettingCellItem = [KKOneSettingCellItem cellItemWithTitle:@"我的业务" iconImageName:@"icon_gray_small_case"];
    oneSettingCellItem.cellStyle = UITableViewCellStyleValue1;
    oneSettingCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        
    };
    oneSettingCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
        cell.imageView.left = kUI_TableView_Common_Margin;
        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
    };
    oneSettingCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        KKCaseListViewController *vc = [[KKCaseListViewController alloc] initWithPersonId:[KKUserInfoItem sharedItem].personItem.kkId];
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    [defaultCellItems addSafeObject:oneSettingCellItem];
    
    oneSettingCellItem = [KKOneSettingCellItem cellItemWithTitle:@"积分记录" iconImageName:@"icon_gray_small_bonus"];
    oneSettingCellItem.cellStyle = UITableViewCellStyleValue1;
    oneSettingCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        
    };
    oneSettingCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
        cell.imageView.left = kUI_TableView_Common_Margin;
        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
    };
    oneSettingCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        KKBonusListViewController *vc = [[KKBonusListViewController alloc] initWithPersonId:[KKUserInfoItem sharedItem].personItem.kkId];
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    [defaultCellItems addSafeObject:oneSettingCellItem];
    
    oneSettingCellItem = [KKOneSettingCellItem cellItemWithTitle:@"联系客服" iconImageName:@"icon_gray_middle_chat"];
    oneSettingCellItem.cellStyle = UITableViewCellStyleValue1;
    oneSettingCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {

    };
    oneSettingCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
        cell.imageView.left = kUI_TableView_Common_Margin;
        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
    };
    oneSettingCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        KKChatSessionDetailViewController *vc = [[KKChatSessionDetailViewController alloc] initWithPersonItem:[KKUserInfoItem sharedItem].servicePersonItem];
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    [defaultCellItems addSafeObject:oneSettingCellItem];
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [defaultCellItems addSafeObject:groupCellItem];

    oneSettingCellItem = [KKOneSettingCellItem cellItemWithTitle:@"用户中心" iconImageName:@"icon_gray_small_user"];
    oneSettingCellItem.cellStyle = UITableViewCellStyleValue1;
    oneSettingCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        
    };
    oneSettingCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
        cell.imageView.left = kUI_TableView_Common_Margin;
        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
    };
    oneSettingCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        KKSettingViewController *vc = [[KKSettingViewController alloc] init];
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    [defaultCellItems addSafeObject:oneSettingCellItem];
    
    oneSettingCellItem = [KKOneSettingCellItem cellItemWithTitle:@"关于我们" iconImageName:@"icon_gray_small_people"];
    oneSettingCellItem.cellStyle = UITableViewCellStyleValue1;
    oneSettingCellItem.cellWillDisplayBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        
    };
    oneSettingCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
        cell.imageView.left = kUI_TableView_Common_Margin;
        cell.textLabel.left = cell.imageView.right + kUI_TableView_Common_Margin;
    };
    oneSettingCellItem.cellSelectionBlock = ^(DDBaseCellItem *cellItem, YYBaseCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        KKAboutViewController *vc = [[KKAboutViewController alloc] init];
        [viewController.navigationController pushViewController:vc animated:YES];
    };
    [defaultCellItems addSafeObject:oneSettingCellItem];
    
    //  Placeholder
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil];
    [defaultCellItems addSafeObject:groupCellItem];

    
    // bottom place holder
    [defaultCellItems addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:50 title:nil]];
    
    [self.dataSource insertTopCellItems:defaultCellItems];
}

#pragma mark -
#pragma mark  TableView Template method

- (void)tableviewWillReload:(UIRefreshControl *)refreshControl {
    [self checkUserInfo];
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    if ([cellItem isKindOfClass:[KKProfileIntroCellItem class]]) { // user info
        KKProfileViewController *viewController = [[KKProfileViewController alloc] init];
        viewController.personItem = [KKUserInfoItem sharedItem].personItem;
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark -
#pragma mark kkProfileMenuButtonPressed

- (void)kkProfileMenuButtonPressed:(NSDictionary *)info {
    UIButton *button = [info objectForSafeKey:kDDTableView_Action_Key_Control];
    
    NSLog(@"buttonTag:%ld",(long)button.tag);
    
    switch (button.tag) {
        case KKProfileMenuTagTypeNeedPay:
        {
            KKCaseListViewController *vc = [[KKCaseListViewController alloc] initWithPersonId:[KKUserInfoItem sharedItem].personItem.kkId status:KKCaseStatusTypeNeedPay];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKProfileMenuTagTypeOver:
        {
            KKCaseListViewController *vc = [[KKCaseListViewController alloc] initWithPersonId:[KKUserInfoItem sharedItem].personItem.kkId status:KKCaseStatusTypeOver];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case KKProfileMenuTagTypeShare:
        {
            [self inviteButtonPressed:nil];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark KKProfileIntroCellActions

- (void)kkProfileAvaterButtonPressed:(NSDictionary *)info {
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] initWithCapacity:3];
    DDTActionSheetItem *actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"查看大图");
    actionSheetItem.selector = @selector(seeBigPhoto);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"更换头像");
    actionSheetItem.selector = @selector(uploadHeadPhoto);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];
    
    actionSheet.lbDelegate = self;
    [actionSheet showInView:[UINavigationController appNavigationController].view];
}

- (void)kkProfileBgImagePressed:(NSDictionary *)info {
    KKProfileViewController *viewController = [[KKProfileViewController alloc] init];
    viewController.personItem = [KKUserInfoItem sharedItem].personItem;
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -
#pragma mark KKProfileIntroCellItem Actions

- (void)seeBigPhoto {
    NSLog(@"see big photo.");
    
    KKProfileIntroCell *cell = (KKProfileIntroCell *)[self.tableView cellForCellItem:self.profileCellItem];
    if (cell && [cell isKindOfClass:[KKProfileIntroCell class]]) {
        CGRect startFrame = [cell.avatarImageView convertRect:cell.avatarImageView.frame toView:[AppDelegate sharedAppDelegate].window];
        startFrame.origin.y -= (64 + 64);
        startFrame.origin.x = 25;
        CGRect endFrame = [AppDelegate sharedAppDelegate].window.bounds;
        
        [[DDImageViewer getInstance] viewFullScreenImageWithImageUrl:[KKUserInfoItem sharedItem].personItem.imageItem.urlMiddle placeHolderImage:cell.avatarImageView.image startFrame:startFrame endFrame:endFrame animated:YES];
    }
}

#pragma mark -
#pragma mark ImagePick

- (void)uploadHeadPhoto {
    [[KKPhotoUploadManager getInstance] uploadPhotoWithType:KKUploadPhotoType_avatar entityId:[KKUserInfoItem sharedItem].personItem.kkId withMaxCount:1];
}


@end





