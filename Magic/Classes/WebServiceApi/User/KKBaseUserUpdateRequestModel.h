//
//  KKBaseUserUpdateRequestModel.h
//  Link
//
//  Created by Lixiang on 14/11/18.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"
#import "KKPersonItem.h"

@interface KKBaseUserUpdateRequestModel : YYBaseRequestModel

@property (nonatomic, strong) KKPersonItem *personItem;

@end
