//
//  KKChatItem.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKPersonItem.h"
#import "KKImageItem.h"
#import "KKAudioItem.h"

@interface KKChatItem : YYBaseAPIItem

@property (nonatomic, strong) NSString *sessionId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, assign) NSInteger toUserId;
@property (nonatomic, assign) NSInteger hasRead;

@property (nonatomic, strong) KKPersonItem *userItem;

@property (nonatomic, assign) KKChatType type;
@property (nonatomic, assign) DDBaseItemBool mine;

@property (nonatomic, strong) UIImage *fakeImage; 
@property (nonatomic, strong) UIImage *originalImage;

@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) KKImageItem *imageItem;
@property (nonatomic, strong) KKAudioItem *audioItem;

@end
