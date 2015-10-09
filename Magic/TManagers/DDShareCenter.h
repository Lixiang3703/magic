//
//  DDShareCenter.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "WXApi.h"

#define kAppSetting_WeiXin_AppId                    (@"wxb1974f616b764736")
#define kAppSetting_Weibo_AppKey                    (@"2264023018")
#define kAppSetting_QQ_AppId                        (@"1104233711")

//#define kAppSetting_WeiXin_AppId                    (@"wx242cb69a720d6265")
//#define kAppSetting_Weibo_AppKey                    (@"3231675494")
//#define kAppSetting_QQ_AppId                        (@"101139487")

typedef enum {
    sharePlatform_weixinSession = 0,
    sharePlatform_weixinTimeline,
    sharePlatform_qq,
    sharePlatform_qzone,
    sharePlatform_weibo
} sharePlatform;

@interface DDShareCenter : DDSingletonObject<WXApiDelegate>

+ (DDShareCenter *)getInstance;
+ (BOOL)checkInstalledQQ;
+ (BOOL)checkInstalledWechat;
+ (BOOL)checkInstalledWeibo;


/** Base share operation. */
- (void)shareWeiboWithTitle:(NSString *)title image:(UIImage *)image;
- (void)shareQQWithTitle:(NSString *)title desc:(NSString *)desc url:(NSString *)url thumbImage:(UIImage *)image scene:(int)scene;
- (void)shareWechatWithTitle:(NSString *)title desc:(NSString *)desc link:(NSString *)url thumbImage:(UIImage *)image scene:(int)scene;

// QQ share
- (void)inviteViaQQssoWithScene:(int)scene;

@end
