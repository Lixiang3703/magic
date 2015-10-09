//
//  YYEmptyCell.m
//  Wuya
//
//  Created by Tong on 05/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYEmptyCell.h"
#import "YYEmptyCellItem.h"

@implementation YYEmptyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.tipImageView setThemeUIType:kThemeCommonEmptyImageView];
        
        self.tipLabel.autoresizingMask = UIViewAutoresizingNone;
        self.tipLabel.backgroundColor = [UIColor clearColor];
        self.tipLabel.numberOfLines = 0;
    }
    return self;
}

- (void)firstAssignValuesSettingsWithCellItem:(YYEmptyCellItem *)cellItem {
    [super firstAssignValuesSettingsWithCellItem:cellItem];
    
}

- (void)setValuesWithCellItem:(YYEmptyCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    [self.tipLabel sizeToFit];
    self.tipLabel.middleX = [UIDevice screenWidth] / 2;
    
    self.tipImageView.top = (cellItem.cellHeight - self.tipImageView.height - kUI_Login_Common_Margin - self.tipLabel.height) / 2;
    self.tipImageView.middleX = [UIDevice screenWidth] / 2;
    
    self.tipLabel.top = self.tipImageView.bottom;
}

@end
