//
//  UIApplication+Tools.m
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIApplication+Tools.h"

@implementation UIApplication (Tools)

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

+ (NSString *)wholeAppVersion {
    return [NSString stringWithFormat:@"%@(0)", [UIApplication appVersion]];
}


// e.g. <341bf0b2 23f00acf eddaf7f0 24f68445 3920aa2a ebbba502 e95484db 652d3a40>
+ (NSString *)apnsTokenWithRawDeviceToken:(NSData *)deviceToken {
    NSString *token=[NSString stringWithFormat:@"%@",deviceToken];
	token=[token substringWithRange:NSMakeRange(1, [token length]-2)];
	token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return token;
}

@end
