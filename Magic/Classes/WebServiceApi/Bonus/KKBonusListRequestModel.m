//
//  KKBonusListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/5/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBonusListRequestModel.h"
#import "KKBonusRecordItem.h"

@implementation KKBonusListRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        
        self.modelName = kLink_WS_Model_Bonus_List;
        self.diaplayErrorInfo = NO;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKBonusRecordItem class] description];
        
        self.count = kWS_Default_Count;
        
        self.shouldLoadResultSaveLocal = NO;
        
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    if (nil == error && self.userId < 0) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.userId) forKey:@"userId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    if ([info objectForSafeKey:@"bonus"]) {
        self.bonus = [[info objectForSafeKey:@"bonus"] integerValue];
    }
    else {
        self.bonus = 0;
    }
    
    return error;
}



@end
