//
//  KKPrePayRequestModel.m
//  Magic
//
//  Created by lixiang on 15/6/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKPrePayRequestModel.h"
#import "KKWeixinPrePayItem.h"

@implementation KKPrePayRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.modelName = kLink_WS_Model_Pay_Pre;
        self.diaplayErrorInfo = NO;
        
        self.resultItemsKeyword = @"entity";
        self.resultItemsClassName = [[KKWeixinPrePayItem class] description];
        
        self.count = kWS_Default_Count;
        self.shouldLoadResultSaveLocal = NO;
        self.resultItemSingle = YES;
        
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    if (nil == error && self.caseId <= 0) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.caseId) forKey:@"caseId"];
    [self.parameters setSafeObject:@(self.type) forKey:@"type"];
    
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    
    return error;
}

@end
