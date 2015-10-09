//
//  KKSettingViewController.m
//  Link
//
//  Created by Lixiang on 14/10/23.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKSettingViewController.h"

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKSettingCellItem.h"
#import "KKSettingCell.h"

#import "YYTextCenterCellItem.h"
#import "YYTextCenterCell.h"

#import "KKLoginManager.h"
#import "KKAccountItem.h"
#import "YYMainTabContainerViewController.h"
#import "KKChangePasswordViewController.h"

#import <MessageUI/MessageUI.h>
#import "WSDownloadCache.h"

#import "KKWelcomeViewController.h"

@interface KKSettingViewController ()<MFMailComposeViewControllerDelegate>

@end

@implementation KKSettingViewController

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:@"设置"];
}

#pragma mark -
#pragma mark DataSource
- (void)generateDataSource {
    [super generateDataSource];
    
    [self insertDefaultCellItems];
    
//    [self addDebugDataSource];
}

- (void)insertDefaultCellItems {
    
    YYGroupHeaderCellItem *groupCellItem = nil;
    KKSettingCellItem *settingCellItem = nil;
    YYTextCenterCellItem *textCenterCellItem = nil;
    
    __weak typeof(self)weakSelf = self;
    /******************************************/
    //  Group
    
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginW title:nil];
    [self.dataSource addCellItem:groupCellItem];
    
    /** Cell - 手机推送 */
//    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"手机推送通知"];
//    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
//        KKSettingViewController *vc = [[KKSettingViewController alloc] init];
//        [selfViewController.navigationController pushViewController:vc animated:YES];
//    };
//    [self.dataSource addCellItem:settingCellItem];
    
    /** Cell - 修改密码 */
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"修改密码"];
    settingCellItem.seperatorLineHidden = NO;
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
        KKChangePasswordViewController *vc = [[KKChangePasswordViewController alloc] init];
        [selfViewController.navigationController pushViewController:vc animated:YES];
    };
    [self.dataSource addCellItem:settingCellItem];

    
    /******************************************/
    //  Group
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"清空缓存"];
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
        [[WSDownloadCache getInstance] clearAllCache];
    };
    [self.dataSource addCellItem:settingCellItem];
    
    
    //  Group
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"欢迎页"];
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
//        KKWelcomeViewController *vc = [[KKWelcomeViewController alloc] init];
//        [selfViewController.navigationController pushViewController:vc animated:YES];
    };
//    [self.dataSource addCellItem:settingCellItem];
    
    
    //  Group
    /** Cell - 意见反馈 */
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_Compose_Toolbar_At_Height title:nil];
    [self.dataSource addCellItem:groupCellItem];
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"意见反馈"];
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
        [weakSelf sendFeedback];
    };
    [self.dataSource addCellItem:settingCellItem];
    
    /** Cell - 投一票 */
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"喜欢我们，投一票"];
    settingCellItem.cellIdentifier = @"Version";
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:kApp_Update_Url]];
    };
    [self.dataSource addCellItem:settingCellItem];
    
//    /** Cell - 版本号 */
//    settingCellItem = [KKSettingCellItem cellItemWithTitle:[NSString stringWithFormat:@"版本号 v%@",[UIApplication wholeAppVersion]]];
//    settingCellItem.cellAccessoryType = UITableViewCellAccessoryNone;
//    settingCellItem.seperatorLineHidden = YES;
//    [self.dataSource addCellItem:settingCellItem];
    
    /******************************************/
    //  Group
    /** Cell - 退出登录 */
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_Compose_Toolbar_At_Height title:nil];
    [self.dataSource addCellItem:groupCellItem];
    textCenterCellItem = [YYTextCenterCellItem cellItemWithTitle:@"退出登录"];
    textCenterCellItem.seperatorLineHidden = YES;
    textCenterCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, KKSettingViewController *selfViewController) {
        [weakSelf logoutAction];
        [[KKLoginManager getInstance] logoutWithForce:NO];
    };
    [self.dataSource addCellItem:textCenterCellItem];
    
    /******************************************/
    //  Placeholder CellItem
    /** 占位符留白 */
    [self.dataSource addCellItem:[YYGroupHeaderCellItem cellItemWithHeight:100]];
    
}

- (void)addDebugDataSource {
    YYGroupHeaderCellItem *groupCellItem = nil;
    
    //  Group
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_Height title:nil];
    [self.dataSource addCellItem:groupCellItem];
    groupCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_Height title:@"开发者工具"];
    [self.dataSource addCellItem:groupCellItem];
}

#pragma mark -
#pragma mark Actions 

- (void)logoutAction {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [[YYMainTabContainerViewController sharedViewController] pushSwitchToIndex:KKMainTabIndexIndex];
    [[KKLoginManager getInstance] showLoginControllerWithAnimated:YES];
}

#pragma mark -
#pragma mark CellItems

- (void)sendFeedback {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailPicker = [[MFMailComposeViewController alloc] init];
        mailPicker.mailComposeDelegate = self;
        
        NSString *subject = @"[知产通iOS]意见反馈";
        NSString *recipients = @"lixiang3703@gmail.com";
        
        
        NSString *body = [NSString stringWithFormat:@"\n\n\n[%@:%@(%@), %@:iOS%@, %@:%@, %@:%@, %@:%@]\n%@:[%@]",
                          _(@"设备"),
                          [UIDevice stringForPlatform],
                          [UIDevice isJailBreak] ? @"已越狱" : @"未越狱",
                          _(@"系统版本"),
                          [UIDevice currentDevice].systemVersion,
                          _(@"版本"),
                          [UIApplication appVersion],
                          _(@"channel"),
                          @kApp_Channel,
                          _(@"当前网络"),
                          [NSString stringForCurrentNetworkStatus],
                          _(@"账号"),
                          [[KKAccountItem sharedItem].mobile isEqualToString:@"unknown"] ? @"" : [KKAccountItem sharedItem].mobile];
        
        //添加主题
        [mailPicker setToRecipients:@[recipients]];
        [mailPicker setSubject:subject];
        [mailPicker setMessageBody: body isHTML:NO];
        
        [self presentViewController:mailPicker animated:YES completion:^{
            
        }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"邮箱不可用" message:@"您可以先在设置中配置一下邮箱" delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark -
#pragma mark MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

@end
