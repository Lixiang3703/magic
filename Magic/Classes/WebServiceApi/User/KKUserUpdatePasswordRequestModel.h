//
//  KKUserUpdatePasswordRequestModel.h
//  Link
//
//  Created by Lixiang on 14/11/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKBaseUserUpdateRequestModel.h"

@interface KKUserUpdatePasswordRequestModel : KKBaseUserUpdateRequestModel

@property (nonatomic, copy) NSString *currentPassword;
@property (nonatomic, copy) NSString *password;

@end
