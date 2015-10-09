//
//  KKCaseDetailMenuCell.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKCaseDetailMenuCellActions <DDBaseCellActions>

@required
- (void)kkCaseDetailMenuButtonPressed:(NSDictionary *)info;

@end

@interface KKCaseDetailMenuCell : YYBaseCell

@end
