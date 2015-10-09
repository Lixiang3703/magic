//
//  KKChatSessionCell.h
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseCell.h"
#import "DDBadgeView.h"
#import "DDTImageView.h"

@protocol KKChatSessionCellActions <YYBaseCellActions>

- (void)kkChatSessionCellAvaterPressedWithInfo:(NSDictionary *)info;

@end

@interface KKChatSessionCell : YYBaseCell

@property (nonatomic, strong) UILabel *authorNameLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) DDTImageView *photoImageView;
@property (nonatomic, strong) DDBadgeView *badgeView;
@property (nonatomic, strong) DDBadgeView *smallBadgeView;


@end
