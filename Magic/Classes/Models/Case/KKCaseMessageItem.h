//
//  KKCaseMessageItem.h
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKImageItem.h"
#import "KKAudioItem.h"
#import "KKCaseItem.h"

@interface KKCaseMessageItem : YYBaseAPIItem

@property (nonatomic, assign) NSInteger caseId;
@property (nonatomic, assign) NSInteger caseMsgId;
@property (nonatomic, assign) NSInteger toUserId;
@property (nonatomic, assign) NSInteger fromUserId;

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *imageIds;
@property (nonatomic, strong) NSArray *imageItemArray;
@property (nonatomic, strong) KKCaseItem *caseItem;

@end
