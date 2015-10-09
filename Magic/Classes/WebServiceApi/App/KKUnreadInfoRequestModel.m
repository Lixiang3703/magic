//
//  KKUnreadInfoRequestModel.m
//  Link
//
//  Created by lixiang on 15/1/22.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKUnreadInfoRequestModel.h"
#import "KKUnreadInfoItem.h"

@implementation KKUnreadInfoRequestModel

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLinkWS_Model_Unread;
        self.agent = YES;
        self.diaplayErrorInfo = NO;
        self.shouldLoadResultSaveLocal = NO;
        
        self.resultItemsClassName = [[KKUnreadInfoItem class] description];
        self.resultItemsKeyword = @"entity";
        self.resultItemSingle = YES;
        
    }
    return self;
}


#pragma mark -
#pragma mark Response Handler
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
//    self.resultItem = [KKUnreadInfoItem itemWithDict:info];
    
    return error;
}

@end
