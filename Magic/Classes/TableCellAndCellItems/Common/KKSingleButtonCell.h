//
//  KKSingleButtonCell.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKSingleButtonCellActions <DDBaseCellActions>

@required
- (void)kkSingleButtonPressed:(NSDictionary *)info;

@end

@interface KKSingleButtonCell : YYBaseCell

@end
