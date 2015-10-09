//
//  KKCaseDetailTitleCell.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseDetailTitleCell.h"
#import "KKCaseDetailTitleCellItem.h"
#import "KKCaseFieldManager.h"
#import "DDTImageView.h"

@interface KKCaseDetailTitleCell()

@property (nonatomic, strong) DDTImageView *iconImageView;
@property (nonatomic, strong) UIView *titleView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *subNameLabel;

@end

@implementation KKCaseDetailTitleCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat iconImageView_width = 50;
        
        self.iconImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_Margin, iconImageView_width, iconImageView_width)];
        self.iconImageView.clipsToBounds = YES;
        self.iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.iconImageView.layer.borderWidth = 1;
        
        CGFloat contentWidth = self.width - iconImageView_width - 3*kUI_TableView_Common_Margin;
        
        CGFloat titleViewHeight = 2 * kUI_TableView_TitleLabel_Height + kUI_TableView_Common_Margin;
        
        // titleView with name & subName
        self.titleView = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.right + kUI_TableView_Common_Margin, kUI_TableView_Common_Margin, contentWidth, titleViewHeight)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentWidth, kUI_TableView_BigLabel_Size +3)];
        [self.nameLabel setThemeUIType:kThemeBasicLabel_Black17];
        
        self.subNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, contentWidth, kUI_TableView_TitleLabel_Height)];
        self.subNameLabel.top = self.nameLabel.bottom + kUI_TableView_Common_Margin;
        [self.subNameLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        [self.titleView addSubview:self.nameLabel];
        [self.titleView addSubview:self.subNameLabel];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.titleView];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKCaseDetailTitleCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.nameLabel.text = @"业务正在等待处理";
    self.subNameLabel.text = @"商标申请";
    
//    self.iconImageView.image = [UIImage imageNamed:@"icon_gray_notification3"];
    
    if (cellItem.caseItem == nil) {
        return;
    }
    
    if (cellItem.caseItem.trademarkItem) {
        [self.iconImageView loadImageWithUrl:cellItem.caseItem.trademarkItem.urlSmall localImage:YES];
    }
    
    NSString *subTypeName = [[KKCaseFieldManager getInstance] titleForCaseSubType:cellItem.caseItem.subType];
    NSString *status = [[KKCaseFieldManager getInstance] titleForCaseStatusType:cellItem.caseItem.status];
    
    NSString *attrStr = [NSString stringWithFormat:@"%@  业务编号：%ld", status, (long)cellItem.caseItem.kkId];
    NSDictionary *attribs = @{NSForegroundColorAttributeName:[UIColor YYBlackColor],
                              NSFontAttributeName: [UIFont systemFontOfSize:14]};
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:attrStr attributes:attribs];
    
    [attributedText setAttributes:@{NSForegroundColorAttributeName:[UIColor KKMainColor], NSFontAttributeName:[UIFont systemFontOfSize:18]} range:[attrStr rangeOfString:status ]];
    
    self.nameLabel.attributedText = attributedText;
    self.subNameLabel.text =[NSString stringWithFormat:@"%@ %@",cellItem.caseItem.typeItem.name, subTypeName];
}



@end
