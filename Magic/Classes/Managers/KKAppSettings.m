//
//  KKAppSettings.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKAppSettings.h"
#import "KKAccountItem.h"

@implementation KKAppSettings
SYNTHESIZE_SINGLETON_FOR_CLASS(KKAppSettings);

- (KKUserInfoItem *)userInfoItem {
    if (_userInfoItem == nil) {
        _userInfoItem = [[KKUserInfoItem alloc] init];
    }
    return _userInfoItem;
}

- (KKLocalUserStuffItem *)localUserStuffItem {
    if (_localUserStuffItem == nil) {
        _localUserStuffItem = [KKLocalUserStuffItem loadSavedItem];
    }
    return _localUserStuffItem;
}

- (KKUnreadInfoItem *)unreadInfoItem {
    if (_unreadInfoItem == nil) {
        _unreadInfoItem = [KKUnreadInfoItem loadSavedItem];
    }
    return _unreadInfoItem;
}

- (NSString *)userCustomKeywordFor:(NSString *)keyword {
    return [NSString stringWithFormat:@"%@-%ld", keyword, (long)[KKAccountItem sharedItem].userId];
}

- (void)setSearchHistoryArray:(NSArray *)searchHistoryArray {
    [[NSUserDefaults standardUserDefaults] setObject:searchHistoryArray forKey:[self userCustomKeywordFor:kAppSettings_SearchHistoryArray]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSArray *)searchHistoryArray {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self userCustomKeywordFor:kAppSettings_SearchHistoryArray]];
}

- (NSString *)apnsToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettings_APNSToken];
}

- (void)setApnsToken:(NSString *)apnsToken {
    [[NSUserDefaults standardUserDefaults] setObject:apnsToken forKey:kAppSettings_APNSToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
