//
//  KKAppSettings.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDAppSettings.h"
#import "KKUserInfoItem.h"
#import "KKUnreadInfoItem.h"
#import "KKLocalUserStuffItem.h"

#define kAppSettings_PersonFeedGender               (@"kAS_PersonFeedGender")
#define kAppSettings_SearchHistoryArray               (@"kAS_SearchHistoryArray")
#define kAppSettings_APNSToken                      (@"kASAPNSToken")

@interface KKAppSettings : DDAppSettings

/** Singleton */
+ (KKAppSettings *)getInstance;

/** ConstantItem */
@property (nonatomic, strong) KKUserInfoItem *userInfoItem;
@property (nonatomic, strong) KKUnreadInfoItem *unreadInfoItem;


/** DDLocalUserStuffItem */
@property (nonatomic, strong) KKLocalUserStuffItem *localUserStuffItem;

/** APNS */
@property (nonatomic, readwrite) NSString *apnsToken;

@property (nonatomic, strong) NSArray *searchHistoryArray;

@end
