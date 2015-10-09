//
//  NSString+YY.m
//  Wuya
//
//  Created by Tong on 18/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSString+YY.h"

@implementation NSString (YY)

#pragma mark -
#pragma mark Common

+ (NSString *)stringWithYYCount:(NSInteger)count {
    return [[self class] stringWithYYCount:count defaultString:nil];
}

+ (NSString *)stringWithYYCount:(NSInteger)count defaultString:(NSString *)defaultString {
    if (count <= 0) {
        return defaultString;
    } else if (count < 1000) {
        return [NSString stringWithFormat:@"%ld", (long)count];
    } else if (count < 1000000) {
        return [NSString stringWithFormat:@"%ldk", (long)(count / 1000)];
    } else {
        return [NSString stringWithFormat:@"%ldM", (long)(count / 1000000)];
    }
    return nil;
}

+ (NSString *)stringWithDistance:(double)distance {
    NSString *resString = nil;
    if (distance < 0) {
        resString = nil;
    } else if (distance >= 100) {
        resString = [NSString stringWithFormat:@"%.1f km", distance * 1.0 / 1000];
    } else {
        resString = @"< 0.1km";
    }
    
    return resString;
}

@end

