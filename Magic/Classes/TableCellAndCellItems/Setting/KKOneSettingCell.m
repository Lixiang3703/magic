//
//  KKOneSettingCell.m
//  Magic
//
//  Created by lixiang on 15/6/15.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKOneSettingCell.h"
#import "KKOneSettingCellItem.h"

@implementation KKOneSettingCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat iconImage_width = 30;
        CGFloat iconImage_totalWidth = 80;
        CGFloat iconImage_paddingLeft = 25;
        
        //  UI
        self.seperatorLine.left = iconImage_totalWidth;
        self.seperatorLine.width = [UIDevice screenWidth] - kUI_TableView_Common_MarginW;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(iconImage_paddingLeft, 10, iconImage_width, iconImage_width)];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(iconImage_totalWidth, 0, 260, 50)];
        
        [self.nameLabel setThemeUIType:kThemeBasicLabel_Black16];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKOneSettingCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.nameLabel.text = cellItem.title;
    self.iconImageView.image = [UIImage imageNamed:cellItem.imageName];
    
    self.imageView.hidden = YES;
}

@end
