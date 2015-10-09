//
//  KKBonusCell.m
//  Magic
//
//  Created by lixiang on 15/5/8.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBonusCell.h"
#import "KKBonusCellItem.h"
#import "KKBonusRecordItem.h"

static const CGFloat rightLabelWidth = 80;
static const CGFloat rightLabelHeight = 20;
@interface KKBonusCell()

@property (nonatomic, strong) UIView *middleContentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation KKBonusCell

#pragma mark -
#pragma mark Life cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat middleContentWidth = [UIDevice screenWidth] - 2*kUI_TableView_Common_Margin - rightLabelWidth;
        self.middleContentView = [[UIView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_Margin, middleContentWidth, kBonusCell_height)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, middleContentWidth, 20)];
        [self.nameLabel setThemeUIType:kThemeBasicLabel_Black17];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_Margin, middleContentWidth, 20)];
        self.contentLabel.top = self.nameLabel.bottom + kUI_TableView_Common_Margin;
        [self.contentLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        [self.middleContentView addSubview:self.nameLabel];
        [self.middleContentView addSubview:self.contentLabel];
        
        self.rightLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - rightLabelWidth, (kBonusCell_height - rightLabelHeight)/2, rightLabelWidth, rightLabelHeight)];
        [self.rightLabel setFont:[UIFont systemFontOfSize:15]];
        [self.rightLabel setTextAlignment:NSTextAlignmentCenter];
        [self.rightLabel setTextColor:[UIColor KKGreenColor]];
        
        
        [self.contentView addSubview:self.middleContentView];
        [self.contentView addSubview:self.rightLabel];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKBonusCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.nameLabel.text = @"成功支付";
    self.contentLabel.text = @"2014-5-2";
    self.rightLabel.text = @"+220";
    
    KKBonusRecordItem *rawObject = cellItem.rawObject;
    if (!rawObject || ![rawObject isKindOfClass:[KKBonusRecordItem class]]) {
        return;
    }
    
    self.nameLabel.text = rawObject.info;
    self.rightLabel.text = [NSString stringWithFormat:@"+%ld",(long)rawObject.bonus];
    
    self.contentLabel.text = [[NSDate dateWithTimeStamp:rawObject.insertTimestamp] stringForPMDate];
    
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
    
}

@end
