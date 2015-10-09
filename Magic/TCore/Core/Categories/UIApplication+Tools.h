//
//  UIApplication+Tools.h
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (Tools)

+ (NSString *)appVersion;
+ (NSString *)wholeAppVersion;

+ (NSString *)apnsTokenWithRawDeviceToken:(NSData *)deviceToken;

@end
