//
//  KKUserUpdateBasicInfoRequestModel.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKUserUpdateBasicInfoRequestModel.h"

@implementation KKUserUpdateBasicInfoRequestModel


- (instancetype)init {
    self = [super init];
    if (self) {
        self.modelName = kLink_WS_Model_User_Update_basicInfo;
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
    
    [self.parameters setSafeObject:self.personItem.name forKey:@"name"];
    [self.parameters setSafeObject:self.personItem.company forKey:@"company"];
    [self.parameters setSafeObject:@"" forKey:@"custom"];
}

#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    return error;
}


@end
