//
//  KKLoginItem.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKLoginItem.h"

@implementation KKLoginItem

- (instancetype)init {
    self = [super init];
    if (self) {
        self.personItem = [[KKPersonItem alloc] init];
    }
    return self;
}

@end
