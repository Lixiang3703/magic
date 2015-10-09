//
//  KKChatSessionItem.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKChatSessionItem.h"
#import "KKChatItem.h"
#import "KKPersonItem.h"

@implementation KKChatSessionItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.latestChatMsgItem = [KKChatItem itemWithDict:[dict objectForKey:@"latestChatMsg"]];
        self.toUserItem = [KKPersonItem itemWithDict:[dict objectForSafeKey:@"toUserItem"]];
    }
    return self;
}

@end