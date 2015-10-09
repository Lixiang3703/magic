//
//  KKShowTagCellItem.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKShowOrModifyBaseCellItem.h"
#import "KKShowTagGlobalDefine.h"

#import "KKShowTagItem.h"

@interface KKShowTagCellItem : KKShowOrModifyBaseCellItem

@property (nonatomic, assign) KKShowTagCellLayoutType cellLayoutType;

@property (nonatomic, assign) CGFloat titleLabelHeight;

@property (nonatomic, assign) CGFloat tagLabelWidth;

- (void)updateCellItemWithTagItem:(KKShowTagItem *)showTagItem;

@end
