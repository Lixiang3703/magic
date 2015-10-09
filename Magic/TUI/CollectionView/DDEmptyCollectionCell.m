//
//  DDEmptyCollectionCell.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDEmptyCollectionCell.h"
#import "DDEmptyCollectionCellItem.h"

@implementation DDEmptyCollectionCell

- (void)initSettings {
    [super initSettings];
    
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

- (void)setValuesWithCellItem:(DDEmptyCollectionCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.tipLabel.text = cellItem.tip;
    if (cellItem.tipImageViewName) {
        [self.tipImageView setImage:[UIImage imageNamed:[cellItem.tipImageViewName hasContent] ? cellItem.tipImageViewName : @"common_empty"]];
        [self.tipImageView sizeToFit];
    }
}

@end
