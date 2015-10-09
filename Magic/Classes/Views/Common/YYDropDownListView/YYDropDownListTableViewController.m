//
//  YYDropDownListTableViewController.m
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYDropDownListTableViewController.h"
#import "YYDropDownListOneCell.h"
#import "YYDropDownListOneCellItem.h"

@interface YYDropDownListTableViewController ()

@end

@implementation YYDropDownListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)reloadMyData {
    [self.dataSource clear];
    
    NSMutableArray *cellItemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < 10; i ++ ) {
        YYDropDownListOneCellItem *cellItem = [[YYDropDownListOneCellItem alloc] init];
        [cellItemsArray addSafeObject:cellItem];
    }
    [self.dataSource addCellItems:cellItemsArray];
}

- (void)reloadMyDataWidthCellItemsArray:(NSArray *)cellItemsArray {
    [self.dataSource clear];
    [self.dataSource addCellItems:cellItemsArray];
}

- (void)reloadMyDataWidthArray:(NSArray *)chooseArray {
    [self.dataSource clear];
    NSMutableArray *cellItemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < chooseArray.count; i ++ ) {
        NSString *titleStr = [chooseArray objectAtSafeIndex:i];
        if (titleStr && [titleStr isKindOfClass:[NSString class]]) {
            YYDropDownListOneCellItem *cellItem = [[YYDropDownListOneCellItem alloc] init];
            cellItem.titleStr = titleStr;
            [cellItemsArray addSafeObject:cellItem];
        }
        
    }
    [self.dataSource addCellItems:cellItemsArray];
}

#pragma mark -
#pragma mark TableView

- (Class)cellItemClass {
    return [YYDropDownListOneCellItem class];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    if (self.tableViewSelectionBlock) {
        self.tableViewSelectionBlock(indexPath);
    }
}

@end
