//
//  KKPhotoDeleteRequestModel.m
//  Magic
//
//  Created by lixiang on 15/6/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKPhotoDeleteRequestModel.h"

@implementation KKPhotoDeleteRequestModel


#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Photo_Delete;
        
        self.agent = YES;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemSingle = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Parames

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && self.imageId <= 0 ) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.imageId) forKey:@"imageId"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    return error;
}


@end
