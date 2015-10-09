//
//  KKChatSessionDetailViewController.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBaseSessionDetailViewController.h"

#import "KKChatListRequestModel.h"
#import "KKChatSessionLatestDetailsRequestModel.h"

#import "KKPersonItem.h"

@interface KKChatSessionDetailViewController : KKBaseSessionDetailViewController

@property (nonatomic, strong) KKChatListRequestModel *chatListRequestModel;
@property (nonatomic, strong) KKChatSessionLatestDetailsRequestModel *latestMsgRequestModel;

@property (nonatomic, copy) NSString *sessionId;
@property (nonatomic, strong) KKChatSessionItem *chatSessionItem;
@property (atomic, strong) NSMutableSet *chatItemIds;

- (instancetype)initWithChatSessionItem:(KKChatSessionItem *)chatSessionItem;
- (instancetype)initWithPersonItem:(KKPersonItem *)personItem;

- (void)reloadLatestMessages;

@end
