//
//  KKLoginRequestModel.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKLoginRequestModel.h"



@implementation KKLoginRequestModel


#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_Login;
        
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && (nil == self.loginItem.mobile || nil == self.loginItem.password)) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.loginItem.mobile forKey:@"mobile"];
    [self.parameters setSafeObject:self.loginItem.password forKey:@"password"];

}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    if (error == nil) {
        return [self responseHanlderLoginSuccWithDataInfo:info];
    }
    return error;
}

@end
