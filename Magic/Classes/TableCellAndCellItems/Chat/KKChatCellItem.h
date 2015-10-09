//
//  KKChatCellItem.h
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCellItem.h"
#import "KKChatItem.h"

@interface KKChatCellItem : YYBaseCellItem

@property (nonatomic, assign) NSTimeInterval lastCreateTime;
@property (nonatomic, assign) CGSize contentSize;
@property (nonatomic, assign) BOOL loading;

@property (nonatomic, assign) BOOL shouldShowDate;

@property (nonatomic, assign) BOOL audioLoading;

- (void)updateItemForLastCreateTime;

@end
