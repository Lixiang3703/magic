//
//  YYDropDownListOneCell.m
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYDropDownListOneCell.h"
#import "YYDropDownListOneCellItem.h"

@implementation YYDropDownListOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], kDropDownListOneCellItem_height)];
        [self.titleLabel setThemeUIType:kThemeCommonLightLabel];
        [self.titleLabel setTextColor:[UIColor grayColor]];
        [self.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
        [self.titleLabel setTextAlignment:NSTextAlignmentCenter];
        
        self.titleLabel.text = @"cc";
        
        CGFloat iconImageViewWidth = 20;
        CGFloat iconImageViewMarginRight = 20;
        
        self.rightIconView = [[UIImageView alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - iconImageViewWidth -iconImageViewMarginRight, (kDropDownListOneCellItem_height - iconImageViewWidth)/2, iconImageViewWidth, iconImageViewWidth)];
        
        self.rightIconView.image = [UIImage imageNamed:@"choose_yellow_normal"];
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightIconView];
    }
    return self;
}

- (void)setValuesWithCellItem:(YYDropDownListOneCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    if (cellItem.titleStr && cellItem.titleStr.length > 0) {
        self.titleLabel.text = cellItem.titleStr;
    }
    else {
        self.titleLabel.text = @"";
    }
    
    if (cellItem.isSelected) {
        self.rightIconView.image = [UIImage imageNamed:@"choose_yellow_selected"];
    }
    else {
        self.rightIconView.image = [UIImage imageNamed:@"choose_yellow_normal"];
    }
    
}

@end





