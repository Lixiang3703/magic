//
//  KKLoginManager.h
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKLoginItem.h"

typedef NS_ENUM(NSInteger, KKLoginStatus) {
    KKLoginStatusUnknown = 0,
    KKLoginStatusLogin,
    KKLoginStatusLoginSuccess,
    
    KKLoginStatusRegisterSendMobileVerifyCode,
    KKLoginStatusRegister,
    
    KKLoginStatusForgetPasswordSendMobileVerifyCode,
    KKLoginStatusPasswordReset,
    
    KKLoginStatusChangePassword,
};

typedef void (^KKLoginStatusPrepareBlock)(KKLoginItem *loginItem);
typedef void (^KKLoginStatusSuccessBlock)(KKLoginItem *loginItem);
typedef void (^KKLoginStatusFailBlock)(NSError *error, KKLoginItem *loginItem);

#define kLoginManager_Notification_WillRegister     (@"kLMWillRegister")
#define kLoginManager_Notification_DidRegister      (@"kLMDidRegister")
#define kLoginManager_Notification_WillLogIn        (@"kLMWillLogIn")
#define kLoginManager_Notification_DidLogIn         (@"kLMDidLogIn")
#define kLoginManager_Notification_WillLogout       (@"kLMWillLogout")
#define kLoginManager_Notification_DidLogout        (@"kLMDidLogout")

@class KKAccountItem;

@interface KKLoginManager : DDSingletonObject



/** Initialization */
+ (KKLoginManager *)getInstance;

/** LoginItem */
@property (nonatomic, strong) KKLoginItem *loginItem;
/** AccountItem */
@property (nonatomic, strong) KKAccountItem *accountItem;

/** Login Status */
@property (nonatomic, readonly) BOOL isLoggedIn;
@property (nonatomic, readonly) KKLoginStatus loginStatus;

- (void)showLoginControllerWithAnimated:(BOOL)animated;

- (void)handleLoginStatus:(KKLoginStatus)loginStatus prepareBlock:(KKLoginStatusPrepareBlock)prepareBlock successBlock:(KKLoginStatusSuccessBlock)successBlock failBlock:(KKLoginStatusFailBlock)failBlock;

- (void)logoutWithForce:(BOOL)force;

/** Handler */
@property (nonatomic, copy) KKLoginStatusPrepareBlock loginStatusPrepareBlock;
@property (nonatomic, copy) KKLoginStatusSuccessBlock loginStatusSuccessBlock;
@property (nonatomic, copy) KKLoginStatusFailBlock loginStatusFailBlock;

@end
