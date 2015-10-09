//
//  KKAliPayManager.m
//  Magic
//
//  Created by lixiang on 15/6/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKAliPayManager.h"

#import "KKAliPrePayItem.h"
#import <AlipaySDK/AlipaySDK.h>
#import "DataSigner.h"


@implementation KKAliPayManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKAliPayManager);


- (void)payWithAliPrePayItem:(KKAliPrePayItem *)prepayItem {
    NSString *partner = Alipay_partner;
    NSString *seller = Alipay_seller;
    NSString *privateKey = Alipay_privateKey;
    
    prepayItem.partner = partner;
    prepayItem.seller = seller;
    
    prepayItem.service = @"mobile.securitypay.pay";
    prepayItem.paymentType = @"1";
    prepayItem.inputCharset = @"utf-8";
    prepayItem.itBPay = @"30m";
    prepayItem.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = Alipay_appScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [prepayItem description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
//            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Case_Pay_Success object:nil];
        }];
    }

}

- (void)testPay {
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *partner = Alipay_partner;
    NSString *seller = Alipay_seller;
    NSString *privateKey = Alipay_privateKey;
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([partner length] == 0 ||
        [seller length] == 0 ||
        [privateKey length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"缺少partner或者seller或者私钥。"
                                                       delegate:self
                                              cancelButtonTitle:@"确定"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    
    KKAliPrePayItem *order = [[KKAliPrePayItem alloc] init];
    order.partner = partner;
    order.seller = seller;
    
    order.tradeNO = @"001"; //订单ID（由商家自行制定）
    order.productName = @"title"; //商品标题
    order.productDescription = @"body"; //商品描述
    order.amount = 0.01; //商品价格
    order.notifyURL =  @"http://www.xxx.com"; //回调URL
    
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showUrl = @"m.alipay.com";
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = Alipay_appScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Case_Pay_Success object:nil];
        }];
    }

}

@end
