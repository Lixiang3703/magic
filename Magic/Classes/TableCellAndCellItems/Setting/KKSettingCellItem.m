//
//  KKSettingCellItem.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKSettingCellItem.h"

@implementation KKSettingCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.cellStyle = UITableViewCellStyleValue1;
    
    self.groupBottomSeperatorLineHidden = YES;
    self.groupTopSeperatorLineHidden = YES;
    
    self.cellHeight = 50;
}

@end
