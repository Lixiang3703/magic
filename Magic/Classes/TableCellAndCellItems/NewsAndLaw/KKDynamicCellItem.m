//
//  KKNewsCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKDynamicCellItem.h"

@implementation KKDynamicCellItem

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.swipable = NO;
    self.cellHeight = kNewsCellItem_height;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
}

@end
