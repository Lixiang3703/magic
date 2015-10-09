//
//  KKBaseUserUpdateRequestModel.m
//  Link
//
//  Created by Lixiang on 14/11/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKBaseUserUpdateRequestModel.h"

@implementation KKBaseUserUpdateRequestModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        
        self.agent = YES;
        self.shouldLoadResultSaveLocal = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && nil == self.personItem) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

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
