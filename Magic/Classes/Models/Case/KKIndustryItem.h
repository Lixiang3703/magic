//
//  KKIndustryItem.h
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKIndustryItem : YYBaseAPIItem

@property (nonatomic, assign) NSInteger industryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;

@end
