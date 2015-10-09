//
//  KKLogoutRequestModel.m
//  Link
//
//  Created by lixiang on 15/1/22.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKLogoutRequestModel.h"

@implementation KKLogoutRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        self.modelName = kLink_WS_Model_Logout;
        self.agent = YES;
        self.diaplayErrorInfo = NO;
        self.shouldLoadResultSaveLocal = NO;
    }
    return self;
}


#pragma mark -
#pragma mark Parames


- (void)paramsSettings {
    [super paramsSettings];
    
}


#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}

@end
