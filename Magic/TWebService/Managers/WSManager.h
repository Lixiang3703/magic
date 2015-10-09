//
//  WSManager.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"


#define kWS_Notification_NeedLogin  (@"kWS_Notification_NeedLogin")

@class WSBaseRequestModel;

@interface WSManager : DDSingletonObject

+ (WSManager *)getInstance;


/** Load */
- (void)loadWithRequestModel:(WSBaseRequestModel *)requestModel;

/** Error Info */
//- (NSString *)metaErrorModifyGroupMessage;
//- (NSString *)metaErrorFWordMessage;

/** Reset */
- (void)reset;

/** Newtork Indicator */
- (void)networkIndicatorEnabled:(BOOL)enabled;
- (void)networkIndicatorIncrementActivityCount;
- (void)networkIndicatorDecrementActivityCount;

@end
