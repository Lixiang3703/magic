//
//  KKFailedChatItem.m
//  Link
//
//  Created by Lixiang on 14/12/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKFailedChatItem.h"
#import "KKChatItem.h"
#import "WSDownloadCache.h"

@implementation KKFailedChatItem

- (instancetype)initWithChatItem:(KKChatItem *)chatItem sessionId:(NSString *)sessionId {
    self = [super init];
    
    if (self) {
        self.type = chatItem.type;
        self.sessionId = sessionId;
        self.content = chatItem.content;
        self.insertTimestamp = chatItem.insertTimestamp;
        self.fakeImageUrl = [NSString stringWithFormat:@"fake|%@|%.0f", sessionId, chatItem.insertTimestamp];
        self.originalImageUrl = [NSString stringWithFormat:@"original|%@|%.0f", sessionId, chatItem.insertTimestamp];
        
        if (![[WSDownloadCache getInstance] cacheDidExistWithUrl:self.fakeImageUrl resource:YES]) {
            [[WSDownloadCache getInstance] saveImage:chatItem.fakeImage headers:nil forUrl:self.fakeImageUrl];
        }
        if (![[WSDownloadCache getInstance] cacheDidExistWithUrl:self.originalImageUrl resource:YES]) {
            [[WSDownloadCache getInstance] saveImage:chatItem.originalImage headers:nil forUrl:self.originalImageUrl];
        }
    }
    return self;
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        
    }
    return self;
}

@end
