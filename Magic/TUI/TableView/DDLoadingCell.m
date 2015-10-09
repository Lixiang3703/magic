//
//  DDLoadingCell.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDLoadingCell.h"

@implementation DDLoadingCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.frame = self.bounds;
        self.spinner.contentMode = UIViewContentModeCenter;
        [self.spinner fullfillPrarentView];
        
        
        [self.contentView addSubview:self.spinner];
        
    }
    return self;
}


- (void)setValuesWithCellItem:(DDBaseCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    [self.spinner startAnimating];
}

@end
