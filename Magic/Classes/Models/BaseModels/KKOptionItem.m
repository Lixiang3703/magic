//
//  KKOptionItem.m
//  Link
//
//  Created by Lixiang on 14/11/8.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKOptionItem.h"

@implementation KKOptionItem

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.subItems = [[self class] itemsFromInfo:dict keyword:@"subItems" withClass:[KKOptionItem class]];
    }
    return self;
}


#pragma mark -
#pragma mark Dict methods
- (NSMutableDictionary *)infoDict {
    NSMutableDictionary *dict = [super infoDict];
    
    return dict;
}

@end
