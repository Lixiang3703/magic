//
//  KKBroadcastListRequestModel.m
//  Magic
//
//  Created by lixiang on 15/5/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBroadcastListRequestModel.h"

@implementation KKBroadcastListRequestModel

#pragma mark -
#pragma mark Accessor

- (NSMutableArray *)imageItemArray {
    if (_imageItemArray == nil) {
        _imageItemArray = [NSMutableArray array];
    }
    return _imageItemArray;
}

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";
        self.modelName = kLink_WS_Model_Broadcast_List;
        
        self.count = kLink_WS_Default_Count;
        
        self.resultItemsKeyword = @"entities";
        self.resultItemsClassName = [[KKBroadcastItem class] description];
        
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
    
    [self.imageItemArray removeAllObjects];
    
    if (self.resultItems && self.resultItems.count > 0) {
        for (KKBroadcastItem *item in self.resultItems) {
            if ([item isKindOfClass:[KKBroadcastItem class]]) {
                [self.imageItemArray addSafeObject:item.imageItem];
            }
        }
    }
    
    return error;
}



@end
