//
//  YYCaseBasePostRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseBasePostRequestModel.h"

@implementation KKCaseBasePostRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        self.modelName = kLink_WS_Model_Message_Clear;
        
        self.agent = YES;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemSingle = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && self.itemId <= 0 ) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.itemId) forKey:@"itemId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    return error;
}

@end
