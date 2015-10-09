//
//  KKAliPayManager.h
//  Magic
//
//  Created by lixiang on 15/6/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKOrderItem.h"
#import "KKAliPrePayItem.h"

#define Alipay_partner                  @"2088911777309879"
#define Alipay_seller                   @"2088911777309879"
#define Alipay_privateKey               @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAOqLOvQbxGNv8SKCDV/atW3ymoq0VmWCIl0cmhvLQ8BFgG1ytjfk6de1mY3k3JRF8hCbP/5k24xUbgNnFhOfuMbr3cZTFHXRFkrjk37Gg7e/RKc9gTVnGNIsGPtfdB0IoF1/IWwIDENOm2dzlvNxPwToTFoe7SWUw17XoX5TgJnHAgMBAAECgYBYztVIvwbSm/1TEqlbxSVzdyv7HyOjle3LEdxsb7+8mtRxHMFQUrYUfmehKao33nA0x4QooCndbc6mLS9XyN+egO97TdbXgbm+jZYUSo13njmevzR9UU+7YbhSQ7s1s79FCtFoNFRtV/O163pv9fVhToWLoHrLPfNj07+BaXi7eQJBAPpLyu4IPDAFym6sUhY2ek0I1pfaIN0yKi3VfnaFZO80RstOi67m+zTSf8vYAtyasOD447OsgiCDwRave78bW4sCQQDv44pgOoAqnBGVYfX+x9Zw1AMlukNjIbXKtKNBVA1VVv5yo/UY26Wf8Bu67jmwPrMAej17mXxWUHRszUWdkLI1AkEAuWefYIdVHjWL6ENZYv7jxWCApWd85J0eRWlaDi1twQs2Ta9XJS4QcuZip/rQ09z6nQuAkD1+/traExXWUo/PVQJAXSjldSdi3KlNXtDzQmWDDsAXFNC4GMhfm//4oocswmaNXCH2LhgmwuzxJ/AZ8Sr4Qwg11kkt8ys9e39gOKeXvQJAGXvUyix5m4UPPNwib1aXLFQSIy525UjWnbhEASAk2KHWie2j0WzdKnzijpvI8URao0zNs/ugoFRwkaa5feuvgQ=="
#define Alipay_appScheme                @"magic"

@interface KKAliPayManager : DDSingletonObject

/** Singleton */
+ (KKAliPayManager *)getInstance;

- (void)payWithAliPrePayItem:(KKAliPrePayItem *)prepayItem;
- (void)testPay;

@end
