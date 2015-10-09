//
//  AppDelegate.m
//  Magic
//
//  Created by lixiang on 15/4/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "AppDelegate.h"
#import "YYNavigationController.h"
#import "YYMainTabContainerViewController.h"

#import "WSGlobal.h"
#import "KKLauncher.h"
#import "KKStatManager.h"
#import "DDPushHandler.h"
#import "KKWeixinPayManager.h"

@interface AppDelegate ()<WXApiDelegate>

@property (nonatomic, strong) YYNavigationController *rootNavigationController;
@property (nonatomic, strong) YYMainTabContainerViewController *mainTabContainerViewController;

@end

@implementation AppDelegate

#pragma mark -
#pragma mark Global

+ (AppDelegate *)sharedAppDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //  Window
    self.rootNavigationController = [[YYNavigationController alloc] init];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    self.window.rootViewController = self.rootNavigationController;
    
    self.mainTabContainerViewController = [[YYMainTabContainerViewController alloc] init];
    [self.rootNavigationController pushViewController:self.mainTabContainerViewController animated:NO];
    
    //  Network Settings
    [WSGlobal globalSettings];
    
    //  DataHelper
    [[KKLauncher getInstance] appDidFinishLaunchingWithOptions:launchOptions];
    
    // Gather Log
    [[KKStatManager getInstance] applicationDidFinishLaunchingWithApplication:application];
    
    //  Window
    [self.window makeKeyAndVisible];
    
    //  APNS
    [[DDPushHandler getInstance] requestAPNSService];
    [DDPushHandler applicationDidReceiveRemoteNotification:[launchOptions objectForSafeKey:UIApplicationLaunchOptionsRemoteNotificationKey] lauching:YES];
    
    // WeixinPay
    [WXApi registerApp:Weixin_APP_ID withDescription:@"demo 2.0"];
    
    return YES;
}

#pragma mark -
#pragma mark push

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [DDPushHandler applicationDidRegisterForRemoteNotificationsWithDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"error:%@",error.domain);
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [DDPushHandler applicationDidReceiveRemoteNotification:userInfo];
}

#pragma mark -
#pragma mark app

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [[KKStatManager getInstance] applicationDidEnterBackgroundWithApplication:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [[KKStatManager getInstance] applicationWillEnterForegroundWithApplication:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[DDPushHandler getInstance] cleanBadge];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [[KKStatManager getInstance] applicationWillTerminateWithApplication:application];
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return  [WXApi handleOpenURL:url delegate:[KKWeixinPayManager getInstance]];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    // For pay withou check success or not
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Case_Pay_Success object:nil];
    
    return  [WXApi handleOpenURL:url delegate:[KKWeixinPayManager getInstance]];
}

#pragma mark -
#pragma mark WeixinPay

- (void)payWithOrderItem {
    
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = Weixin_APP_ID;
    req.partnerId           = Weixin_MCH_ID;
    req.prepayId            = @"wx20150613224615015b0508ff0046301572";
    req.nonceStr            = @"cc";
    req.timeStamp           = 1434206777;
    req.package             = @"Sign=WXPay";
    req.sign                = @"0E68F2F62F33D4A51B921EB33A6C9FB5";
    
    [WXApi sendReq:req];
    
}

-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];

    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
            {
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
//                [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Case_Pay_Success object:nil];
            }
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

@end
