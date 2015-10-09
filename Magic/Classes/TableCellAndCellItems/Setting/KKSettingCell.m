//
//  KKSettingCell.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKSettingCell.h"
#import "KKSettingCellItem.h"

@interface KKSettingCell()

@property (nonatomic, strong) UIImageView *groupTopSeperatorLine;
@property (nonatomic, strong) UIImageView *groupBottomSeperatorLine;

@end

@implementation KKSettingCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //  UI
        self.seperatorLine.left = kUI_TableView_Common_MarginW;
        self.seperatorLine.width = [UIDevice screenWidth] - kUI_TableView_Common_MarginW;
        
        self.detailTextLabel.font = [UIFont YYFontBig];
        
//        self.groupTopSeperatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
//        self.groupTopSeperatorLine.autoresizesSubviews = UIViewAutoresizingFlexibleBottomMargin;
//        self.groupTopSeperatorLine.image = [UIImage yyImageWithColor:[UIColor YYLineColor]];
//        
//        self.groupBottomSeperatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - 0.5, self.width, 0.5)];
//        self.groupBottomSeperatorLine.autoresizesSubviews = UIViewAutoresizingFlexibleTopMargin;
//        self.groupBottomSeperatorLine.image = [UIImage yyImageWithColor:[UIColor YYLineColor]];
//                
//        [self.contentView addSubview:self.groupTopSeperatorLine];
//        [self.contentView addSubview:self.groupBottomSeperatorLine];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.detailTextLabel.middleY = self.textLabel.middleY;
}

- (void)setValuesWithCellItem:(KKSettingCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
//    self.groupTopSeperatorLine.hidden = cellItem.groupTopSeperatorLineHidden;
//    self.groupBottomSeperatorLine.hidden = cellItem.groupBottomSeperatorLineHidden;
}


@end
