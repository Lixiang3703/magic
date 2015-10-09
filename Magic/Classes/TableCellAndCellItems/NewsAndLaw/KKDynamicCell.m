//
//  KKNewsCell.m
//  Magic
//
//  Created by lixiang on 15/4/11.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKDynamicCell.h"
#import "KKDynamicCellItem.h"
#import "KKDynamicItem.h"

@interface KKDynamicCell()

@property (nonatomic, strong) UIView *middleContentView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *subContentLabel;

@end

@implementation KKDynamicCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat middleContentWidth = [UIDevice screenWidth] - 2*kUI_TableView_Common_Margin;
        self.middleContentView = [[UIView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_Margin, middleContentWidth, kNewsCellItem_height)];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, middleContentWidth, 20)];
        [self.nameLabel setThemeUIType:kThemeBasicLabel_Black17];
        [self.nameLabel setBackgroundColor:[UIColor clearColor]];
        
        self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_Margin, middleContentWidth, 20)];
        self.contentLabel.top = self.nameLabel.bottom + kUI_TableView_Common_Margin;
        [self.contentLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        self.subContentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kUI_TableView_Common_MarginS, middleContentWidth, 20)];
        self.subContentLabel.top = self.contentLabel.bottom + kUI_TableView_Common_Margin;
        [self.subContentLabel setThemeUIType:kThemeBasicLabel_MiddleGray13];
        
        [self.middleContentView addSubview:self.nameLabel];
        [self.middleContentView addSubview:self.contentLabel];
        [self.middleContentView addSubview:self.subContentLabel];
        
        [self.contentView addSubview:self.middleContentView];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKDynamicCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    
    self.nameLabel.text = @"“嘀嘀打车”遭遇商标难题";
    self.contentLabel.text = @"来源:中国知识产权报";
    self.subContentLabel.text = @"2014-3-21";
    
    KKDynamicItem *item = cellItem.rawObject;
    if (![item isKindOfClass:[KKDynamicItem class]]) {
        return;
    }
    
    self.nameLabel.text = item.title;
    self.contentLabel.text = item.subTitle;
    self.subContentLabel.text = [[NSDate dateWithTimeStamp:item.newsTimestamp] stringForShortDate];
    
    if (cellItem.singleLine) {
        self.subContentLabel.hidden = YES;
        self.contentLabel.hidden = YES;
        self.nameLabel.top = 0;
        self.nameLabel.height = cellItem.cellHeight - 20;
        self.nameLabel.numberOfLines = 2;
        
        self.nameLabel.text = @"";
        [self setTitleLabelWithStr:item.title];
    }
    else {
        self.subContentLabel.hidden = NO;
        self.contentLabel.hidden = NO;
        self.nameLabel.height = 20;
        self.nameLabel.numberOfLines = 1;
    }
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
    
    
}

- (void)setTitleLabelWithStr:(NSString *)str {
    if (str == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.nameLabel.attributedText = attributedString;
}

@end
