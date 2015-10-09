//
//  NSString+WebService.m
//  Wuya
//
//  Created by Tong on 08/08/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSString+WebService.h"

@implementation NSString (WebService)

+ (NSString *)stringForApiOrderType:(DDAPIListOrderType)type {
    return type == DDAPIListOrderTypeAsc ? @"asc" : @"desc";
}

@end
