//
//  KKIndustryItem.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKIndustryItem.h"

@implementation KKIndustryItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.industryId = [[dict objectForSafeKey:@"id"] integerValue];
    }
    return self;
}

@end
