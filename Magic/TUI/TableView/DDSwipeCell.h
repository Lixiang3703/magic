//
//  DDSwipeCell.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseCell.h"

@protocol DDSwipeCellActions <DDBaseCellActions>

@end

@interface DDSwipeCell : DDBaseCell

@property (nonatomic, readonly) BOOL isCurrentOperationOpen;
@property (nonatomic, strong) UIView *operationContainerView;

- (void)closeAnimated:(BOOL)animated completion:(void (^)())completion;

@end
