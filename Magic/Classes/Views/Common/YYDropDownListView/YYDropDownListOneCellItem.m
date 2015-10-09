//
//  YYDropDownListOneCellItem.m
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYDropDownListOneCellItem.h"

@implementation YYDropDownListOneCellItem

- (void)initSettings{
    [super initSettings];
    self.cellHeight = kDropDownListOneCellItem_height;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    self.selectable = YES;
    self.seperatorLineHidden = NO;
}

@end
