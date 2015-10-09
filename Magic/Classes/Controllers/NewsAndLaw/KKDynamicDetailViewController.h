//
//  KKDynamicViewController.h
//  Magic
//
//  Created by lixiang on 15/5/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "KKDynamicItem.h"

@interface KKDynamicDetailViewController : YYBaseTableViewController


- (instancetype)initWithDynamicItem:(KKDynamicItem *)item;

@end
