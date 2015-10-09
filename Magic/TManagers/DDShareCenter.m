//
//  DDShareCenter.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDShareCenter.h"

#import "WSDownloadCache.h"

#import "WXApiObject.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/TencentOAuthObject.h>
#import <TencentOpenAPI/TencentApiInterface.h>
#import "TencentOpenAPI/QQApiInterface.h"
#import "TencentOpenAPI/QQApi.h"


@interface DDShareCenter () <TencentSessionDelegate>

@property (nonatomic, strong) TencentOAuth *tencentOAuth;

@end

@implementation DDShareCenter
SYNTHESIZE_SINGLETON_FOR_CLASS(DDShareCenter);

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        [WXApi registerApp:kAppSetting_WeiXin_AppId];
        [WeiboSDK registerApp:kAppSetting_Weibo_AppKey];
        self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:kAppSetting_QQ_AppId andDelegate:self];
        [self.tencentOAuth getUserInfo];
    }
    return self;
}


#pragma mark -
#pragma mark Base Share Operation

- (void)shareWeiboWithTitle:(NSString *)title image:(UIImage *)image {
    
    WBMessageObject *message = [WBMessageObject message];
    message.text = title;
    
    WBImageObject *imageObject = [WBImageObject object];
    imageObject.imageData = UIImageJPEGRepresentation(image, 1.0);
    message.imageObject = imageObject;
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
    [WeiboSDK sendRequest:request];
}

- (void)shareQQWithTitle:(NSString *)title desc:(NSString *)desc url:(NSString *)url thumbImage:(UIImage *)image scene:(int)scene {
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url]
                                                        title:title
                                                  description:desc
                                             previewImageData:UIImageJPEGRepresentation(image, 1.0)];
    
    QQApiObject *_qqApiObject = newsObj;
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:_qqApiObject];
    if (scene == 0) {
        [QQApiInterface sendReq:req];
    }
    else if (scene == 1)
    {
        [QQApiInterface SendReqToQZone:req];
    }
}

- (void)shareWechatWithTitle:(NSString *)title desc:(NSString *)desc link:(NSString *)url thumbImage:(UIImage *)image scene:(int)scene {
    if (![WXApi isWXAppInstalled]) {
        [[[UIAlertView alloc] initWithTitle:_(@"该设备还没有安装微信")
                                    message:_(@"现在就去安装，与好友一起互动吧")
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:_(@"好"), nil] show];
        return;
    }
    
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = title;
    message.description = desc;
    
    [message setThumbImage:image];
    
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = url;
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = scene;
    
    if (![WXApi sendReq:req]) {
        [[[UIAlertView alloc] initWithTitle:_(@"同步微信失败")
                                    message:_(@"请稍后重试")
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:_(@"好"), nil] show];
    }
    
}


- (void)inviteViaQQssoWithScene:(int)scene {
    QQApiNewsObject *newsObj = [QQApiNewsObject objectWithURL:[NSURL URLWithString:@"http://www.baidu.com"]
                                                        title:@"知产通"
                                                  description:@"slogan"
                                             previewImageData:UIImageJPEGRepresentation([UIImage imageNamed:@"app-icon"], 1.0)];
    
    QQApiObject *_qqApiObject = newsObj;
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:_qqApiObject];
    if (scene == 0) {
        [QQApiInterface sendReq:req];
    }
    else if (scene == 1)
    {
        [QQApiInterface SendReqToQZone:req];
    }
}

#pragma mark -
#pragma mark WXApiDelegate

- (void)onReq:(BaseReq*)req {
    
}

- (void)onResp:(BaseResp*)resp {
    
}

#pragma mark -
#pragma mark TencentSessionDelegate
/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin {
    
}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled {
    
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork {
    
}

- (BOOL)onTencentReq:(TencentApiReq *)req
{
    return YES;
}

- (BOOL)onTencentResp:(TencentApiResp *)resp
{
    return YES;
}

#pragma mark -
#pragma mark checkInstalled

+ (BOOL)checkInstalledQQ {
    return [TencentOAuth iphoneQQInstalled];
}

+ (BOOL)checkInstalledWechat {
    return [WXApi isWXAppInstalled];
}

+ (BOOL)checkInstalledWeibo {
    return [WeiboSDK isWeiboAppInstalled];
}


@end
