//
//  KKUnreadInfoItem.h
//  Link
//
//  Created by Lixiang on 15/1/17.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "DDBaseItem.h"

@interface KKUnreadInfoItem : DDBaseItem

@property (nonatomic, assign) NSUInteger newMsg;

@property (nonatomic, assign) NSUInteger chatMsgUnread;

@property (nonatomic, assign) NSUInteger newFansCount;

@property (nonatomic, assign, readonly) NSUInteger totalUnreadCount;


/** Singleton */
+ (KKUnreadInfoItem *)sharedItem;

@end
