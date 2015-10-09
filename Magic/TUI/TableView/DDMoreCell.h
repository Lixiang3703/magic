//
//  DDMoreCell.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseCell.h"

@protocol DDMoreCellActions <DDBaseCellActions>

- (void)moreCellDidAppear:(NSDictionary *)info;

@end

@interface DDMoreCell : DDBaseCell

@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@end
