//
//  YYAdapterTextCell.m
//  Wuya
//
//  Created by lilingang on 14-6-27.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYAdapterTextCell.h"
#import "YYAdapterTextCellItem.h"

@implementation YYAdapterTextCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setThemeUIType:kThemeFILightGrayLabel];
    }
    return self;
}


- (void)setValuesWithCellItem:(YYAdapterTextCellItem *)cellItem{
    [super setValuesWithCellItem:cellItem];
    
    if ([cellItem.rawObject isKindOfClass:[NSString class]]) {
        self.textLabel.text = cellItem.rawObject;
        self.textLabel.height = cellItem.cellHeight;
    }
}

@end
