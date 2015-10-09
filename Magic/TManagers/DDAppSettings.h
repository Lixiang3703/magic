//
//  DDAppSettings.h
//  Link
//
//  Created by Lixiang on 14/10/23.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

#define kAppSettings_AppVersion                     (@"kASAppVersion")
#define kAppSettings_LastViewControllerName         (@"kASLastViewControllerName")

#define kAppSettings_APNSToken                      (@"kASAPNSToken")
#define kAppSettings_APIHost                        (@"kASAPIHost")
#define kAppSettings_Intro                          (@"kASIntro")

#define kAppSettings_UserTotalSessions              (@"kASUserTotalSessions")
#define kAppSettings_UserTotalLength                (@"kASUserTotalLength")
#define kAppSettings_UserTodaySessions              (@"kASUserTodaySessions")
#define kAppSettings_UserLastUseDate                (@"kASUserLastUseDate")

@interface DDAppSettings : DDSingletonObject

/** Singleton */
+ (DDAppSettings *)getInstance;

/** Device App Version */
@property (nonatomic, readwrite) NSString *appVersion;

/** Last Foreground ViewController Name */
@property (nonatomic, readwrite) NSString *lastViewControllerName;

/** Intro */
@property (nonatomic, readwrite) NSDictionary *introItemInfo;

/** APNS */
@property (nonatomic, readwrite) NSString *apnsToken;

/** API */
@property (nonatomic, readwrite) NSString *apiHost;

//  Total usage
@property (nonatomic, readwrite) NSInteger userTotalSessions;
@property (nonatomic, readwrite) NSTimeInterval userTotalLength;
@property (nonatomic, readwrite) NSString *lastUseDate;
@property (nonatomic, readwrite) NSInteger userTodaySessions;

@end
