//
//  NSString+KK.h
//  Link
//
//  Created by Lixiang on 14/11/9.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (KK)

/** Common */
- (NSString *)stringForLinkMd5;

+ (NSString *)stringWithCreateTime:(NSTimeInterval)createTime;
+ (NSString *)stringWithEndTime:(NSTimeInterval)endTime;

@end
