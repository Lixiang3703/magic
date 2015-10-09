//
//  YYButtonCell.m
//  Wuya
//
//  Created by lilingang on 14-6-27.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYButtonCell.h"
#import "YYButtonCellItem.h"

@interface YYButtonCell ()

@property (nonatomic, strong) UIButton *tipButton;

@end

@implementation YYButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tipButton = [[UIButton alloc] initWithFrame:CGRectMake(75, 2, 170, 40)];
        [self.tipButton addTarget:self action:@selector(tipButtonPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.tipButton setHitTestEdgeInsets:UIEdgeInsetsMake(-10, -10, -10, -10)];
        [self.contentView addSubview:self.tipButton];
    }
    return self;
}

- (void)setValuesWithCellItem:(YYButtonCellItem *)cellItem{
    [super setValuesWithCellItem:cellItem];
    [self.tipButton setTitle:cellItem.tipTitle forState:UIControlStateNormal];
    [self.tipButton setThemeUIType:cellItem.buttonTheme];
    [self.tipButton setImageEdgeInsetsType:cellItem.buttonType textOffSet:3 imageOffSet:3];
}
#pragma mark -
#pragma mark Buttons

- (void)tipButtonPress:(UIButton *)button{
    [self.ddTableView cellActionWithCell:self control:button userInfo:nil selector:@selector(yyButtonCellPressedWithInfo:)];
}
@end
