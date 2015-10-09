//
//  KKBonusRecordItem.h
//  Magic
//
//  Created by lixiang on 15/5/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKBonusRecordItem : YYBaseAPIItem

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger bonus;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) NSInteger beforeCount;
@property (nonatomic, assign) NSInteger afterCount;

@end
