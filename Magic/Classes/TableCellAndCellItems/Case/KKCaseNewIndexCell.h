//
//  KKCaseNewIndexCell.h
//  Magic
//
//  Created by lixiang on 15/7/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKCaseNewIndexCellActions <DDBaseCellActions>

@required
- (void)kkCaseNewIndexButtonPressed:(NSDictionary *)info;

@end

@interface KKCaseNewIndexCell : YYBaseCell

@end
