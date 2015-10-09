//
//  YYDropDownListOneCellItem.h
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYBaseCellItem.h"

#define kDropDownListOneCellItem_height     (50)

@interface YYDropDownListOneCellItem : YYBaseCellItem

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) NSString *titleStr;

@end
