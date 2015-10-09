//
//  KKWeixinPayManager.m
//  Magic
//
//  Created by lixiang on 15/6/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKWeixinPayManager.h"


@interface KKWeixinPayManager()

@end

@implementation KKWeixinPayManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKWeixinPayManager);

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        // WeixinPay
        [WXApi registerApp:Weixin_APP_ID withDescription:@"demo 2.0"];
    }
    return self;
}

- (void)payWithOrderItem:(KKOrderItem *)orderItem {
    
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = Weixin_APP_ID;
    req.partnerId           = Weixin_MCH_ID;
    req.prepayId            = @"wx20150612150830771bc7d0930686413913";
    req.nonceStr            = @"cc";
    req.timeStamp           = 1434086346;
    req.package             = @"Sign=WXPay";
    req.sign                = @"6A41A1AFC710D1A97BCD12BA89DEAC23";
    
    [WXApi sendReq:req];
    
}

- (void)payWithWeixinPrePayItem:(KKWeixinPrePayItem *)payItem {
    PayReq* req             = [[PayReq alloc] init];
    req.openID              = payItem.appid;
    req.partnerId           = payItem.partnerid;
    req.prepayId            = payItem.prepayid;
    req.nonceStr            = payItem.noncestr;
    req.timeStamp           = (UInt32)payItem.timestamp;
    req.package             = payItem.myPackage;
    req.sign                = payItem.sign;
    
    [WXApi sendReq:req];
}

#pragma mark -
#pragma mark WXApiDelegate


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        alert.tag = 1000;
//        [alert show];
        NSLog(@"strTitle:%@, strMsg:%@", strTitle, strMsg);
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        NSLog(@"strTitle:%@, strMsg:%@", strTitle, strMsg);
    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
        NSLog(@"strTitle:%@, strMsg:%@", strTitle, strMsg);
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
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
                strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//    [alert show];
    NSLog(@"strMsg:%@",strMsg);
}

@end
