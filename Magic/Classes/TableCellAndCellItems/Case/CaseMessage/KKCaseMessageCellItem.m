//
//  KKCaseMessageCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseMessageCellItem.h"

@implementation KKCaseMessageCellItem

- (void)initSettings {
    [super initSettings];
    self.cellHeight = kCaseMessageCell_ImageView_height + 2*kCaseMessageCell_ImageView_marginTop;
    
    self.cellAccessoryType = UITableViewCellAccessoryNone;
}

@end
