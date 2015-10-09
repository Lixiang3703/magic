//
//  DDLauncher.h
//  Link
//
//  Created by Lixiang on 14/10/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "WSBaseRequestModel.h"

@interface DDLauncher : DDSingletonObject

/** Singleton */
+ (DDLauncher *)getInstance;

/** Update Logic */
- (void)appDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
- (void)applicationWillEnterForeground;


- (void)singletonManagersPass;
- (void)checkAppUpdate;

- (void)checkRemoteAppConstant;
- (void)checkUserInfo;
- (void)checkUnreadInfo;
- (void)checkUnreadInfoWithForce:(BOOL)force successBlock:(WSSuccessBlock)successBlock failBlock:(WSFailBlock)failBlock;
- (void)checkAddressBookContacts;

@end
