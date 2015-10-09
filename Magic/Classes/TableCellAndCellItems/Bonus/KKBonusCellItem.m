//
//  KKBonusCellItem.m
//  Magic
//
//  Created by lixiang on 15/5/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBonusCellItem.h"

@implementation KKBonusCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.cellHeight = kBonusCell_height;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}

@end
