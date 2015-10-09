//
//  KKChatSessionCell.m
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatSessionCell.h"
#import "KKChatSessionCellItem.h"
#import "KKChatSessionItem.h"
#import "KKChatItem.h"

@implementation KKChatSessionCell

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //  UI
        
        self.photoImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, 8, kUI_ImageSize_ChatSession_Avatar, kUI_ImageSize_ChatSession_Avatar)];
        self.photoImageView.backgroundColor = [UIColor grayColor];
        
        self.avatarButton = [[UIButton alloc] initWithFrame:self.photoImageView.frame];
        [self.avatarButton setBackgroundColor:[UIColor clearColor]];
        [self.avatarButton addTarget:self action:@selector(avaterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.authorNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.photoImageView.right + kUI_TableView_Common_Margin, 7.5, [UIDevice screenWidth] - kUI_PMSession_Date_Width - kUI_ImageSize_ChatSession_Avatar - 4*kUI_TableView_Common_Margin, 0)];
        [self.authorNameLabel setThemeUIType:kLinkThemePMSessionTitleLabel];
        [self.authorNameLabel trimHeight];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:self.authorNameLabel.frame];
        self.dateLabel.width = kUI_PMSession_Date_Width;
        self.dateLabel.right = [UIDevice screenWidth] - kUI_TableView_Common_Margin;
        [self.dateLabel setThemeUIType:kLinkThemePMSessionDateLabel];
        
        self.messageLabel = [[UILabel alloc] initWithFrame:self.authorNameLabel.frame];
        self.messageLabel.width = [UIDevice screenWidth] - kUI_ImageSize_ChatSession_Avatar - 4*kUI_TableView_Common_Margin;
        [self.messageLabel setThemeUIType:kLinkThemePMSessionDetailLabel];
        
        [self.messageLabel trimHeight];
        self.messageLabel.top = self.authorNameLabel.bottom + kUI_TableView_Common_MarginS;
        
        self.badgeView = [[DDBadgeView alloc] initWithCenterPoint:CGPointMake(self.photoImageView.right, self.photoImageView.top + 3) type:DDBadgeViewTypeLarge];
        self.badgeView.hidden = YES;
        
        self.smallBadgeView = [[DDBadgeView alloc] initWithCenterPoint:CGPointMake(self.photoImageView.right, self.photoImageView.top + 3) type:DDBadgeViewTypeMiddle];
        [self.smallBadgeView setBadgeCount:1];
        self.smallBadgeView.hidden = YES;
        
        [self.contentView addSubview:self.photoImageView];
        [self.contentView addSubview:self.avatarButton];
        [self.contentView addSubview:self.authorNameLabel];
        [self.contentView addSubview:self.messageLabel];
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.badgeView];
        [self.contentView addSubview:self.smallBadgeView];
        
        self.defaultOperationButton.backgroundColor = [UIColor redColor];
        [self.defaultOperationButton setTitle:_(@"删除") forState:UIControlStateNormal];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKChatSessionCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];

    // test values
//    [self.photoImageView loadImageWithUrl:@"http://c.hiphotos.baidu.com/image/pic/item/b8389b504fc2d5621f070fefe51190ef76c66ca1.jpg" localImage:YES];
//    self.authorNameLabel.text = @"胡汉三";
//    self.messageLabel.text = @"红颜最难得知己";
//    self.dateLabel.text = @"3小时前";
//    
//    self.badgeView.hidden = NO;
//    [self.badgeView setBadgeCount:3];
    
    
    KKChatSessionItem *chatSessionItem = (KKChatSessionItem*)cellItem.rawObject;
    if (![chatSessionItem isKindOfClass:[KKChatSessionItem class]]) {
        return;
    }
    
    if (chatSessionItem.unreadCount > 0) {
        self.badgeView.hidden = NO;
        [self.badgeView setBadgeCount:chatSessionItem.unreadCount];
    }
    else {
        self.badgeView.hidden = YES;
    }
    
    if (chatSessionItem.toUserItem) {
        self.authorNameLabel.text = chatSessionItem.toUserItem.name;
        if ([chatSessionItem.toUserItem hasAvatar]) {
            [self.photoImageView loadImageWithUrl:chatSessionItem.toUserItem.imageItem.urlSmall localImage:YES];
        }
        else {
            self.photoImageView.image = [UIImage kkDefaultAvatarImage];
        }
        
    }
    
    if (chatSessionItem.latestChatMsgItem) {
        if (chatSessionItem.latestChatMsgItem.type == KKChatTypeText) {
            self.messageLabel.text = chatSessionItem.latestChatMsgItem.content;
        }
        else if (chatSessionItem.latestChatMsgItem.type == KKChatTypeImage) {
            self.messageLabel.text = @"[图片]";
        }
        
        self.dateLabel.text = [NSString stringWithEndTime:chatSessionItem.latestChatMsgItem.updateTimestamp];
    }
    
}


- (void)showImagesWithCellItem:(KKChatSessionCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    KKChatSessionItem *chatSessionItem = (KKChatSessionItem*)cellItem.rawObject;
    if (![chatSessionItem isKindOfClass:[KKChatSessionItem class]]) {
        return;
    }
    if (chatSessionItem.toUserItem) {
        self.authorNameLabel.text = chatSessionItem.toUserItem.name;
        if ([chatSessionItem.toUserItem hasAvatar]) {
            [self.photoImageView loadImageWithUrl:chatSessionItem.toUserItem.imageItem.urlSmall localImage:NO];
        }
        else {
            self.photoImageView.image = [UIImage kkDefaultAvatarImage];
        }
    }
}

#pragma mark -
#pragma mark Buttons

- (void)avaterButtonPressed:(UIButton *)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkChatSessionCellAvaterPressedWithInfo:)];
}


@end



