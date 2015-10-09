//
//  KKLawListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKLawListRequestModel.h"
#import "KKLawItem.h"

@implementation KKLawListRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Law_List;
        
        self.count = kLink_WS_Default_Count;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKLawItem class] description];
        
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
