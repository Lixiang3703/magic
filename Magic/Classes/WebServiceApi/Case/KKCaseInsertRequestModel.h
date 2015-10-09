//
//  YYCaseInsertRequestModel.h
//  Magic
//
//  Created by lixiang on 15/4/21.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"
#import "KKCaseItem.h"

@interface KKCaseInsertRequestModel : YYBaseRequestModel

@property (nonatomic, strong) KKCaseItem *caseItem;

@end
