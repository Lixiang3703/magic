//
//  NSDate+Tools.h
//  Wuya
//
//  Created by Tong on 18/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Tools)

+ (NSDate *)dateWithTimeStamp:(NSTimeInterval)timeStamp;
- (NSTimeInterval)timeStamp;
+ (NSString *)todayString;

- (NSTimeInterval)safeTimeIntervalSinceDate:(NSDate *)date defaultValue:(NSTimeInterval)defaultValue;
- (NSTimeInterval)safeTimeIntervalSinceDate:(NSDate *)date;

@end
