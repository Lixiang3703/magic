//
//  YYClassicsListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKClassicsListRequestModel.h"
#import "KKClassicsItem.h"

@implementation KKClassicsListRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.modelName = kLink_WS_Model_Classics_List;
        self.diaplayErrorInfo = NO;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKClassicsItem class] description];
        
        self.count = kWS_Default_Count;
        
        self.shouldLoadResultSaveLocal = NO;
        
        self.industryId = 0;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    if (nil == error && self.industryId < 0) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.industryId) forKey:@"industryId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}


@end
