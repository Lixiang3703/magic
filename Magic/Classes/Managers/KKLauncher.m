//
//  KKLauncher.m
//  Link
//
//  Created by Lixiang on 14/10/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKLauncher.h"

#import "KKUserInfoRequestModel.h"
#import "KKUnreadInfoRequestModel.h"

#import "KKLoginManager.h"
#import "KKPersonItem.h"
#import "KKUserInfoItem.h"
#import "KKUnreadInfoItem.h"
#import "KKAppSettings.h"

#import "KKIndustryManager.h"

@interface KKLauncher()

@property (nonatomic, strong) KKUserInfoRequestModel *userInfoRequestModel;

@end

@implementation KKLauncher
SYNTHESIZE_SINGLETON_FOR_CLASS(KKLauncher);


- (KKUserInfoRequestModel *)userInfoRequestModel {
    if (_userInfoRequestModel == nil) {
        _userInfoRequestModel = [[KKUserInfoRequestModel alloc] init];
    }
    return _userInfoRequestModel;
}

- (void)appDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super appDidFinishLaunchingWithOptions:launchOptions];

    [[KKIndustryManager getInstance] loadIndustryList:^(KKIndustryItem *industryItem) {
        
    }];
    
    [self checkUserInfoWithSuccessBlock:nil failBlock:nil];
    
    [self checkUnreadInfo];
}

- (void)checkUserInfoWithSuccessBlock:(WSSuccessBlock)successBlock failBlock:(WSFailBlock)failBlock {
    
    __weak __typeof(self) weakSelf = self;
    self.userInfoRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKUserInfoRequestModel *requestModel) {
        KKPersonItem *personItem = requestModel.resultItem;
        if ([personItem isKindOfClass:[KKPersonItem class]]) {
            [KKUserInfoItem sharedItem].personItem = personItem;
        }
        if (successBlock) {
            successBlock(nil, nil, weakSelf.userInfoRequestModel);
        }
    };
    [self.userInfoRequestModel load];
}

- (void)checkUnreadInfo {
    
    if (![KKLoginManager getInstance].isLoggedIn) {
        return;
    }
    
    KKUnreadInfoRequestModel *requestModel = [[KKUnreadInfoRequestModel alloc] init];
    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKUnreadInfoRequestModel *requestModel) {
        
        [KKAppSettings getInstance].unreadInfoItem = requestModel.resultItem;
        
        [[KKAppSettings getInstance].unreadInfoItem save];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kLinkNotification_Unread_Update object:nil userInfo:nil];
    };
    
    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKUnreadInfoRequestModel *requestModel) {
        // pass
    };
    
    [requestModel load];
    
//    [KKUnreadInfoItem sharedItem].newMsg = 12;
//    [[KKAppSettings getInstance].unreadInfoItem save];
}

@end
