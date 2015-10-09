//
//  KKAreaItem.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKAreaItem.h"

@implementation KKAreaItem

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {

    }
    return self;
}


#pragma mark -
#pragma mark Dict methods
- (NSMutableDictionary *)infoDict {
    NSMutableDictionary *dict = [super infoDict];
    
    return dict;
}

//+ (KKAreaItem *)copyFromAreaItem:(KKAreaItem *)item {
//    KKAreaItem *areaItem = [[KKAreaItem alloc] init];
//    if (item) {
//        areaItem.kkId = item.kkId;
//        areaItem.areaId = item.areaId;
//        areaItem.areaName = item.areaName;
//        areaItem.hot = item.hot;
//    }
//    return areaItem;
//}

@end
