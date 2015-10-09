//
//  KKCaseCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseCellItem.h"

@implementation KKCaseCellItem

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.swipable = YES;
    self.cellHeight = kCaseCellItem_height;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}


@end
