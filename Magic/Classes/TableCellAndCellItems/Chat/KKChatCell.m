//
//  KKChatCell.m
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatCell.h"
#import "KKChatCellItem.h"
#import "KKAccountItem.h"
#import "KKUserInfoItem.h"

#define kChatAvatarImageSize        (40)

@interface KKChatCell()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation KKChatCell


#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //avatarView
        self.avatarView = [[UIView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, 0, kChatAvatarImageSize, kChatAvatarImageSize)];
        
        self.avatarImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(0, 0, kChatAvatarImageSize, kChatAvatarImageSize)];
        
        self.avatarButton = [[UIButton alloc] initWithFrame:self.avatarImageView.frame];
        [self.avatarButton setBackgroundColor:[UIColor clearColor]];
        [self.avatarButton addTarget:self action:@selector(avaterButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.avatarView addSubview:self.avatarImageView];
        [self.avatarView addSubview:self.avatarButton];
        
        //  ContentView
        self.pmContentView = [[UIView alloc] initWithFrame:self.bounds];
        self.pmContentView.clipsToBounds = YES;
        //  Bubble View
        self.bubbleImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.bubbleImageView fullfillPrarentView];
        //  Spinner
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.frame = CGRectMake(0, 0, 44, 44);
        self.spinner.contentMode = UIViewContentModeCenter;
        
        self.operationButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        [self.operationButton setThemeUIType:kLinkThemePMFailButton];
        self.operationButton.hitTestEdgeInsets = UIEdgeInsetsMake(-20, -20, -20, -20);
        [self.operationButton addTarget:self action:@selector(operationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_MarginS, [UIDevice screenWidth], kUI_TableView_Common_Margin)];
        [self.dateLabel setThemeUIType:kLinkThemeTableGroupLabel];
        
        [self.pmContentView addSubview:self.bubbleImageView];
        
        //  Gesture
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        [self.pmContentView addGestureRecognizer:longPressGesture];
        
        [self.contentView addSubview:self.avatarView];
        [self.contentView addSubview:self.pmContentView];
        [self.contentView addSubview:self.spinner];
        [self.contentView addSubview:self.operationButton];
        [self.contentView addSubview:self.dateLabel];
    
    }
    return self;
}

- (void)setValuesWithCellItem:(KKChatCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    YYBaseAPIItem *rawItem = cellItem.rawObject;
    
    self.pmContentView.frame = CGRectMake(0, kUI_TableView_Common_Margin , ceilf(cellItem.contentSize.width), ceilf(cellItem.contentSize.height));
    self.bubbleImageView.width = self.pmContentView.width;
    
    self.avatarView.top = kUI_TableView_Common_Margin;
    //showDate
    if ([cellItem.rawObject isKindOfClass:[KKChatItem class]]){
        KKChatItem *item = (KKChatItem *)cellItem.rawObject;
        if (item.insertTimestamp - cellItem.lastCreateTime > 60 * 2 * 1000) {
            self.dateLabel.text = [[NSDate dateWithTimeStamp:item.insertTimestamp] stringForPMDate];
            self.pmContentView.top = kUI_TableView_Common_MarginW + kUI_TableView_Common_MarginS;
            self.avatarView.top = kUI_TableView_Common_MarginW + kUI_TableView_Common_MarginS;
        } else {
            self.dateLabel.text = @"";
        }
    }
    
    BOOL mine = NO;
    
    if ([rawItem isKindOfClass:[KKChatItem class]]) {
        KKChatItem *chatItem = (KKChatItem *)rawItem;
        mine = (chatItem.mine == DDBaseItemBoolTrue);
        if (!mine) {
            mine = ([KKAccountItem sharedItem].userId == chatItem.userId) ? DDBaseItemBoolTrue: DDBaseItemBoolFalse;
        }
        if (mine && chatItem.userItem == nil) {
            chatItem.userItem = [KKUserInfoItem sharedItem].personItem;
        }
    }
    
    if (mine) {
        self.pmContentView.right = [UIDevice screenWidth] - kUI_TableView_Common_Margin*2 - kChatAvatarImageSize;
        [self.bubbleImageView setThemeUIType:kThemePMRightBubbleImageView];
        self.avatarView.right = [UIDevice screenWidth] - kUI_TableView_Common_Margin;
    } else {
        self.pmContentView.left = kUI_TableView_Common_Margin*2 + kChatAvatarImageSize;
        [self.bubbleImageView setThemeUIType:kThemePMLeftBubbleImageView];
        self.avatarView.left = kUI_TableView_Common_Margin;
    }
    
    if (rawItem.fake) {
        self.spinner.middleX = self.pmContentView.left - self.spinner.width / 2 - 10;
        self.spinner.middleY = self.pmContentView.middleY;
        self.operationButton.middleX = self.spinner.middleX;
        self.operationButton.middleY = self.spinner.middleY;
        if (cellItem.loading) {
            self.spinner.hidden = NO;
            [self.spinner startAnimating];
            self.operationButton.hidden = YES;
        } else {
            [self.spinner stopAnimating];
            self.spinner.hidden = YES;
            self.operationButton.hidden = NO;
        }
    } else {
        [self.spinner stopAnimating];
        self.spinner.hidden = YES;
        self.operationButton.hidden = YES;
    }
    
    if ([rawItem isKindOfClass:[KKChatItem class]]) {
        KKChatItem *chatItem = (KKChatItem *)rawItem;
        
        if (chatItem.userItem.hasAvatar) {
            [self.avatarImageView loadImageWithUrl:chatItem.userItem.imageItem.urlSmall localImage:YES];
        }
        else {
            self.avatarImageView.image = [UIImage kkDefaultAvatarImage];
        }
        
    }
}

#pragma mark -
#pragma mark Images

- (void)showImagesWithCellItem:(KKChatCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    KKChatItem *chatItem = (KKChatItem*)cellItem.rawObject;
    
    if (![chatItem isKindOfClass:[KKChatItem class]]) {
        return;
    }
    
    if (chatItem.userItem && chatItem.userItem.imageItem) {
        if (chatItem.userItem.hasAvatar) {
            [self.avatarImageView loadImageWithUrl:chatItem.userItem.imageItem.urlSmall localImage:NO];
        }
        else {
            self.avatarImageView.image = [UIImage kkDefaultAvatarImage];
        }
    }
}

#pragma mark -
#pragma mark Gesture

- (void)avaterButtonPressed:(UIButton *)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkChatCellAvaterPressedWithInfo:)];
}

- (void)longPressed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan){
        [self.ddTableView cellActionWithCell:self control:self.pmContentView userInfo:nil selector:@selector(kkChatCellLongPressedWithInfo:)];
    }
}

- (void)operationButtonPressed:(UIButton *)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkChatCellOperationButtonPressedWithInfo:)];
}

@end
