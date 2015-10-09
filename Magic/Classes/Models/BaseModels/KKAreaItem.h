//
//  KKAreaItem.h
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKAreaItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *areaId;
@property (nonatomic, copy) NSString *areaName;
@property (nonatomic, copy) NSString *parentId;
@property (nonatomic, assign) NSInteger hot;

//+ (KKAreaItem *)copyFromAreaItem:(KKAreaItem *)areaItem;

@end
