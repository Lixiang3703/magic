//
//  KKMessageItem.h
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKCaseItem.h"

@interface KKMessageItem : YYBaseAPIItem

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) KKMessageType type;
@property (nonatomic, assign) NSInteger caseId;
@property (nonatomic, assign) NSInteger caseMsgId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger broadcastId;
@property (nonatomic, assign) DDBaseItemBool hasRead;

@property (nonatomic, strong) KKCaseItem *caseItem;

@end
