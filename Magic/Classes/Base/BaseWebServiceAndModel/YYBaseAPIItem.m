//
//  YYBaseAPIItem.m
//  Wuya
//
//  Created by Tong on 15/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseAPIItem.h"

@implementation YYBaseAPIItem

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
//        self.ddId = [dict objectForSafeKey:@"id"];
        self.kkId = [[dict objectForSafeKey:@"id"] integerValue];
    }
    return self;
}


#pragma mark -
#pragma mark Dict methods
- (NSMutableDictionary *)infoDict {
    NSMutableDictionary *dict = [super infoDict];
//    [dict removeObjectForKey:@"ddId"];
//    [dict setSafeObject:self.ddId forKey:@"id"];
    [dict removeObjectForKey:@"kkId"];
    [dict setSafeObject:[NSNumber numberWithInteger:self.kkId] forKey:@"id"];

    return dict;
}

@end
