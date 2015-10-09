//
//  DDPushHandler.h
//  Link
//
//  Created by Lixiang on 15/1/17.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

@interface DDPushHandler : DDSingletonObject

+ (DDPushHandler *)getInstance;

/** Application Push Delegate */
+ (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken;
+ (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error;
+ (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo;
+ (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo lauching:(BOOL)lauching;


/** Common Things */
- (void)requestAPNSService;
- (void)cleanBadge;


@end
