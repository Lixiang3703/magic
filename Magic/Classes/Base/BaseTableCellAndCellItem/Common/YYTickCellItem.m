//
//  YYTickCellItem.m
//  Wuya
//
//  Created by Lixiang on 14-6-26.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYTickCellItem.h"

@implementation YYTickCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    self.cellHeight = 80;
    
    self.defaultWhiteBgColor = NO;
//    self.seperatorLineHidden = YES;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}

@end
