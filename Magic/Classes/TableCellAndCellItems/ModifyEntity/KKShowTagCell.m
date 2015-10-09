//
//  KKShowTagCell.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKShowTagCell.h"
#import "KKShowTagCellItem.h"

@interface KKShowTagCell()

@property (nonatomic, strong) UILabel *tagNameLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat tagLabelWidth;
@property (nonatomic, assign) CGFloat titleLabel_shortWidth;
@property (nonatomic, assign) CGFloat titleLabel_longWidth;


@end

@implementation KKShowTagCell

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = kUI_Login_Common_Margin + kUI_Profile_Tag_TagLabel_Width + 2;
        self.seperatorLine.width = [UIDevice screenWidth] - (kUI_Login_Common_Margin + kUI_Profile_Tag_TagLabel_Width + 2);
        
        self.titleLabel_shortWidth = [UIDevice screenWidth] - 2*kUI_Login_Common_MarginW - 2 * kUI_Login_Common_MarginW - kUI_Profile_Tag_TagLabel_Width;
        self.titleLabel_longWidth = [UIDevice screenWidth] - 2*kUI_Login_Common_MarginW;
        
        //功能名
        self.tagNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_Margin, kUI_Profile_Tag_TagLabel_MarginTop, kUI_Profile_Tag_TagLabel_Width, kUI_Profile_Tag_TagLabel_Height)];
        self.tagNameLabel.textAlignment = NSTextAlignmentRight;
        self.tagNameLabel.textColor = [UIColor lightGrayColor];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.tagNameLabel.right + kUI_TableView_Common_MarginLevel2, kUI_Profile_Tag_TagLabel_MarginTop , self.titleLabel_shortWidth, kUI_Profile_Tag_TagLabel_Height)];
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        self.titleLabel.font = [UIFont systemFontOfSize:16];
        self.titleLabel.numberOfLines = 0;
        
        [self.contentView addSubview:self.tagNameLabel];
        [self.contentView addSubview:self.titleLabel];
        
    }
    return self;
}


- (void)setValuesWithCellItem:(KKShowTagCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    if (cellItem.tagLabelWidth > 0) {
        self.tagNameLabel.width = cellItem.tagLabelWidth;
        self.titleLabel.left = self.tagNameLabel.right + kUI_TableView_Common_MarginLevel2;
        self.seperatorLine.left = self.titleLabel.left;
    }
    
    KKShowTagItem *showTagItem = (KKShowTagItem *)cellItem.rawObject;

    
    if (showTagItem.cellLayoutType == KKShowTagCellLayoutTypeFloatTop) {
        self.titleLabel.frame = CGRectMake(kUI_Login_Common_MarginW, self.tagNameLabel.bottom + kUI_Profile_Tag_TitleLabel_MarginTop, self.titleLabel_longWidth, kUI_Profile_Tag_TagLabel_Height);
        
        if (!showTagItem.tagName || showTagItem.tagName.length == 0) {
            self.titleLabel.top = kUI_TableView_Common_Margin;
            self.tagNameLabel.hidden = YES;
        }
    }
    else if (showTagItem.cellLayoutType == KKShowTagCellLayoutTypeFloatLeft) {
        self.titleLabel.frame = CGRectMake(self.tagNameLabel.right + kUI_TableView_Common_MarginLevel2, kUI_Profile_Tag_TagLabel_MarginTop ,self.titleLabel_shortWidth, kUI_Profile_Tag_TagLabel_Height);
        
        if (showTagItem.tagName || showTagItem.tagName.length > 0) {
            self.tagNameLabel.hidden = NO;
        }
        
    }
    
    self.titleLabel.height = cellItem.titleLabelHeight;
    
    if ([showTagItem isKindOfClass:[KKShowTagItem class]]) {
        self.tagNameLabel.text = showTagItem.tagName;
        if (showTagItem.cellLayoutType == KKShowTagCellLayoutTypeFloatTop) {
            self.titleLabel.text = showTagItem.titleName;
            NSLog(@"number:%ld",(long)self.titleLabel.numberOfLines);
            [self setTitleLabelWithStr:showTagItem.titleName];
        }
        else if (showTagItem.cellLayoutType == KKShowTagCellLayoutTypeFloatLeft) {
            self.titleLabel.text = showTagItem.titleName;
        }
        
        
    }
}

- (void)setTitleLabelWithStr:(NSString *)str {
    
    if (str == nil) {
        return;
    }
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:10];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
    self.titleLabel.attributedText = attributedString;
}

@end


