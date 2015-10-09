//
//  KKUserOneCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKUserOneCellItem.h"

@implementation KKUserOneCellItem

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.swipable = NO;
    self.seperatorLineHidden = YES;
    
    self.cellHeight = kUserOneCellItem_height + kUserOneCellItem_Button_height + kUserOneCellItem_SeparateLine_height;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}

@end
