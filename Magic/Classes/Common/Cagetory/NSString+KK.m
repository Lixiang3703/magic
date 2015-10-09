
//
//  NSString+KK.m
//  Link
//
//  Created by Lixiang on 14/11/9.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "NSString+KK.h"

@implementation NSString (KK)


#pragma mark -
#pragma mark Common

- (NSString *)stringForLinkMd5 {
    return [[NSString stringWithFormat:@"%@%@",@"link",self] md5String];
}


+ (NSString *)stringWithCreateTime:(NSTimeInterval)createTime {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeStamp:createTime]] ;
    timeInterval = MAX(0, timeInterval);
    
    NSString *resString = nil;
    if (timeInterval <= 1) {
        resString = [NSString stringWithFormat:@"1%@", _(@"秒前")];;
    } else if (timeInterval < 60) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval, _(@"秒前")];
    } else if (timeInterval < 60 * 60){
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / 60, _(@"分钟前")];
    } else if (timeInterval < 60 * 60 * 24) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60), _(@"小时前")];
    } else if (timeInterval < 60 * 60 * 24 * 30) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60 * 24), _(@"天前")];
    } else if (timeInterval < 60 * 60 * 24 * 30 * 12) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60 * 24 * 30), _(@"个月前")];
    } else {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60 * 24 * 30 * 12), _(@"年前")];
    }
    
    return resString;
}

+ (NSString *)stringWithEndTime:(NSTimeInterval)endTime {
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:[NSDate dateWithTimeStamp:endTime]];
    
    if (timeInterval > 0) {
        return [NSString stringWithCreateTime:endTime];
    }
    else {
        timeInterval = -timeInterval;
    }
    
    timeInterval = MAX(0, timeInterval);
    
    NSString *resString = nil;
    if (timeInterval <= 1) {
        resString = [NSString stringWithFormat:@"1%@", _(@"秒")];;
    } else if (timeInterval < 60) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval, _(@"秒")];
    } else if (timeInterval < 60 * 60){
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / 60, _(@"分钟")];
    } else if (timeInterval < 60 * 60 * 24) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60), _(@"小时")];
    } else if (timeInterval < 60 * 60 * 24 * 30) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60 * 24), _(@"天")];
    } else if (timeInterval < 60 * 60 * 24 * 30 * 12) {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60 * 24 * 30), _(@"个月")];
    } else {
        resString = [NSString stringWithFormat:@"%.0f%@", timeInterval / (60 * 60 * 24 * 30 * 12), _(@"年")];
    }
    
    resString = [resString stringByAppendingString:@"后"];
    
    return resString;
}

@end
