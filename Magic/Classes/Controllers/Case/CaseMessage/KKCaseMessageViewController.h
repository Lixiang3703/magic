//
//  KKCaseMessageViewController.h
//  Magic
//
//  Created by lixiang on 15/4/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "KKCaseMessageItem.h"

@interface KKCaseMessageViewController : YYBaseTableViewController

@property (nonatomic, assign) NSInteger messageId;

- (instancetype)initWithItemId:(NSInteger)itemId;
- (instancetype)initWithCaseMessageItem:(KKCaseMessageItem *)caseMessageItem;


@end

