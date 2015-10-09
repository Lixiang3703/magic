//
//  KKSingleButtonCellItem.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCellItem.h"

#define kSingleButtonCell_button_height         (50)
#define kSingleButtonCell_button_marginTop      (10)


@interface KKSingleButtonCellItem : YYBaseCellItem

@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, copy) UIColor *buttonColor;

@end
