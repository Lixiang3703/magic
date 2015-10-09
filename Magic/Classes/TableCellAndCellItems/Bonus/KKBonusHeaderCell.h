//
//  KKBonusHeaderCell.h
//  Magic
//
//  Created by lixiang on 15/5/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKBonusHeaderCellActions <DDBaseCellActions>

@required
- (void)kkBonusHeaderButtonPressed:(NSDictionary *)info;

@end

@interface KKBonusHeaderCell : YYBaseCell

@end
