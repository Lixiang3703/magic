//
//  KKPasswordMobileCodeRequestModel.m
//  Link
//
//  Created by lixiang on 15/2/9.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKPasswordMobileCodeRequestModel.h"

@implementation KKPasswordMobileCodeRequestModel


#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Password_Mobile_Code;
    }
    return self;
}


#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && nil == self.loginItem.mobile) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}
- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.loginItem.mobile forKey:@"mobile"];
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
