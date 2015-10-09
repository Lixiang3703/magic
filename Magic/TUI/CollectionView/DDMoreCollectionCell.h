//
//  DDMoreCollectionCell.h
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseCollectionCell.h"

@protocol DDMoreCollectionCellActions <DDBaseCollectionCellActions>

- (void)moreCollectionCellDidAppear:(NSDictionary *)info;

@end


@interface DDMoreCollectionCell : DDBaseCollectionCell

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end
