//
//  KKCaseTypeCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseTypeCellItem.h"

@implementation KKCaseTypeCellItem

- (void)initSettings {
    [super initSettings];
    self.cellHeight = KCaseTypeCellItem_height;
    self.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end
