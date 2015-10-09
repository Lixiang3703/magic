//
//  KKProfileViewController.h
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "KKPersonItem.h"

@interface KKProfileViewController : YYBaseTableViewController

@property (nonatomic, assign) BOOL mine;
@property (nonatomic, assign) NSInteger personId;
@property (nonatomic, strong) KKPersonItem *personItem;


@end
