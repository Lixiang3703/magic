//
//  KKUserOneCell.h
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKUserOneCellActions <DDBaseCellActions>

@required
- (void)kkUserOneCellButtonPressed:(NSDictionary *)info;

@end

@interface KKUserOneCell : YYBaseCell

@end
