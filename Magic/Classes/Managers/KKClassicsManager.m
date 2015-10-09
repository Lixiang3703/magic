//
//  KKClassicsManager.m
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKClassicsManager.h"
#import "KKClassicsListRequestModel.h"

@interface KKClassicsManager()

@property (nonatomic, strong) KKClassicsListRequestModel *listRequestModel;

@end

@implementation KKClassicsManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKClassicsManager);

#pragma mark -
#pragma mark Accessor

- (NSMutableDictionary *)itemDict {
    if (_itemDict == nil) {
        _itemDict = [NSMutableDictionary dictionary];
    }
    return _itemDict;
}

- (KKClassicsListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKClassicsListRequestModel alloc] init];
    }
    return _listRequestModel;
}

#pragma mark -
#pragma mark Initialzation

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadIndustryList:(KKClassicsManagerBlock)prepareBlock {
    self.prepareBlock = prepareBlock;
    __weak __typeof(self)weakSelf = self;
    self.listRequestModel.successBlock = ^(id responseObject, NSDictionary *headers,  YYBaseRequestModel *requestModel) {
        weakSelf.itemList = [requestModel.resultItems copy];
        [weakSelf setupDict];
    };
    
    self.listRequestModel.failBlock = ^(id responseObject, NSDictionary *headers,  WSBaseRequestModel *requestModel) {
        
    };
    
    [self.listRequestModel load];
}

- (void)setupDict {
    for (KKClassicsItem * item in self.itemList) {
        if (![self.itemDict objectForSafeKey:@(item.industryId)]) {
            [self.itemDict setSafeObject:[NSMutableArray array] forKey:@(item.industryId)];
        }
        NSMutableArray *array = [self.itemDict objectForSafeKey:@(item.industryId)];
        [array addSafeObject:item];
    }
}

@end
