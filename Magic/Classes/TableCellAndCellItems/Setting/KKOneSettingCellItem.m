//
//  KKOneSettingCellItem.m
//  Magic
//
//  Created by lixiang on 15/6/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKOneSettingCellItem.h"

@implementation KKOneSettingCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.cellHeight = 50;
}

+ (instancetype)cellItemWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName{

    KKOneSettingCellItem *cellItem = [[KKOneSettingCellItem alloc] init];
    cellItem.title = title;
    cellItem.imageName = iconImageName;
    
    return cellItem;
}

@end
