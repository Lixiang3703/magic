//
//  KKTagGroupHeaderCell.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCell.h"

#import "YYGroupHeaderCell.h"

@protocol KKTagGroupHeaderCellDelegate <NSObject>

@optional
- (void)kkTagGroupHeaderRightButtonPressedWithInfo:(NSDictionary *)dict;

@end

@interface KKTagGroupHeaderCell : YYGroupHeaderCell

@end
