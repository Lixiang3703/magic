//
//  KKProfileMenuCell.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKProfileMenuCellActions <DDBaseCellActions>

@required
- (void)kkProfileMenuButtonPressed:(NSDictionary *)info;

@end

@interface KKProfileMenuCell : YYBaseCell

@end
