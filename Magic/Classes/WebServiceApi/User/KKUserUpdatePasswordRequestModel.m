//
//  KKUserUpdatePasswordRequestModel.m
//  Link
//
//  Created by Lixiang on 14/11/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKUserUpdatePasswordRequestModel.h"

@implementation KKUserUpdatePasswordRequestModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_User_Update_passoword;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && nil == self.currentPassword) {
        error = [NSError wsRequestParamError];
    }
    
    if (nil == error && nil == self.password) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.currentPassword forKey:@"currentPassword"];
    [self.parameters setSafeObject:self.password forKey:@"password"];
    
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    return error;
}

@end
