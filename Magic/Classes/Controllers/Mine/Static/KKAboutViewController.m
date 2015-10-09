//
//  KKAboutViewController.m
//  Magic
//
//  Created by lixiang on 15/6/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKAboutViewController.h"
#import "KKAboutTopCellItem.h"
#import "KKAboutTopCell.h"
#import "KKSettingCellItem.h"
#import "KKSettingCell.h"
#import "YYGroupHeaderCellItem.h"

@interface KKAboutViewController ()

@end

@implementation KKAboutViewController

#pragma mark -
#pragma mark Init

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"关于我们")];
    
}

- (void)generateDataSource {
    [super generateDataSource];
    
    [self insertDefaultCellItem];
}

- (void)insertDefaultCellItem {
    [self.dataSource clear];
    
    NSMutableArray *defaultCellItems = [NSMutableArray array];
    
    KKAboutTopCellItem *topCellItem = [[KKAboutTopCellItem alloc] init];
    topCellItem.infoStr = @"知产通APP是隶属中理通知识产权代理公司旗下，为企业和代理商提供商标、专利、版权和律师服务的专有手机平台，能够有效帮助企业和代理商有效地进行知识产权业务查询，办理和管理。";
    
    [defaultCellItems addSafeObject:topCellItem];
    
    KKSettingCellItem *settingCellItem = nil;
    YYGroupHeaderCellItem *groupHeaderCellItem = nil;
    
    groupHeaderCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginW title:nil];
    [defaultCellItems addSafeObject:groupHeaderCellItem];
    
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"地址：北京市宣武区红莲南路57号中印大厦一楼"];
    settingCellItem.cellAccessoryType = UITableViewCellAccessoryNone;
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController *selfViewController) {
        
    };
    [defaultCellItems addSafeObject:settingCellItem];
    
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"电话：(86-10)68576661(总机) "];
    settingCellItem.cellAccessoryType = UITableViewCellAccessoryNone;
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController *selfViewController) {
        
    };
    [defaultCellItems addSafeObject:settingCellItem];
    
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"传真：(86-10)68576660"];
    settingCellItem.cellAccessoryType = UITableViewCellAccessoryNone;
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController *selfViewController) {
        
    };
    [defaultCellItems addSafeObject:settingCellItem];
    
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"邮箱：shangbiao@zltr.com"];
    settingCellItem.cellAccessoryType = UITableViewCellAccessoryNone;
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController *selfViewController) {
        
    };
    [defaultCellItems addSafeObject:settingCellItem];
    
    settingCellItem = [KKSettingCellItem cellItemWithTitle:@"网站：http://www.zltr.com"];
    settingCellItem.cellAccessoryType = UITableViewCellAccessoryNone;
    settingCellItem.cellSelectionBlock = ^(id cellItem, id cell, NSIndexPath *indexPath, YYBaseTableViewController *selfViewController) {
        
    };
    [defaultCellItems addSafeObject:settingCellItem];
    
    
    [self.dataSource addCellItems:defaultCellItems];
}

@end
