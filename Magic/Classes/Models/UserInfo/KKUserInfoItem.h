//
//  KKUserInfoItem.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKPersonItem.h"

//TODO: UserInfo, personItem, accountItem, 各司其职，而loginItem 只是用来登录，登录完了 server返回 personItem 和 accountItem 然后 存到 KKUserInfoItem 里面，
// 单例路径：KKLoginManager -> KKAccountItem,  KKUserInfoItem -> KKPersonItem

//TODO: server 端，把 UserInfo 和 KKAccountItem 分开，看看是否重构，还有 UnreadInfoItem

// UserInfoItem 是用户的一些登录信息，而personItem 是具体的用户的其他具体信息

#define kServiceUser_Id         (1)

@interface KKUserInfoItem : YYBaseAPIItem

@property (nonatomic, strong) KKPersonItem *personItem;

@property (nonatomic, strong) KKPersonItem *servicePersonItem;

/** Singleton */
+ (KKUserInfoItem *)sharedItem;

@end
