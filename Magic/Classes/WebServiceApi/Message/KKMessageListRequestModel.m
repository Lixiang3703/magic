//
//  KKMessageListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMessageListRequestModel.h"
#import "KKMessageItem.h"

@implementation KKMessageListRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Message_List;
        
        self.count = kLink_WS_Default_Count;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKMessageItem class] description];
        
        self.shouldLoadResultSaveLocal = YES;
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
