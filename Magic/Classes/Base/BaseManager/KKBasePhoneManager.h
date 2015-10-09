//
//  KKBasePhoneManager.h
//  Magic
//
//  Created by lixiang on 15/6/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

@interface KKBasePhoneManager : DDSingletonObject

/** Singleton */
+ (KKBasePhoneManager *)getInstance;

- (void)makePhoneForService;

@end
