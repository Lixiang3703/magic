//
//  KKChatBaseSessionDetailsRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/12.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatBaseSessionDetailsRequestModel.h"
#import "KKChatItem.h"

@implementation KKChatBaseSessionDetailsRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemsKeyword = @"chatMsgs";
        self.resultItemsClassName = [[KKChatItem class] description];
        
        self.count = kWS_Default_Count;
        
        self.shouldLoadResultSaveLocal = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && nil == self.sessionId) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.sessionId forKey:@"sessionId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}


@end
