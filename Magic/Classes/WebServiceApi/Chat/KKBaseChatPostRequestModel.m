//
//  KKBaseChatPostRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKBaseChatPostRequestModel.h"
#import "KKChatItem.h"

@implementation KKBaseChatPostRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        
        self.agent = YES;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemsKeyword = @"chatMsg";
        self.resultItemsClassName = [[KKChatItem class] description];
        self.resultItemSingle = YES;
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
    
    //    NSDictionary *chatMsg = [info objectForSafeKey:@"commentCount"];
    //    NSString *msgId = [chatMsg objectForKey:@"id"];
    //    if ([msgId isEqualToString:@"-1"]) {
    //
    //    }
    
    return error;
}



@end
