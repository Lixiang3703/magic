//
//  DDPushItem.h
//  Link
//
//  Created by Lixiang on 15/1/18.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "DDBaseItem.h"

typedef NS_ENUM(NSInteger, DDPushType) {
    DDPushTypeUnknown = 0,
    DDPushTypeMessage = 1,                      //  消息
    DDPushTypeChat = 2,                         //  消息
    DDPushTypeCount,
};

@interface DDPushItem : DDBaseItem

@property (nonatomic, assign) DDPushType t;
@property (nonatomic, copy) NSString *i;    //  第一个参数
@property (nonatomic, copy) NSString *p;    //  第二个参数
@property (nonatomic, copy) NSString *s;    //  统计使用

@end
