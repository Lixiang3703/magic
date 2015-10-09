//
//  KKChatListRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatListRequestModel.h"

@implementation KKChatListRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_Chat_List;
        self.count = 10;
        
        self.shouldLoadResultSaveLocal = YES;
        self.diaplayErrorInfo = NO;
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
