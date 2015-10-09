//
//  KKCaseTypeCell.h
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKCaseTypeCellActions <DDBaseCellActions>

@required
- (void)kkCaseTypeMoreInfoPressed:(NSDictionary *)info;

@end

@interface KKCaseTypeCell : YYBaseCell


@end
