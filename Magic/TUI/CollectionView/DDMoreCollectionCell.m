//
//  DDMoreCollectionCell.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDMoreCollectionCell.h"
#import "DDMoreCollectionCellItem.h"

@implementation DDMoreCollectionCell

- (void)initSettings {
    [super initSettings];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.frame = self.bounds;
    self.spinner.contentMode = UIViewContentModeCenter;
    [self.spinner fullfillPrarentView];
    
    [self.contentView addSubview:self.spinner];
}


- (void)setValuesWithCellItem:(DDMoreCollectionCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    if (cellItem.showSpinner) {
        [self.spinner startAnimating];
    } else {
        [self.spinner stopAnimating];
    }
}


@end
