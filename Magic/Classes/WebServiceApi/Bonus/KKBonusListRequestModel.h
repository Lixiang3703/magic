//
//  KKBonusListRequestModel.h
//  Magic
//
//  Created by lixiang on 15/5/16.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"

@interface KKBonusListRequestModel : YYBaseRequestModel

@property (nonatomic, assign) NSInteger userId;

// response

@property (nonatomic, assign) NSInteger bonus;

@end
