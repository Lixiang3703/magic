//
//  KKCaseTypeItem.h
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKCaseTypeItem : YYBaseAPIItem

@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, assign) KKCaseType type;
@property (nonatomic, assign) KKCaseSubType subType;

@end
