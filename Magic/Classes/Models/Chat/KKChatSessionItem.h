//
//  KKChatSessionItem.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@class KKChatItem;
@class KKPersonItem;

@interface KKChatSessionItem : YYBaseAPIItem

@property (nonatomic, strong) NSString *sessionId;

@property (nonatomic, assign) NSInteger caseId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger toUserId;
@property (nonatomic, assign) NSInteger unreadCount;


@property (nonatomic, strong) KKChatItem *latestChatMsgItem;
@property (nonatomic, strong) KKPersonItem *toUserItem;

@end
