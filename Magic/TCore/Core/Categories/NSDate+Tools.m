//
//  NSDate+Tools.m
//  Wuya
//
//  Created by Tong on 18/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSDate+Tools.h"

@implementation NSDate (Tools)

+ (NSDate *)dateWithTimeStamp:(NSTimeInterval)timeStamp {
    if (0 == timeStamp) {
        return nil;
    }
    return [NSDate dateWithTimeIntervalSince1970:timeStamp / 1000];
}

- (NSTimeInterval)timeStamp {
    return [self timeIntervalSince1970] * 1000;
}

+ (NSString *)todayString {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    dateFormater.timeZone = timeZone;
    dateFormater.dateFormat = @"yyyy-MM-dd";
    
    return [dateFormater stringFromDate:[NSDate date]];
}

- (NSTimeInterval)safeTimeIntervalSinceDate:(NSDate *)date defaultValue:(NSTimeInterval)defaultValue {
    if (nil == date) {
        return defaultValue;
    }
    return [self timeIntervalSinceDate:date];
}

- (NSTimeInterval)safeTimeIntervalSinceDate:(NSDate *)date {
    return [self safeTimeIntervalSinceDate:date defaultValue:0];
}

@end
