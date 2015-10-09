//
//  DDEmptyCell.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDEmptyCell.h"
#import "DDEmptyCellItem.h"

@implementation DDEmptyCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  UI
        
        //  TipImageView
        self.tipImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        //  TipLabel
        self.tipLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.tipLabel.textAlignment = NSTextAlignmentCenter;
        self.tipLabel.textColor = [UIColor lightGrayColor];

        [self.tipLabel fullfillPrarentView];
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.tipImageView];
        [self.contentView addSubview:self.tipLabel];
        
    }
    return self;
}

- (void)firstAssignValuesSettingsWithCellItem:(DDEmptyCellItem *)cellItem {
    [super firstAssignValuesSettingsWithCellItem:cellItem];

}

- (void)setValuesWithCellItem:(DDEmptyCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.tipLabel.text = cellItem.tip;
    if (cellItem.tipImageViewName)
    {
        if (cellItem.tipImageViewName.length > 0) {
            [self.tipImageView setImage:[UIImage imageNamed:cellItem.tipImageViewName]];
        }
        else
        {
            [self.tipImageView setImage:[UIImage imageNamed:@"common_empty"]];
        }
        [self.tipImageView sizeToFit];
    }
}

@end
