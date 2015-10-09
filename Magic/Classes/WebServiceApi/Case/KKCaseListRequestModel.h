//
//  YYCaseListRequestModel.h
//  Magic
//
//  Created by lixiang on 15/4/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"

@interface KKCaseListRequestModel : YYBaseRequestModel

@property (nonatomic, assign) NSInteger authorId;
@property (nonatomic, assign) KKCaseStatusType status;

@end
