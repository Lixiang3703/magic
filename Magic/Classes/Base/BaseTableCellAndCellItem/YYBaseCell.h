//
//  YYBaseCell.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSwipeCell.h"

@protocol YYBaseCellActions <DDSwipeCellActions>

- (void)yycellBaseDefaultOperationButtonPressedWithInfo:(NSDictionary *)info;

@end

@interface YYBaseCell : DDSwipeCell

@property (nonatomic, strong) UIImageView *seperatorLine;
@property (nonatomic, strong) UIButton *defaultOperationButton;

@end
