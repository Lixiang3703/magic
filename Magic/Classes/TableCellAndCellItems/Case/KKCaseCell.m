//
//  KKCaseCell.m
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseCell.h"
#import "KKCaseCellItem.h"
#import "KKCaseItem.h"
#import "KKCaseFieldManager.h"
#import "DDTImageView.h"

@interface KKCaseCell()
@property (nonatomic, strong) DDTImageView *iconImageView;

@property (nonatomic, strong) UIView *middleContentView;

@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation KKCaseCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.iconImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(10, 10, kCaseCell_IconView_width, kCaseCell_IconView_width)];
        self.iconImageView.image = [UIImage imageNamed:@""];
        self.iconImageView.clipsToBounds = YES;
        self.iconImageView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.iconImageView.layer.borderWidth = 1;
        
        CGFloat middleContentWidth = [UIDevice screenWidth] - kCaseCell_IconView_width - 2*kUI_TableView_Common_Margin;
        CGFloat middleContentHeight = 80;
        
        self.middleContentView = [[UIView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_Margin, middleContentWidth, middleContentHeight)];
        self.middleContentView.left = self.iconImageView.right + kUI_TableView_Common_Margin;
        
        self.statusLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 17)];
        [self.statusLabel setThemeUIType:kThemeBasicLabel_Black17];
        
        CGFloat dateLabel_width = 80;
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dateLabel_width, 14)];
        [self.dateLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        self.dateLabel.textAlignment = NSTextAlignmentRight;
        self.dateLabel.left = self.middleContentView.width - dateLabel_width - 10;
        self.dateLabel.backgroundColor = [UIColor clearColor];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, middleContentWidth, 20)];
        self.titleLabel.top = self.statusLabel.bottom + kUI_TableView_Common_Margin;
        [self.titleLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        self.titleLabel.numberOfLines = 1;
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_Margin, middleContentWidth, 20)];
        self.contentLabel.top = self.titleLabel.bottom + kUI_TableView_Common_Margin;
        [self.contentLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        [self.middleContentView addSubview:self.statusLabel];
        [self.middleContentView addSubview:self.dateLabel];
        [self.middleContentView addSubview:self.titleLabel];
        [self.middleContentView addSubview:self.contentLabel];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.middleContentView];
        
        self.iconImageView.hidden = NO;
    }
    return self;
}

- (void)setValuesWithCellItem:(DDBaseCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    
//    self.titleLabel.text = @"商标业务-商标申请";
//    self.contentLabel.text = @"业务编号：A111";
//    
//    self.statusLabel.text = @"等待支付";
//    self.dateLabel.text = @"两天前";
//    self.iconImageView.image = [UIImage imageNamed:@"icon_qq"];
//    self.iconImageView.hidden = NO;
    
    KKCaseItem *caseItem = cellItem.rawObject;
    if (![caseItem isKindOfClass:[KKCaseItem class]]) {
        return;
    }
    
    NSString *title = @"";
    
    if (caseItem.type == KKCaseTypeTrademark) {
        if (caseItem.customItem.applyName && [caseItem.customItem.applyName hasContent]) {
            title = [title stringByAppendingString:[NSString stringWithFormat:@"注册名称:%@, ", caseItem.customItem.applyName]];
        }
        if (caseItem.customItem.productionName && [caseItem.customItem.productionName hasContent]) {
            title = [title stringByAppendingString:[NSString stringWithFormat:@"产品名称:%@,  ", caseItem.customItem.productionName]];
        }
        if (caseItem.customItem.applyNumber && [caseItem.customItem.applyNumber hasContent]) {
            title = [title stringByAppendingString:[NSString stringWithFormat:@"商标注册号:%@,  ", caseItem.customItem.applyNumber]];
        }
        
        if (caseItem.trademarkItem) {
            [self.iconImageView loadImageWithUrl:caseItem.trademarkItem.urlSmall localImage:YES];
        }
        
    }
    else {
        title = [title stringByAppendingString:caseItem.content];
    }
    
    self.titleLabel.text = title;
    self.statusLabel.text =  [NSString stringWithFormat:@"%@ - %@", [[KKCaseFieldManager getInstance] titleForCaseStatusType:caseItem.status], caseItem.typeItem.name];
    self.contentLabel.text = [NSString stringWithFormat:@"业务编号：%@",caseItem.caseId];
    self.dateLabel.text = [[NSDate dateWithTimeStamp:caseItem.insertTimestamp] stringForPMSessionDate];
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    
}
@end
