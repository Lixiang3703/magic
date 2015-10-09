//
//  KKBasePhoneManager.m
//  Magic
//
//  Created by lixiang on 15/6/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBasePhoneManager.h"

@implementation KKBasePhoneManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKBasePhoneManager);

- (void)makePhoneForService{
    NSString *number = @"010-68576661";
    NSString *num = [[NSString alloc] initWithFormat:@"telprompt://%@",number];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]];
}

@end
