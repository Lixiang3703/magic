//
//  KKCaseDeleteRequestModel.m
//  Magic
//
//  Created by lixiang on 15/5/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseDeleteRequestModel.h"

@implementation KKCaseDeleteRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Case_Delete;
        
        self.agent = YES;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemSingle = YES;
    }
    return self;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.itemId) forKey:@"itemId"];
    [self.parameters setSafeObject:@(1) forKey:@"deleted"];
    
}

@end
