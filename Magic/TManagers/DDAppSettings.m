//
//  DDAppSettings.m
//  Link
//
//  Created by Lixiang on 14/10/23.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDAppSettings.h"
#import "WSDefinitions.h"
#import "KKAccountItem.h"

@implementation DDAppSettings

SYNTHESIZE_SINGLETON_FOR_CLASS(DDAppSettings);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSString *)userCustomKeywordFor:(NSString *)keyword {
    return [NSString stringWithFormat:@"%@%@", keyword, [KKAccountItem sharedItem].mobile];
}

#pragma mark -
#pragma mark Notifications
- (void)applicationDidFinishLaunchingNotification:(NSNotification *)notification {
    [self updateUserUsageCount];
}

- (void)applicationWillEnterForegroundNotification:(NSNotification *)notification {
    [self updateUserUsageCount];
}

- (void)updateUserUsageCount {
    self.userTotalSessions += 1;
    NSString *today = [NSDate todayString];
    
    if (![self.lastUseDate isEqualToString:today]) {
        self.userTodaySessions = 0;
        self.lastUseDate = today;
    }
    
    self.userTodaySessions += 1;
}

#pragma mark -
#pragma mark Settings

- (NSString *)appVersion {
    NSString *string = [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettings_AppVersion];
    if (nil == string) {
        string = @"0.0.1";
    }
    return string;
}

- (void)setAppVersion:(NSString *)appVersion {
    [[NSUserDefaults standardUserDefaults] setObject:appVersion forKey:kAppSettings_AppVersion];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)lastViewControllerName {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettings_LastViewControllerName];
}

- (void)setLastViewControllerName:(NSString *)lastViewControllerName {
    [[NSUserDefaults standardUserDefaults] setObject:lastViewControllerName forKey:kAppSettings_LastViewControllerName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)apnsToken {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettings_APNSToken];
}

- (void)setApnsToken:(NSString *)apnsToken {
    [[NSUserDefaults standardUserDefaults] setObject:apnsToken forKey:kAppSettings_APNSToken];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)apiHost {
    NSString *res = [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettings_APIHost];
    if (nil == res) {
        self.apiHost = kWS_URLString_Host;
        res = kWS_URLString_Host;
    }
    return res;
}

- (void)setApiHost:(NSString *)apiHost {
    [[NSUserDefaults standardUserDefaults] setObject:apiHost forKey:kAppSettings_APIHost];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)userTotalSessions {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kAppSettings_UserTotalSessions];
}

- (void)setUserTotalSessions:(NSInteger)userTotalSessions {
    [[NSUserDefaults standardUserDefaults] setInteger:userTotalSessions forKey:kAppSettings_UserTotalSessions];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSTimeInterval)userTotalLength {
    return [[NSUserDefaults standardUserDefaults] doubleForKey:kAppSettings_UserTotalLength];
}

- (void)setUserTotalLength:(NSTimeInterval)userTotalLength {
    [[NSUserDefaults standardUserDefaults] setDouble:userTotalLength forKey:kAppSettings_UserTotalLength];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)lastUseDate {
    return [[NSUserDefaults standardUserDefaults] stringForKey:kAppSettings_UserLastUseDate];
}

- (void)setLastUseDate:(NSString *)lastUseDate {
    [[NSUserDefaults standardUserDefaults] setObject:lastUseDate forKey:kAppSettings_UserLastUseDate];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)userTodaySessions {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kAppSettings_UserTodaySessions];
}

- (void)setUserTodaySessions:(NSInteger)userTodaySessions {
    [[NSUserDefaults standardUserDefaults] setInteger:userTodaySessions forKey:kAppSettings_UserTodaySessions];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)introItemInfo {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self userCustomKeywordFor:kAppSettings_Intro]];
}

- (void)setIntroItemInfo:(NSDictionary *)introItemInfo {
    [[NSUserDefaults standardUserDefaults] setObject:introItemInfo forKey:[self userCustomKeywordFor:kAppSettings_Intro]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
