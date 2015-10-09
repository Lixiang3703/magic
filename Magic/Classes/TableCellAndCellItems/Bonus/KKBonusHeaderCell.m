//
//  KKBonusHeaderCell.m
//  Magic
//
//  Created by lixiang on 15/5/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBonusHeaderCell.h"
#import "KKBonusHeaderCellItem.h"

static const CGFloat middleContent_MarginLeft = 20;

@interface KKBonusHeaderCell()

@property (nonatomic, strong) UIView *middleContentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIButton *button;

@end

@implementation KKBonusHeaderCell

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat middleContentWidth = [UIDevice screenWidth] - 2*middleContent_MarginLeft;
        self.middleContentView = [[UIView alloc] initWithFrame:CGRectMake(middleContent_MarginLeft, kUI_TableView_Common_Margin, middleContentWidth, kBonusHeaderCell_height)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, middleContentWidth, 20)];
        [self.nameLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_Margin, middleContentWidth, 30)];
        self.contentLabel.top = self.nameLabel.bottom + kUI_TableView_Common_Margin;
        [self.contentLabel setFont:[UIFont systemFontOfSize:24]];
        [self.contentLabel setTextAlignment:NSTextAlignmentLeft];
        [self.contentLabel setTextColor:[UIColor KKGreenColor]];
        
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, middleContentWidth, 44)];
        self.button.top = self.contentLabel.bottom + 10;
        [self.button setBackgroundColor:[UIColor KKGreenColor]];
        self.button.layer.cornerRadius = 4.0f;
        self.button.clipsToBounds = YES;
        [self.button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.button setTitle:@"积分兑换商品" forState:UIControlStateNormal];
        [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.middleContentView addSubview:self.nameLabel];
        [self.middleContentView addSubview:self.contentLabel];
        [self.middleContentView addSubview:self.button];
        
        [self.contentView addSubview:self.middleContentView];

    }
    return self;
}

- (void)setValuesWithCellItem:(KKBonusHeaderCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.nameLabel.text = @"我的积分";
    self.contentLabel.text = [NSString stringWithFormat:@"%ld",(long)cellItem.bonus];
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
    
}

#pragma mark -
#pragma mark Actions

- (void)buttonPressed:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkBonusHeaderButtonPressed:)];
}


@end


