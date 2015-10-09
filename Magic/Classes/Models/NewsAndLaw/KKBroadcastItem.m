//
//  KKBroadcastItem.m
//  Magic
//
//  Created by lixiang on 15/5/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBroadcastItem.h"

@implementation KKBroadcastItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.imageItem = [KKImageItem itemWithDict:[dict objectForSafeKey:@"imageItem"]];
    }
    return self;
}

@end
