//
//  KKUnreadInfoItem.m
//  Link
//
//  Created by Lixiang on 15/1/17.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKUnreadInfoItem.h"
#import "KKAppSettings.h"

@implementation KKUnreadInfoItem

- (void)customSettingsBeforeAutoParse {
    [super customSettingsBeforeAutoParse];
    
}

+ (KKUnreadInfoItem *)sharedItem {
    return [KKAppSettings getInstance].unreadInfoItem;
}

- (void)clearAndSave {
    [super clearAndSave];
    
}

- (NSUInteger)totalUnreadCount {
    NSUInteger total = self.newMsg + self.newFansCount + self.chatMsgUnread;
    return (total > 0) ? total : 0;
}

@end
