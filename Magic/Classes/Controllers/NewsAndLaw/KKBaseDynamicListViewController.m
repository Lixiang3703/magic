//
//  KKBaseDynamicListViewController.m
//  Magic
//
//  Created by lixiang on 15/5/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBaseDynamicListViewController.h"

#import "YYEmbedURLViewController.h"
#import "KKDynamicDetailViewController.h"

@interface KKBaseDynamicListViewController ()

@end

@implementation KKBaseDynamicListViewController


#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
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
    [self setNaviTitle:_(@"新闻中心")];
    
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
        KKDynamicCellItem *cellItem = [[KKDynamicCellItem alloc] init];
        [defaultCellItems addSafeObject:cellItem];
    }
    
    [self.dataSource addCellItems:defaultCellItems];
}

#pragma mark -
#pragma mark TableView

- (Class)cellItemClass {
    return [KKDynamicCellItem class];
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    //    NSString *url = @"http://www.baidu.com";
    //    YYEmbedURLViewController *viewController = [[YYEmbedURLViewController alloc] initWithURLString:url];
    //    [self.navigationController pushViewController:viewController animated:YES];
    
    KKDynamicItem *item = (KKDynamicItem*)cellItem.rawObject;
    if ([item isKindOfClass:[KKDynamicItem class]]) {
        KKDynamicDetailViewController *viewController = [[KKDynamicDetailViewController alloc] initWithDynamicItem:item];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}



@end
