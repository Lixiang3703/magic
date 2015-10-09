//
//  KKWeixinPayManager.h
//  Magic
//
//  Created by lixiang on 15/6/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKOrderItem.h"
#import "WXApi.h"
#import "WXApiObject.h"
#import "KKWeixinPrePayItem.h"

#define Weixin_APP_ID          @"wxb1974f616b764736"               //APPID
#define Weixin_APP_SECRET      @"a402008b3fb14e0aed41759ffcb38e99" //appsecret
#define Weixin_MCH_ID          @"1246007302"
#define Weixin_Api_Key         @"68576661685766616857666168576661"

#define Weixin_NOTIFY_URL      @"http://203.195.135.158/magic.web/pay/notify.html"

@interface KKWeixinPayManager : DDSingletonObject<WXApiDelegate>

/** Singleton */
+ (KKWeixinPayManager *)getInstance;

- (void)payWithOrderItem:(KKOrderItem *)orderItem;

- (void)payWithWeixinPrePayItem:(KKWeixinPrePayItem *)payItem;

@end
