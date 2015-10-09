//
//  YYButtonCellItem.h
//  Wuya
//
//  Created by lilingang on 14-6-27.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYBaseCellItem.h"

@interface YYButtonCellItem : YYBaseCellItem

@property (nonatomic, assign) UIButtonImageEdgeInsetType buttonType;
@property (nonatomic, copy) NSString *buttonTheme;
@property (nonatomic, copy) NSString *tipTitle;

@end
