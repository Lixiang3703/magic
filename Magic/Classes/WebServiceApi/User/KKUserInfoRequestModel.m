//
//  KKUserInfoRequestModel.m
//  Link
//
//  Created by Lixiang on 14/11/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKUserInfoRequestModel.h"
#import "KKPersonItem.h"

@implementation KKUserInfoRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.count = kLink_WS_Default_Count;
        
        self.resultItemsKeyword = @"entity";
        self.resultItemsClassName = [[KKPersonItem class] description];
        self.resultItemSingle = YES;
        
        self.shouldLoadResultSaveLocal = YES;
        
        self.modelName = kLink_WS_Model_User_mineBasicInfo;
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
#pragma mark Response Hanlder
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}

@end
