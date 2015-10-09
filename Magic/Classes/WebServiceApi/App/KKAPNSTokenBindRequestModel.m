//
//  YYAPNSTokenBindRequestModel.m
//  Link
//
//  Created by Lixiang on 15/1/19.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKAPNSTokenBindRequestModel.h"

@implementation KKAPNSTokenBindRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        self.modelName = kLinkWS_Model_APNSBind;
        self.agent = YES;
        self.diaplayErrorInfo = NO;
        self.shouldLoadResultSaveLocal = NO;
    }
    return self;
}


#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && nil == self.apnsToken) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.apnsToken forKey:@"token"];
}


#pragma mark -
#pragma mark Response Handler

- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}

@end
