//
//  KKUserInfoItem.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKUserInfoItem.h"
#import "KKAppSettings.h"

@implementation KKUserInfoItem

#pragma mark -
#pragma mark Accessor

- (KKPersonItem *)personItem {
    if (_personItem == nil) {
        _personItem = [[KKPersonItem alloc] init];
    }
    return _personItem;
}

- (KKPersonItem *)servicePersonItem {
    if (_servicePersonItem == nil) {
        _servicePersonItem = [[KKPersonItem alloc] init];
        _servicePersonItem.kkId = 0;
        _servicePersonItem.name = @"客服人员";
    }
    return _servicePersonItem;
}

#pragma mark -
#pragma mark Life cycle


- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        
    }
    return self;
}

+ (KKUserInfoItem *)sharedItem {
    return [KKAppSettings getInstance].userInfoItem;
}

- (void)clearAndSave {
    [super clearAndSave];
}

@end
