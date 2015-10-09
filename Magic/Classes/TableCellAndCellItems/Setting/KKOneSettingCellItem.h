//
//  KKOneSettingCellItem.h
//  Magic
//
//  Created by lixiang on 15/6/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCellItem.h"

@interface KKOneSettingCellItem : YYBaseCellItem

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *iconImageName;

+ (instancetype)cellItemWithTitle:(NSString *)title iconImageName:(NSString *)iconImageName;
    
@end
