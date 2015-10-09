//
//  KKStatManager.m
//  Magic
//
//  Created by lixiang on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKStatManager2.h"
#import "KKGatherLogRequestModel.h"

@implementation KKStatManager2

#pragma mark -
#pragma mark Application Level Operations

- (void)applicationDidFinishLaunchingWithApplication:(UIApplication *)application {
    [self gatherLogWillBegin];
}

- (void)applicationDidEnterBackgroundWithApplication:(UIApplication *)application {
    [self gatherLogWillEnd];
}

- (void)applicationWillEnterForegroundWithApplication:(UIApplication *)application {
    [self gatherLogWillBegin];
}

- (void)applicationWillTerminateWithApplication:(UIApplication *)application {
    [self gatherLogWillEnd];
}

#pragma mark -
#pragma mark DDStat Template

//  上传数据
- (void)uploadGatherLog {
    NSString *gatherLogString = [self stringOfGatherLog];
    NSMutableArray *tempSessions = [NSMutableArray arrayWithArray:self.sessions];
    [[DDStat getInstance].sessions removeAllObjects];
    KKGatherLogRequestModel *requestModel = [[KKGatherLogRequestModel alloc] init];
    requestModel.gatherlog = gatherLogString;
    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
        DDLog(@"Gather Log uploaded");
        [[DDStat getInstance] saveGatherLogToFile];
    };
    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
        [tempSessions addObjectsFromArray:[DDStat getInstance].sessions];
        [DDStat getInstance].sessions = tempSessions;
    };
    [requestModel load];
}

- (NSString *)stringOfGatherLog {
    return @"";
}

@end
