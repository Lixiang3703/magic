//
//  KKLoginItem.h
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKPersonItem.h"

@interface KKLoginItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *mobileCode;

@property (nonatomic, strong) KKPersonItem *personItem;

//  Forget & change psd
@property (nonatomic, copy) NSString *forgetCode;
@property (nonatomic, copy) NSString *myOldPassword;
@property (nonatomic, copy) NSString *myNewPassword;

@end
