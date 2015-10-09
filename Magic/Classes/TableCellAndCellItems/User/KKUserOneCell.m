//
//  KKUserOneCell.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKUserOneCell.h"
#import "KKUserOneCellItem.h"
#import "KKPersonItem.h"
#import "DDTImageView.h"

#import "KKProfileOneButton.h"
#import "KKCaseFieldManager.h"

@interface KKUserOneCell()

@property (nonatomic, strong) DDTImageView *avatarImageView;

@property (nonatomic, strong) UIView *middleContentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UILabel *subsubTitleLabel;

@property (nonatomic, strong) UIView *bottomContentView;

@property (nonatomic, strong) UIButton *bottomLeftButton;
@property (nonatomic, strong) UIButton *bottomMiddleButton;
@property (nonatomic, strong) UIButton *bottomRightButton;

@end

@implementation KKUserOneCell


#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat avaterView_width = 45;
        CGFloat rightContentView_width  = 0;
        
        self.seperatorLine.left = kUI_TableView_Common_Margin + avaterView_width + kUI_TableView_Common_Margin;
        
        self.avatarImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(10, 10, avaterView_width, avaterView_width)];
        self.avatarImageView.image = [UIImage imageNamed:@""];
                
        CGFloat middleContentWidth = [UIDevice screenWidth] - avaterView_width - rightContentView_width - 4*kUI_TableView_Common_Margin;
        CGFloat middleContentHeight = 80;
        
        self.middleContentView = [[UIView alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - middleContentWidth, kUI_TableView_Common_Margin, middleContentWidth, middleContentHeight)];
        self.middleContentView.left = self.avatarImageView.right + kUI_TableView_Common_Margin;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, middleContentWidth, 20)];
        [self.nameLabel setThemeUIType:kThemeBasicLabel_Black17];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_Margin, middleContentWidth, 20)];
        self.subTitleLabel.top = self.nameLabel.bottom + kUI_TableView_Common_Margin;
        [self.subTitleLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        
        self.subsubTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_MarginS, middleContentWidth, 20)];
        self.subsubTitleLabel.top = self.subTitleLabel.bottom + kUI_TableView_Common_Margin;
        [self.subsubTitleLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        [self.middleContentView addSubview:self.nameLabel];
        [self.middleContentView addSubview:self.subTitleLabel];
        [self.middleContentView addSubview:self.subsubTitleLabel];
        
        self.bottomContentView = [[UIView alloc] initWithFrame:CGRectMake(0, kUserOneCellItem_height, [UIDevice screenWidth], kUserOneCellItem_Button_height)];
        
        CGFloat buttonWidth = [UIDevice screenWidth] / 2 - 1;
        
        self.bottomLeftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, kUserOneCellItem_Button_height)];
        [self.bottomLeftButton setTitle:@"业务" forState:UIControlStateNormal];
        [self.bottomLeftButton setThemeUIType:kLinkThemeTableMiddleButton];
        [self.bottomLeftButton setImage:[UIImage imageNamed:@"icon_list"] forState:UIControlStateNormal];
        [self.bottomLeftButton addTarget:self action:@selector(oneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.bottomLeftButton.tag = 1;
        
        self.bottomMiddleButton = [[UIButton alloc] initWithFrame:CGRectMake(buttonWidth, 0, buttonWidth, kUserOneCellItem_Button_height)];
        [self.bottomMiddleButton setTitle:@"积分" forState:UIControlStateNormal];
        [self.bottomMiddleButton setThemeUIType:kLinkThemeTableMiddleButton];
        [self.bottomMiddleButton setImage:[UIImage imageNamed:@"icon_reply"] forState:UIControlStateNormal];
        [self.bottomMiddleButton addTarget:self action:@selector(oneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.bottomRightButton.tag = 2;
        
//        self.bottomRightButton = [[UIButton alloc] initWithFrame:CGRectMake(2*buttonWidth, 0, buttonWidth, kUserOneCellItem_Button_height)];
//        [self.bottomRightButton setTitle:@"124天后" forState:UIControlStateNormal];
//        [self.bottomRightButton setThemeUIType:kLinkThemeTableMiddleButton];
//        [self.bottomRightButton setImage:[UIImage imageNamed:@"icon_lock"] forState:UIControlStateNormal];
//        [self.bottomRightButton addTarget:self action:@selector(detailButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *separeteTopLine = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bottomContentView.width, 1)];
        separeteTopLine.backgroundColor = [UIColor KKLineColor];
        
        UIView *separateLine1 = [[UIView alloc] initWithFrame:CGRectMake(buttonWidth, 1, 1, kUserOneCellItem_Button_height -3)];
        separateLine1.backgroundColor = [UIColor KKLineColor];
        
//        UIView *separateLine2 = [[UIView alloc] initWithFrame:CGRectMake(2*buttonWidth, 1, 1, kUserOneCellItem_Button_height-3)];
//        separateLine2.backgroundColor = [UIColor KKLineColor];
        
        [self.bottomContentView addSubview:self.bottomLeftButton];
        [self.bottomContentView addSubview:self.bottomMiddleButton];
        [self.bottomContentView addSubview:self.bottomRightButton];
        
        [self.bottomContentView addSubview:separateLine1];
//        [self.bottomContentView addSubview:separateLine2];
        [self.bottomContentView addSubview:separeteTopLine];
        
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottomContentView.bottom, [UIDevice screenWidth], kUserOneCellItem_SeparateLine_height)];
        bottomLine.backgroundColor = [UIColor YYLineColor];
        
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.middleContentView];
        [self.contentView addSubview:self.bottomContentView];
        [self.contentView addSubview:bottomLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.middleY = self.textLabel.middleY;
}

- (void)setValuesWithCellItem:(KKUserOneCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
//    self.nameLabel.text = @"李东博";
//    self.subTitleLabel.text = @"北京迈凯轮律师事务所";
//    self.subsubTitleLabel.text = @"13899990021";
//    self.avatarImageView.image = [UIImage kkDefaultAvatarImage];
    
    KKPersonItem *personItem = cellItem.rawObject;
    if ([personItem isKindOfClass:[KKPersonItem class]]) {
        self.nameLabel.text = personItem.name;
        self.subTitleLabel.text = personItem.company;
        self.subsubTitleLabel.text = personItem.mobile;
        
        if (personItem.hasAvatar) {
            [self.avatarImageView loadImageWithUrl:personItem.imageItem.urlSmall localImage:YES];
        }
        else {
            self.avatarImageView.image = [UIImage kkDefaultAvatarImage];
        }
    }
    
}

- (void)showImagesWithCellItem:(KKUserOneCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    KKPersonItem *personItem = cellItem.rawObject;
    if ([personItem isKindOfClass:[KKPersonItem class]]) {
        if (personItem.hasAvatar) {
            [self.avatarImageView loadImageWithUrl:personItem.imageItem.urlSmall localImage:NO];
        }
        else {
            self.avatarImageView.image = [UIImage kkDefaultAvatarImage];
        }
    }
}

#pragma mark -
#pragma mark Actions

- (void)oneButtonClicked:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkUserOneCellButtonPressed:)];
}

@end
