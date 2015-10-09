//
//  KKChangePasswordRequestModel.m
//  Link
//
//  Created by lixiang on 15/1/21.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKChangePasswordRequestModel.h"

@implementation KKChangePasswordRequestModel

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_changePsd;
    }
    return self;
}


#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && (nil == self.loginItem.myOldPassword || nil == self.loginItem.myNewPassword)) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}
- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.loginItem.myOldPassword forKey:@"oldpassword"];
    [self.parameters setSafeObject:self.loginItem.myNewPassword forKey:@"newpassword"];
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
