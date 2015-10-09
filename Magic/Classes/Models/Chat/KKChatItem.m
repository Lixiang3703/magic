//
//  KKChatItem.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKChatItem.h"

@implementation KKChatItem

#pragma mark -
#pragma mark Initialzation
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.userItem = [KKPersonItem itemWithDict:[dict objectForSafeKey:@"userItem"]];
        
        self.audioItem = [KKAudioItem itemWithDict:[dict objectForSafeKey:@"audioItem"]];
        
        self.imageItem = [KKImageItem itemWithDict:[dict objectForSafeKey:@"imageItem"]];
    }
    return self;
}

@end
