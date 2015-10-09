//
//  KKCaseTypeItem.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseTypeItem.h"

@implementation KKCaseTypeItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.type = [[dict objectForSafeKey:@"id"] integerValue];
    }
    return self;
}

@end
