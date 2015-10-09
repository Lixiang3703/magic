//
//  KKMessageCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMessageCellItem.h"

@implementation KKMessageCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.swipable = NO;
    self.cellHeight = kMessageCellItem_height;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}

@end
