//
//  NSDateFormatter+YY.m
//  Wuya
//
//  Created by Tong on 18/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSDateFormatter+YY.h"

@implementation NSDateFormatter (YY)

+ (NSDateFormatter *)pmSessionFormater {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    dateFormater.timeZone = timeZone;
    dateFormater.dateFormat = @"yy-MM-dd";
    return dateFormater;
}

+ (NSDateFormatter *)pmSessionShortFormater {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    dateFormater.timeZone = timeZone;
    dateFormater.dateFormat = @"HH:mm";
    return dateFormater;
}

+ (NSDateFormatter *)pmFormater {
    NSDateFormatter *dateFormater = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    dateFormater.timeZone = timeZone;
    dateFormater.dateFormat = @"yy-MM-dd HH:mm";
    return dateFormater;
}

@end
