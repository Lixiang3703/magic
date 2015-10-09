//
//  KKBaseLoginRequestModel.h
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"
#import "KKLoginItem.h"

#import "KKAccountItem.h"
#import "KKUserInfoItem.h"
#import "KKLoginManager.h"

@interface KKBaseLoginRequestModel : YYBaseRequestModel

@property (nonatomic, strong) KKLoginItem *loginItem;

- (NSError *)responseHanlderLoginSuccWithDataInfo:(NSDictionary *)info;

@end
