//
//  KKLocalUserStuffItem.m
//  Magic
//
//  Created by lixiang on 15/4/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//


#import "KKLocalUserStuffItem.h"
#import "KKAppSettings.h"
#import "KKFailedChatItem.h"
#import "KKChatItem.h"
#import "KKUserInfoItem.h"
#import "WSDownloadCache.h"
#import "KKAccountItem.h"

@interface KKLocalUserStuffItem()

@property (nonatomic, strong) NSMutableDictionary *failedChatItems;

@end

@implementation KKLocalUserStuffItem


#pragma mark -
#pragma mark Accessor

- (NSMutableDictionary *)failedChatItems {
    if (nil == _failedChatItems) {
        _failedChatItems = [[NSMutableDictionary alloc] init];
    }
    return _failedChatItems;
}

#pragma mark -
#pragma mark life cycle

+ (KKLocalUserStuffItem *)sharedItem {
    return [KKAppSettings getInstance].localUserStuffItem;
}

- (void)clear {
}

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        //  Mutable ChatSessions
        __block NSMutableDictionary *tempDictionaryChat = [NSMutableDictionary dictionaryWithCapacity:[self.failedChatItems count]];
        [self.failedChatItems enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSArray *obj, BOOL *stop) {
            [tempDictionaryChat setSafeObject:[obj mutableCopy] forKey:key];
        }];
        self.failedChatItems = tempDictionaryChat;
    }
    return self;
}


#pragma mark -
#pragma mark Override
+ (NSString *)savePath {
    return [NSString filePathOfDocumentFolderWithName:[NSString stringWithFormat:@"MyHouse%@%@", [[self class] description], [KKAccountItem sharedItem].mobile]];
}


#pragma mark -
#pragma mark Chat Failed RequestModels

- (NSMutableArray *)failChatItemInfosWithSessionId:(NSString *)sessionId {
    NSMutableArray *res = [self.failedChatItems objectForSafeKey:sessionId];
    
    if (nil == res) {
        res = [NSMutableArray array];
        [self.failedChatItems setSafeObject:res forKey:sessionId];
    }
    
    return res;
}

- (void)failChatAddChatItem:(KKChatItem *)chatItem sessionId:(NSString *)sessionId {
    NSMutableArray *failChatItemInfos = [self failChatItemInfosWithSessionId:sessionId];
    KKFailedChatItem *failedChatItem = [[KKFailedChatItem alloc] initWithChatItem:chatItem sessionId:sessionId];
    
    // 这个if语句的意思，好像就是把 如果是 NSArray类型的failChatItemInfos 转成 NSMutableArray
    if (![failChatItemInfos isKindOfClass:[NSMutableArray class]] && [failChatItemInfos isKindOfClass:[NSArray class]]) {
        NSMutableArray *newFailChatItemInfos = [failChatItemInfos mutableCopy];
        [self.failedChatItems setSafeObject:newFailChatItemInfos forKey:sessionId];
        failChatItemInfos = newFailChatItemInfos;
    }
    
    [failChatItemInfos addSafeObject:[failedChatItem infoDict]];
    
    [self save];
}

- (void)failChatRemoveChatItem:(KKChatItem *)chatItem sessionId:(NSString *)sessionId {
    NSMutableArray *failChatItemInfos = [self failChatItemInfosWithSessionId:sessionId];
    
    NSDictionary *deleteInfo = nil;
    for (NSDictionary *info in failChatItemInfos) {
        KKFailedChatItem *failedChatItem = [KKFailedChatItem itemWithDict:info];
        if (chatItem.insertTimestamp == failedChatItem.insertTimestamp) {
            deleteInfo = info;
            break;
        }
    }
    
    [failChatItemInfos removeObject:deleteInfo];
    
    if ([failChatItemInfos count] == 0) {
        [self.failedChatItems removeObjectForKey:sessionId];
    }
    
    [self save];
}

- (NSArray *)failChatItemsWithSessionId:(NSString *)sessionId {
    NSMutableArray *failChatItemInfos = [self failChatItemInfosWithSessionId:sessionId];
    
    NSMutableArray *res = [NSMutableArray arrayWithCapacity:[failChatItemInfos count]];
    
    KKChatItem *pmItem = nil;
    KKFailedChatItem *failedPMItem = nil;
    
    NSMutableArray *errorInfos = [NSMutableArray array];
    
    for (NSDictionary *info in failChatItemInfos) {
        pmItem = [[KKChatItem alloc] init];
        pmItem.fake = YES;
        pmItem.mine = DDBaseItemBoolTrue;
        pmItem.userItem = [KKUserInfoItem sharedItem].personItem;
        
        failedPMItem = [KKFailedChatItem itemWithDict:info];
        
        pmItem.type = failedPMItem.type;
        pmItem.content = failedPMItem.content;
        pmItem.insertTimestamp = failedPMItem.insertTimestamp;
        pmItem.originalImage = [[WSDownloadCache getInstance] imageWithUrl:failedPMItem.originalImageUrl];
        pmItem.fakeImage = [[WSDownloadCache getInstance] imageWithUrl:failedPMItem.fakeImageUrl];
        
        
        if (nil == pmItem.content && nil == pmItem.fakeImage) {
            DDLog(@"Error, check");
            [errorInfos addSafeObject:info];
        } else {
            [res addSafeObject:pmItem];
        }
    }
    
    //  Save if need update
    if ([errorInfos count] > 0) {
        [failChatItemInfos removeObjectsInArray:errorInfos];
        [self save];
    }
    
    return res;
}

@end
