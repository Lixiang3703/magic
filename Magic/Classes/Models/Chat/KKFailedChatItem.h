//
//  KKFailedChatItem.h
//  Link
//
//  Created by Lixiang on 14/12/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@class KKChatItem;

@interface KKFailedChatItem : YYBaseAPIItem

@property (nonatomic, assign) KKChatType type;
@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *fakeImageUrl;
@property (nonatomic, copy) NSString *originalImageUrl;


- (instancetype)initWithChatItem:(KKChatItem *)chatItem sessionId:(NSString *)sessionId;

@end
