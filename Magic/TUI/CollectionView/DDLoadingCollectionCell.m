//
//  DDLoadingCollectionCell.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDLoadingCollectionCell.h"
#import "DDLoadingCollectionCellItem.h"

@implementation DDLoadingCollectionCell

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.spinner.frame = self.bounds;
    self.spinner.contentMode = UIViewContentModeCenter;
    [self.spinner fullfillPrarentView];
    
    
    [self.contentView addSubview:self.spinner];
    
}


- (void)setValuesWithCellItem:(DDLoadingCollectionCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    [self.spinner startAnimating];
}

@end
