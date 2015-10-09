//
//  KKPasswordMobileResetRequestModel.m
//  Link
//
//  Created by lixiang on 15/2/9.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKPasswordMobileResetRequestModel.h"

@implementation KKPasswordMobileResetRequestModel

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.modelName = kLink_WS_Model_Password_Mobile_Reset;
        self.methodName = @"GET";
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && (nil == self.loginItem.mobile || nil == self.loginItem.forgetCode || nil == self.loginItem.password)) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}
- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.loginItem.mobile forKey:@"mobile"];
    [self.parameters setSafeObject:self.loginItem.forgetCode forKey:@"code"];
    [self.parameters setSafeObject:self.loginItem.password forKey:@"password"];
}

#pragma mark -
#pragma mark Hanlder
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    if (nil == error) {
        
    }
    return error;
}

@end
