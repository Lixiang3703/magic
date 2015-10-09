//
//  KKMessageItem.m
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMessageItem.h"

@implementation KKMessageItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.caseItem = [KKCaseItem itemWithDict:[dict objectForSafeKey:@"caseItem"]];
    }
    return self;
}

@end
