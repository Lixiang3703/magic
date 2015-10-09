//
//  KKIndustryManager.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKIndustryManager.h"
#import "KKIndustryListRequestModel.h"


@interface KKIndustryManager()

@property (nonatomic, strong) KKIndustryListRequestModel *listRequestModel;

@end

@implementation KKIndustryManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKIndustryManager);

#pragma mark -
#pragma mark Accessor 

- (KKIndustryListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKIndustryListRequestModel alloc] init];
    }
    return _listRequestModel;
}

#pragma mark -
#pragma mark Initialzation

- (instancetype)init {
    self = [super init];
    if (self) {
        self.type = 0;
    }
    return self;
}

- (void)loadIndustryList:(KKIndustryManagerBlock)prepareBlock {
    __weak __typeof(self)weakSelf = self;
    self.listRequestModel.type = self.type;
    self.listRequestModel.successBlock = ^(id responseObject, NSDictionary *headers,  YYBaseRequestModel *requestModel) {
        weakSelf.industryItemList = [requestModel.resultItems copy];
        [weakSelf buildList];
        
    };
    
    self.listRequestModel.failBlock = ^(id responseObject, NSDictionary *headers,  WSBaseRequestModel *requestModel) {
        
    };
    
    [self.listRequestModel load];
}

- (void)buildList {
    
}

@end
