//
//  KKCaseOneRequestModel.m
//  Magic
//
//  Created by lixiang on 15/5/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseOneRequestModel.h"
#import "KKCaseItem.h"

@implementation KKCaseOneRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.count = kLink_WS_Default_Count;
        
        self.resultItemsKeyword = @"entity";
        self.resultItemsClassName = [[KKCaseItem class] description];
        self.resultItemSingle = YES;
        
        self.shouldLoadResultSaveLocal = YES;
        
        self.modelName = kLink_WS_Model_Case_One;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && self.itemId <= 0) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.itemId) forKey:@"itemId"];
    [self.parameters setSafeObject:@(self.messageId) forKey:@"messageId"];
}

#pragma mark -
#pragma mark Response Hanlder
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}


@end
