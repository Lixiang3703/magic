//
//  YYCaseInsertRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseInsertRequestModel.h"

@implementation KKCaseInsertRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        self.modelName = kLink_WS_Model_Case_Insert;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemsKeyword = @"entity";
        self.resultItemsClassName = [[KKCaseItem class] description];
        self.resultItemSingle = YES;
        
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && ( self.caseItem == nil ) ) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:self.caseItem.title forKey:@"title"];
    [self.parameters setSafeObject:self.caseItem.content forKey:@"content"];
    
    [self.parameters setSafeObject:@(self.caseItem.type) forKey:@"type"];
    [self.parameters setSafeObject:@(self.caseItem.subType) forKey:@"subType"];
    
    [self.parameters setSafeObject:@(self.caseItem.industryId) forKey:@"industryId"];
    [self.parameters setSafeObject:self.caseItem.custom forKey:@"custom"];
    
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    return error;
}

@end
