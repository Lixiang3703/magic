//
//  KKRegisterRequestModel.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKRegisterRequestModel.h"

@implementation KKRegisterRequestModel

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_Register_Submit;
        
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && (nil == self.loginItem.mobile || nil == self.loginItem.password) ) {
        error = [NSError wsRequestParamError];
    }
    
    if (nil == error && self.loginItem.personItem == nil) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.loginItem.mobile forKey:@"mobile"];
    [self.parameters setSafeObject:self.loginItem.password forKey:@"password"];
    [self.parameters setSafeObject:self.loginItem.personItem.name forKey:@"name"];
    [self.parameters setSafeObject:self.loginItem.personItem.company forKey:@"company"];
    [self.parameters setSafeObject:self.loginItem.mobileCode forKey:@"mobileCode"];
    
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
