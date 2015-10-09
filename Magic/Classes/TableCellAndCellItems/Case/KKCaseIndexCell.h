//
//  KKCaseIndexCell.h
//  Magic
//
//  Created by lixiang on 15/5/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKCaseIndexCellActions <DDBaseCellActions>

@required
- (void)kkCaseIndexButtonPressed:(NSDictionary *)info;

@end

@interface KKCaseIndexCell : YYBaseCell

@end
