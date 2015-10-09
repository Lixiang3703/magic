//
//  KKChatSessionCheckRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatSessionCheckRequestModel.h"
#import "KKChatSessionItem.h"

@implementation KKChatSessionCheckRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Chat_Session_Check;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemsKeyword = @"statusItem";
        self.resultItemsClassName = [[KKChatSessionItem class] description];
        self.resultItemSingle = YES;
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
    
    [self.parameters setSafeObject:@(self.toUserId) forKey:@"toUserId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}

@end
