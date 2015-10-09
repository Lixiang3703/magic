//
//  DDPushHandler.m
//  Link
//
//  Created by Lixiang on 15/1/17.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "DDPushHandler.h"
#import "DDPushItem.h"
#import "KKLoginManager.h"
#import "KKAppSettings.h"
#import "KKLauncher.h"

#import "KKAPNSTokenBindRequestModel.h"
#import "KKAPNSTokenUnBindRequestModel.h"

#import "YYMainTabContainerViewController.h"
#import "KKMessageListViewController.h"
#import "KKChatSessionDetailViewController.h"

@interface DDPushHandler()


@end


@implementation DDPushHandler
SYNTHESIZE_SINGLETON_FOR_CLASS(DDPushHandler);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Push VC Settings

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidLogin:) name:kLoginManager_Notification_DidLogIn object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidLogout:) name:kLoginManager_Notification_DidLogout object:nil];
    }
    return self;
}

#pragma mark -
#pragma mark APNS

+ (void)applicationDidRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    //  为了安全，每次都传token了
    NSString *newToken = [UIApplication apnsTokenWithRawDeviceToken:deviceToken];
    NSLog(@"newToken is :%@",newToken);
    
    [KKAppSettings getInstance].apnsToken = newToken;
    
    [[DDPushHandler getInstance] bindAPNSToken];
}

+ (void)applicationDidFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}

+ (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo {
    [[self class] handlePushInfo:userInfo shouldRevertViewControllers:YES animated:NO];
}

+ (void)applicationDidReceiveRemoteNotification:(NSDictionary *)userInfo lauching:(BOOL)lauching {
    [[self class] handlePushInfo:userInfo shouldRevertViewControllers:YES animated:NO];
}

#pragma mark -
#pragma mark Push Handler

+ (void)handlePushInfo:(NSDictionary *)pushInfo shouldRevertViewControllers:(BOOL)revert animated:(BOOL)animated {
    
    DDPushItem *pushItem = [DDPushItem itemWithDict:pushInfo];
    if (nil == pushItem || ![KKLoginManager getInstance].isLoggedIn) {
        return;
    }
    
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
    if (state == UIApplicationStateActive) {
        // 收到苹果推送消息之后更新全局消息数
        [[KKLauncher getInstance] checkUnreadInfo];
        
        switch (pushItem.t) {
            case DDPushTypeChat:
                [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_Chat_Push_Recieved object:pushItem userInfo:nil];
                break;
            case DDPushTypeMessage:
                break;
            default:
                break;
        }
    } else {
        [[self class] gotoPageWithPushItem:pushItem userInfo:nil shouldRevertViewControllers:revert animated:animated];
    }
}

#pragma mark -
#pragma mark GotoPage

+ (void)gotoPageWithPushItem:(DDPushItem *)pushItem userInfo:(id)userInfo shouldRevertViewControllers:(BOOL)revert animated:(BOOL)animated {
    UINavigationController *navigationController = [UINavigationController appNavigationController];
    if (revert) {
        [UINavigationController dismissAllViewControllerAnimated:animated];
        [navigationController popToRootViewControllerAnimated:animated];
    }
    
    switch (pushItem.t) {
        case DDPushTypeMessage:
        {
            [[YYMainTabContainerViewController sharedViewController] pushSwitchToIndex:KKMainTabIndexMessage];
            KKMessageListViewController *messageListViewController = [[YYMainTabContainerViewController sharedViewController].childViewControllers objectAtIndex:KKMainTabIndexMessage];
            if (messageListViewController && [messageListViewController isKindOfClass:[KKMessageListViewController class]]) {
                [messageListViewController dragDownRefresh];
            }
        }
            break;
        case DDPushTypeChat:
        {
            [[YYMainTabContainerViewController sharedViewController] pushSwitchToIndex:KKMainTabIndexMine];
            KKChatSessionDetailViewController *vc = [[KKChatSessionDetailViewController alloc] initWithPersonItem:[KKUserInfoItem sharedItem].servicePersonItem];
            [navigationController pushViewController:vc animated:animated];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark Common

- (void)requestAPNSService {
    if ([UIDevice below8]) {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
         UIRemoteNotificationTypeBadge|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeAlert];
    } else {
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

- (void)cleanBadge {
    //  Clear badge
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}

- (void)bindAPNSToken {
    NSString *token = [KKAppSettings getInstance].apnsToken;
    if (nil == token || ![KKLoginManager getInstance].isLoggedIn) {
        return;
    }
    
    KKAPNSTokenBindRequestModel *requestModel = [[KKAPNSTokenBindRequestModel alloc] init];
    requestModel.apnsToken = token;
    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
        //  Pass
    };
    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
        //  Pass
    };
    
    [requestModel load];
}

- (void)unbindAPNSToken {
    NSString *token = [DDAppSettings getInstance].apnsToken;
    if (nil == token) {
        return;
    }
    
    KKAPNSTokenUnBindRequestModel *requestModel = [[KKAPNSTokenUnBindRequestModel alloc] init];
    requestModel.apnsToken = token;
    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
        //  Pass
    };
    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
        //  Pass
    };
    
    [requestModel load];
    
}


#pragma mark -
#pragma mark Notification

- (void)appDidLogin:(NSNotification *)notification {
    [[DDPushHandler getInstance] bindAPNSToken];
}

- (void)appDidLogout:(NSNotification *)notification {
    BOOL force = [[[notification object] objectForSafeKey:@"force"] boolValue];
    
    if (force) {
        DDLog(@"Force YES");
        [self unbindAPNSToken];
    } else {
        DDLog(@"Force NO");
    }
}

@end
