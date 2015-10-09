//
//  KKPersonFeedItem.m
//  Link
//
//  Created by Lixiang on 14/12/10.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKPersonFeedItem.h"


@implementation KKPersonFeedItem

#pragma mark -
#pragma mark Initialzation
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.personItem = [KKPersonItem itemWithDict:[dict objectForSafeKey:@"user"]];
    }
    return self;
}

@end
