//
//  KKSessionItem.m
//  Magic
//
//  Created by lixiang on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKSessionItem.h"

@implementation KKSessionItem

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.userPathes = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark Logic
- (void)sessionWillEnd {
    self.length = [[NSDate date] safeTimeIntervalSinceDate:[NSDate dateWithTimeStamp:self.startTimeStamp]];
}

@end
