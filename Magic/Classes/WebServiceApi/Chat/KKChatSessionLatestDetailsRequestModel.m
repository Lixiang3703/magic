//
//  KKChatSessionLatestDetailsRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/12.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatSessionLatestDetailsRequestModel.h"

@implementation KKChatSessionLatestDetailsRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_Chat_List_Latest;
        
        self.shouldLoadResultSaveLocal = NO;
        self.diaplayErrorInfo = NO;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && (nil == self.sessionId || self.sessionId.length <= 0 )) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    if (self.latestMsgId > 0) {
        [self.parameters setSafeObject:@(self.latestMsgId) forKey:@"latestMsgId"];
    }
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}

@end
