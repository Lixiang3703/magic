//
//  KKUserChildrenListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKUserChildrenListRequestModel.h"
#import "KKPersonItem.h"

@implementation KKUserChildrenListRequestModel



#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.modelName = kLink_WS_Model_User_childrenList;
        self.diaplayErrorInfo = NO;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKPersonItem class] description];
        
        self.count = 5;  // 因为这个要有积分数，业务数，所以慢，就少请求一些
        
        self.shouldLoadResultSaveLocal = NO;
        
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    if (nil == error && self.parentId < 0) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.parentId) forKey:@"parentId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}



@end
