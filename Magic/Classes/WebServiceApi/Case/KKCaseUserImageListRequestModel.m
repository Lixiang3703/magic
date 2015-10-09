//
//  KKCaseUserImageListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/6/3.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseUserImageListRequestModel.h"
#import "KKImageItem.h"

@implementation KKCaseUserImageListRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.count = kLink_WS_Default_Count;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKImageItem class] description];
        self.resultItemSingle = NO;
        
        self.shouldLoadResultSaveLocal = YES;
        
        self.modelName = kLink_WS_Model_Case_UserImageList;
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
}

#pragma mark -
#pragma mark Response Hanlder
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    
    return error;
}


@end
