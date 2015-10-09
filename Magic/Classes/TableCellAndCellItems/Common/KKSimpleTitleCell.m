//
//  KKSimpleTitleCell.m
//  Link
//
//  Created by Lixiang on 14/11/23.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKSimpleTitleCell.h"
#import "KKSimpleTitleCellItem.h"

@implementation KKSimpleTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        CGFloat contentWidth = self.width - 2*kUI_TableView_Common_Margin;
        
        CGFloat titleViewHeight = 2 * kUI_TableView_TitleLabel_Height + kUI_TableView_Common_Margin;
        
        // titleView with name & subName
        self.titleView = [[UIView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_MarginLevel0, contentWidth, titleViewHeight)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentWidth, kUI_TableView_BigLabel_Size +3)];
        [self.nameLabel setThemeUIType:kLinkThemeTableBigLabel];
        
        self.subNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentWidth, kUI_TableView_TitleLabel_Height)];
        self.subNameLabel.top = self.nameLabel.bottom + kUI_TableView_Common_Margin;
        [self.subNameLabel setThemeUIType:kLinkThemeTableDefaultTitleLabel];
        
        [self.titleView addSubview:self.nameLabel];
        [self.titleView addSubview:self.subNameLabel];
        
        [self.contentView addSubview:self.titleView];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKSimpleTitleCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];

    self.nameLabel.text = @"高级英语培训";
    self.subNameLabel.text = @"高盛(北京)国际培训集团";
    
    if (cellItem.name) {
        self.nameLabel.text = cellItem.name;
    }
    if (cellItem.subName) {
        self.subNameLabel.text = cellItem.subName;
    }
}


@end
