//
//  KKCaseListViewController.h
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"

@interface KKCaseListViewController : YYBaseTableViewController

- (instancetype)initWithPersonId:(NSInteger)personId;

- (instancetype)initWithPersonId:(NSInteger)personId status:(NSInteger)status;

@end
