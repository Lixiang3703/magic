//
//  KKCaseMessageItem.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseMessageItem.h"

@implementation KKCaseMessageItem

#pragma mark -
#pragma mark Initialzation
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.caseItem = [KKCaseItem itemWithDict:[dict objectForSafeKey:@"caseItem"]];
        self.imageItemArray = [[self class] itemsFromInfo:dict keyword:@"imageItemList" withClass:[KKImageItem class]];
    }
    return self;
}

@end
