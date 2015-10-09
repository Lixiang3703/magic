//
//  KKMessageCell.m
//  Magic
//
//  Created by lixiang on 15/4/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMessageCell.h"
#import "KKMessageCellItem.h"
#import "KKMessageItem.h"
#import "KKTypeManager.h"
#import "DDBadgeView.h"

static const CGFloat badgaView_width = 30;

@interface KKMessageCell()

@property (nonatomic, strong) UIImageView *iconImageView;


@property (nonatomic, strong) UIView *rightContentView;
@property (nonatomic, strong) UILabel *rightContentLabel;

@property (nonatomic, strong) UIView *middleContentView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *subContentLabel;

@property (nonatomic, strong) DDBadgeView *badgeView;
@end

@implementation KKMessageCell


#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.seperatorLine.left = kUI_TableView_Common_Margin + kMessageAvaterView_width + kUI_TableView_Common_Margin;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, kMessageAvaterView_width, kMessageAvaterView_width)];
        self.iconImageView.image = [UIImage imageNamed:@""];
        
        CGFloat middleContentWidth = [UIDevice screenWidth] - kMessageAvaterView_width - 4*kUI_TableView_Common_Margin - badgaView_width;
        CGFloat middleContentHeight = 80;
        
        self.middleContentView = [[UIView alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - middleContentWidth, kUI_TableView_Common_Margin, middleContentWidth, middleContentHeight)];
        self.middleContentView.left = self.iconImageView.right + kUI_TableView_Common_Margin;
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, middleContentWidth, 20)];
        [self.titleLabel setThemeUIType:kThemeBasicLabel_Black17];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_Margin, middleContentWidth, kMessage_ContentLabel_height)];
        self.contentLabel.top = self.titleLabel.bottom + kUI_TableView_Common_Margin;
        [self.contentLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];

        self.subContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_MarginS, middleContentWidth, 20)];
        self.subContentLabel.top = self.contentLabel.bottom + kUI_TableView_Common_Margin;
        [self.subContentLabel setThemeUIType:kThemeBasicLabel_LightGray12];
        
        [self.middleContentView addSubview:self.titleLabel];
        [self.middleContentView addSubview:self.contentLabel];
        [self.middleContentView addSubview:self.subContentLabel];
        
        self.badgeView = [[DDBadgeView alloc] initWithCenterPoint:CGPointMake([UIDevice screenWidth] - badgaView_width/2, kMessageCellItem_height/2) type:DDBadgeViewTypeMiddle];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.middleContentView];
        [self.contentView addSubview:self.badgeView];
//        [self.contentView addSubview:self.rightContentView];
        
        //  Operation View
        CGFloat buttonWidth = 75;
        self.operationContainerView.width = buttonWidth;
        
        self.defaultOperationButton.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.defaultOperationButton.frame = self.operationContainerView.bounds;
        [self.defaultOperationButton setTitle:_(@"删除") forState:UIControlStateNormal];
        self.defaultOperationButton.backgroundColor = [UIColor redColor];
        
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.middleY = self.textLabel.middleY;
}

- (void)setValuesWithCellItem:(KKMessageCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.titleLabel.text = @"你的案件后台已经受理";
    self.contentLabel.text = @"哇哈哈哈";
    self.subContentLabel.text = @"两天前";
    
    self.iconImageView.image = [UIImage imageNamed:@"icon_gray_message3"];
    
    KKMessageItem *item = cellItem.rawObject;
    if (![item isKindOfClass:[KKMessageItem class]]) {
        return;
    }
    
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.content;
    self.subContentLabel.text = [[NSDate dateWithTimeStamp:item.insertTimestamp] stringForPMDate];
    
    self.iconImageView.image = [[KKTypeManager getInstance] imageForMessageType:item.type];
    [self.badgeView setBadgeCount:(item.hasRead != DDBaseItemBoolTrue) ? 1 : 0];
}


@end


