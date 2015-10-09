//
//  KKChatCell.h
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCell.h"
#import "DDTImageView.h"

@protocol KKChatCellActions <YYBaseCellActions>

- (void)kkChatCellAvaterPressedWithInfo:(NSDictionary *)info;
- (void)kkChatCellLongPressedWithInfo:(NSDictionary *)info;
- (void)kkChatCellOperationButtonPressedWithInfo:(NSDictionary *)info;

@end

@interface KKChatCell : YYBaseCell

@property (nonatomic, strong) UIView *avatarView;
@property (nonatomic, strong) DDTImageView *avatarImageView;
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UIView *pmContentView;
@property (nonatomic, strong) UIImageView *bubbleImageView;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;
@property (nonatomic, strong) UIButton *operationButton;

@end
