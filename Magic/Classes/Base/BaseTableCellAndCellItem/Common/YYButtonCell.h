//
//  YYButtonCell.h
//  Wuya
//
//  Created by lilingang on 14-6-27.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYBaseCell.h"

@protocol YYButtonCellActions <YYBaseCellActions>

- (void)yyButtonCellPressedWithInfo:(NSDictionary *)info;

@end

@interface YYButtonCell : YYBaseCell

@end
