//
//  KKChatSessionListRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatSessionListRequestModel.h"
#import "KKChatSessionItem.h"


@implementation KKChatSessionListRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.modelName = kLink_WS_Model_Chat_Session_List;
        self.diaplayErrorInfo = NO;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKChatSessionItem class] description];
        
        self.count = kWS_Default_Count;
        
        self.shouldLoadResultSaveLocal = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    
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
