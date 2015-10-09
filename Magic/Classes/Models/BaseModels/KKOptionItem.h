//
//  KKOptionItem.h
//  Link
//
//  Created by Lixiang on 14/11/8.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKOptionItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString *info;

@property (nonatomic, strong) NSArray *subItems;

@end
