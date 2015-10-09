//
//  DDSessionItem.m
//  PMP
//
//  Created by Tong on 20/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDSessionItem.h"

@implementation DDSessionItem

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        self.userPathes = [NSMutableArray array];
        self.serverFailRequestInfo = [NSMutableDictionary dictionary];
        self.events = [NSMutableArray array];
        self.eventCounter = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -
#pragma mark Logic
- (void)sessionWillEnd {
    self.length = [[NSDate date] safeTimeIntervalSinceDate:[NSDate dateWithTimeStamp:self.startTimeStamp]];
}

@end
