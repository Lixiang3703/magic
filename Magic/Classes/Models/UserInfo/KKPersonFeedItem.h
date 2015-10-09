//
//  KKPersonFeedItem.h
//  Link
//
//  Created by Lixiang on 14/12/10.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKPersonItem.h"

@interface KKPersonFeedItem : YYBaseAPIItem

@property (nonatomic, assign) double distance;
@property (nonatomic, strong) KKPersonItem *personItem;

@end
