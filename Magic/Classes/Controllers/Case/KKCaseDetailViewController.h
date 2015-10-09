//
//  KKCaseDetailViewController.h
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "KKCaseItem.h"

@interface KKCaseDetailViewController : YYBaseTableViewController

@property (nonatomic, assign) NSInteger messageId;

- (instancetype)initWithItemId:(NSInteger)itemId;
- (instancetype)initWithCaseItem:(KKCaseItem *)caseItem;

@end
