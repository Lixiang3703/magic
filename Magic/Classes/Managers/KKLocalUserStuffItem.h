//
//  KKLocalUserStuffItem.h
//  Magic
//
//  Created by lixiang on 15/4/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDBaseItem.h"

@class KKChatItem;
@interface KKLocalUserStuffItem : DDBaseItem

/** Singleton */
+ (KKLocalUserStuffItem *)sharedItem;


/** Chat Failed RequestModels */
- (void)failChatAddChatItem:(KKChatItem *)chatItem sessionId:(NSString *)sessionId;
- (void)failChatRemoveChatItem:(KKChatItem *)chatItem sessionId:(NSString *)sessionId;
- (NSArray *)failChatItemsWithSessionId:(NSString *)sessionId;

@end
