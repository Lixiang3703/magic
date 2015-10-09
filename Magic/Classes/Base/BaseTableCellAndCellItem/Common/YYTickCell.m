//
//  YYTickCell.m
//  Wuya
//
//  Created by Lixiang on 14-6-26.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYTickCell.h"

#import "YYTickCellItem.h"

#define kTickImageHeight   22
#define kTickSeperatorLineLeftMargin  60

@implementation YYTickCell

- (UIImageView *)checkboxImageView{
    if (nil == _checkboxImageView) {
        _checkboxImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_checkboxImageView setThemeUIType:kThemeTableCheckBoxAccessoryImageView];
        [_checkboxImageView sizeToFit];
    }
    return _checkboxImageView;
}

- (UIImageView *)tickImageView {
    if (nil == _tickImageView) {
        _tickImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [_tickImageView setThemeUIType:kThemeTableTickAccessoryImageView];
        [_tickImageView sizeToFit];
    }
    return _tickImageView;
}

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = kTickSeperatorLineLeftMargin;
		[self addSubview:self.checkboxImageView];
        [self addSubview:self.tickImageView];
    }
    return self;
}

- (void)firstAssignValuesSettingsWithCellItem:(YYTickCellItem *)cellItem {
    [super firstAssignValuesSettingsWithCellItem:cellItem];
    
    self.checkboxImageView.top = (cellItem.cellHeight - kTickImageHeight) / 2;
    self.checkboxImageView.left = self.left + 14;
    
    self.tickImageView.left = self.checkboxImageView.left;
    self.tickImageView.center = self.checkboxImageView.center;}

- (void)setValuesWithCellItem:(YYTickCellItem *)cellItem
{
    [super setValuesWithCellItem:cellItem];
    
    self.tickImageView.hidden = !cellItem.ticked;
    self.checkboxImageView.hidden = cellItem.ticked;
}

@end
