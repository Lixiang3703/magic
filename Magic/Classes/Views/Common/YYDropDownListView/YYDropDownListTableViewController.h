//
//  YYDropDownListTableViewController.h
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "DDBaseTableViewController.h"

typedef void (^YYDropDonwListTableViewSelectionBlock)(NSIndexPath *indexPath);

@interface YYDropDownListTableViewController : DDBaseTableViewController

@property (nonatomic, copy) YYDropDonwListTableViewSelectionBlock tableViewSelectionBlock;

- (void)reloadMyData;

- (void)reloadMyDataWidthArray:(NSArray *)chooseArray;

- (void)reloadMyDataWidthCellItemsArray:(NSArray *)cellItemsArray;


@end
