//
//  KKTagGroupHeaderCell.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKTagGroupHeaderCell.h"
#import "KKTagGroupHeaderCellItem.h"

#import "KKShowTagGlobalDefine.h"

#define kTagGroupHeaderLeftTitleMarginTop     (18)
#define kTagGroupHeaderLeftTitleHeight        (20)

#define kTagGroupHeaderRightButtonWidth      (70)

@interface KKTagGroupHeaderCell()

@property (nonatomic, strong) UILabel *tagNameLabel;
@property (nonatomic, strong) UIButton *rightButton;

@end

@implementation KKTagGroupHeaderCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor YYViewBgColor];
        
        self.tagNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginS, kTagGroupHeaderLeftTitleMarginTop, [UIDevice screenWidth] * 2/3, kTagGroupHeaderLeftTitleHeight)];
        [self.tagNameLabel setFont:[UIFont systemFontOfSize:16]];
        self.tagNameLabel.textAlignment = NSTextAlignmentLeft;
        self.tagNameLabel.textColor = [UIColor blackColor];
        
        self.rightButton = [[UIButton alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - kTagGroupHeaderRightButtonWidth, kTagGroupHeaderLeftTitleMarginTop, kTagGroupHeaderRightButtonWidth, kTagGroupHeaderLeftTitleHeight)];
        [self.rightButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self.rightButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.rightButton addTarget:self action:@selector(rightButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        
        [self.contentView addSubview:self.tagNameLabel];
        [self.contentView addSubview:self.rightButton];
        
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKTagGroupHeaderCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.tagNameLabel.text = cellItem.tagName;
    [self.rightButton setTitle:cellItem.buttonName forState:UIControlStateNormal];
    if (!cellItem.buttonName || cellItem.buttonName.length == 0) {
        self.rightButton.hidden = YES;
    }
}

- (void)rightButtonClicked:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkTagGroupHeaderRightButtonPressedWithInfo:)];
}

@end
