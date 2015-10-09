//
//  KKAPNSTokenUnBindRequestModel.h
//  Link
//
//  Created by Lixiang on 15/1/19.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"

@interface KKAPNSTokenUnBindRequestModel : YYBaseRequestModel

/** Params */
@property (atomic, copy) NSString *apnsToken;

@end
