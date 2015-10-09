//
//  KKProfileIntroCell.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKProfileIntroCell.h"
#import "KKProfileIntroCellItem.h"

#import "KKPersonItem.h"

@interface KKProfileIntroCell()
@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) UIButton *avaterButton;

@property (nonatomic, strong) UIView *rightContentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation KKProfileIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
    
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], 150)];
        self.bgImageView.userInteractionEnabled = YES;
        self.bgImageView.image = [UIImage imageNamed:@"mine_bg.jpg"];
        self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
        
        CGFloat avaterImageView_marginLeft = 25;
        CGFloat avaterImageView_marginRight = 20;
        CGFloat avaterImageView_width = 65;
        CGFloat avaterImageView_marginTop = (kProfileIntroCell_Height - avaterImageView_width)/2;
        
        CGFloat rightContentView_width = [UIDevice screenWidth] - avaterImageView_width - avaterImageView_marginLeft - avaterImageView_marginRight;
        
        self.avatarImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(avaterImageView_marginLeft, avaterImageView_marginTop, avaterImageView_width, avaterImageView_width)];
        [self.avatarImageView circlize];
        self.avatarImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        self.avatarImageView.layer.borderWidth = 1.5;
        
        self.avatarImageView.middleY = self.bgImageView.bottom;
        
        self.avaterButton = [[UIButton alloc] initWithFrame:self.avatarImageView.frame];
        self.avaterButton.backgroundColor = [UIColor clearColor];
        [self.avaterButton addTarget:self action:@selector(avaterClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightContentView = [[UIView alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - rightContentView_width, 0, rightContentView_width, kProfileIntroCell_Height)];
        self.rightContentView.backgroundColor = [UIColor clearColor];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, [UIDevice screenWidth] - kUI_TableView_DefaultButton_Width - 3*kUI_Login_Common_MarginS - kUI_Login_Common_Margin, 35)];
        self.nameLabel.bottom = self.bgImageView.bottom;
        [self.nameLabel setThemeUIType:kThemeBasicLabel_White16];
        [self.nameLabel setFont:[UIFont systemFontOfSize:20]];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:self.nameLabel.frame];
        self.titleLabel.top = self.nameLabel.bottom;
        self.titleLabel.left = 0;
        self.titleLabel.width = 110;
        [self.titleLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        
        self.subTitleLabel = [[UILabel alloc] initWithFrame:self.titleLabel.frame];
        [self.subTitleLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        self.subTitleLabel.font = [UIFont systemFontOfSize:14];
        [self.subTitleLabel setTextAlignment:NSTextAlignmentCenter];
        self.subTitleLabel.left = self.titleLabel.right;
        
        UIView *middleSeparateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 15)];
        middleSeparateLineView.left = self.titleLabel.right;
        middleSeparateLineView.top = self.titleLabel.top + (self.titleLabel.height - 15)/2;
        middleSeparateLineView.backgroundColor = [UIColor YYLineColor];
        
        [self.contentView addSubview:self.bgImageView];
        [self.contentView addSubview:self.avatarImageView];
        [self.contentView addSubview:self.avaterButton];
        [self.contentView addSubview:self.rightContentView];
        
        [self.rightContentView addSubview:self.nameLabel];
        [self.rightContentView addSubview:self.titleLabel];
        [self.rightContentView addSubview:self.subTitleLabel];
        [self.rightContentView addSubview:middleSeparateLineView];
        
        UIButton *upButton = [[UIButton alloc] initWithFrame:CGRectMake(self.avaterButton.right + 10, 0, [UIDevice screenWidth] - self.avaterButton.left - 10, kProfileIntroCell_Height)];
        upButton.backgroundColor = [UIColor clearColor];
        [upButton addTarget:self action:@selector(upButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:upButton];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKProfileIntroCellItem *)cellItem{
    [super setValuesWithCellItem:cellItem];
    
    self.nameLabel.text = @"北京迈凯伦律师事务所";
    self.titleLabel.text = @"合作伙伴 - 推荐码: CLS63AMG";
//    [self.avatarImageView loadImageWithUrl:@"http://t12.baidu.com/it/u=4224136820,222817142&fm=32&s=CE73A55661C252F05E652DCE010070E2&w=623&h=799&img.JPEG" localImage:YES];
    
    KKPersonItem *personItem = cellItem.rawObject;
    if ([personItem isKindOfClass:[KKPersonItem class]]) {
        self.nameLabel.text = personItem.name;
        NSString *roleStr = @"普通会员";
        if (personItem.role == KKPersonRoleTypeAgent) {
            roleStr = [NSString stringWithFormat:@"合作伙伴 - 推荐码: %@", personItem.code];
        }
        self.titleLabel.text = personItem.mobile;
        
        self.subTitleLabel.text = roleStr;
        
        if (personItem.hasAvatar) {
            [self.avatarImageView loadImageWithUrl:personItem.imageItem.urlSmall localImage:YES];
        }
        else {
            self.avatarImageView.image = [UIImage kkDefaultAvatarImage];
        }
    }
}

- (void)showImagesWithCellItem:(KKProfileIntroCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
    
//    [self.avatarImageView loadImageWithUrl:@"http://t12.baidu.com/it/u=4224136820,222817142&fm=32&s=CE73A55661C252F05E652DCE010070E2&w=623&h=799&img.JPEG" localImage:NO];
    
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
#pragma mark Action

- (void)avaterClicked:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkProfileAvaterButtonPressed:)];
}

- (void)upButtonClicked:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkProfileBgImagePressed:)];
}

@end
