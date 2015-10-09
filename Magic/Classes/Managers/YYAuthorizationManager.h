//
//  YYAuthorizationManager.h
//  Wuya
//
//  Created by lixiang on 15/3/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

typedef NS_ENUM(NSUInteger, YYAuthorizationType) {
    YYAuthorizationTypeUnKnown,
    YYAuthorizationTypeCamera,
    YYAuthorizationTypeAsset,
    YYAuthorizationTypeCount
};

@interface YYAuthorizationManager : DDSingletonObject

/** Singleton */
+ (YYAuthorizationManager *)getInstance;

- (BOOL)checkAuthorizationWithType:(YYAuthorizationType)type;

@end
