//
//  YYIndustryListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKIndustryListRequestModel.h"
#import "KKIndustryItem.h"

@implementation KKIndustryListRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.modelName = kLink_WS_Model_Industry_List;
        self.diaplayErrorInfo = NO;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKIndustryItem class] description];
        
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
