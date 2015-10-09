//
//  NSString+WebService.h
//  Wuya
//
//  Created by Tong on 08/08/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDefinitions.h"

@interface NSString (WebService)

+ (NSString *)stringForApiOrderType:(DDAPIListOrderType)type;

@end
