//
//  KKAccountItem.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKAccountItem.h"
#import "KKLoginManager.h"

@implementation KKAccountItem

#pragma mark -
#pragma mark Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {

    }
    return self;
}

+ (KKAccountItem *)sharedItem {
    return [KKLoginManager getInstance].accountItem;
}

- (void)clear {
    [super clear];
    self.ticket = nil;
}

@end
