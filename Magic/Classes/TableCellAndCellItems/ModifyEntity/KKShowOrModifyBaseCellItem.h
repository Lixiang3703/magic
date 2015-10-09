//
//  KKModifyBaseCellItem.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCellItem.h"

@interface KKShowOrModifyBaseCellItem : YYBaseCellItem

@property (nonatomic, assign) BOOL canNotEdit;

@property (nonatomic, copy) NSString *placeHolderString;
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *titleName;

@end
