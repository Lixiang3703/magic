//
//  KKMultiImageCell.h
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

@protocol KKMultiImageCellActions <DDBaseCellActions>

@required
- (void)kkMultiImagePressed:(NSDictionary *)info;

@end

@interface KKMultiImageCell : YYBaseCell

@end
