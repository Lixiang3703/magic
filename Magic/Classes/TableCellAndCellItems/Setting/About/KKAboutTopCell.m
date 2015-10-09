//
//  KKAboutTopCell.m
//  Magic
//
//  Created by lixiang on 15/6/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKAboutTopCell.h"
#import "KKAboutTopCellItem.h"

static const CGFloat imageView_width = 60;

@interface KKAboutTopCell()

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UILabel *middleLabel;
@property (nonatomic, strong) UILabel *bottomLabel;

@end

@implementation KKAboutTopCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(([UIDevice screenWidth] - imageView_width)/2, 30, imageView_width, imageView_width)];
        self.topImageView.layer.cornerRadius = 3.0f;
        self.topImageView.clipsToBounds = YES;
        
        self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topImageView.bottom + 20, [UIDevice screenWidth], 20)];
        [self.topLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        self.topLabel.textAlignment = NSTextAlignmentCenter;
        
        self.middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.topLabel.bottom + 20, [UIDevice screenWidth], 25)];
        [self.middleLabel setThemeUIType:kThemeBasicLabel_Black17];
        self.middleLabel.textAlignment = NSTextAlignmentCenter;
        
        self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.middleLabel.bottom + 20, [UIDevice screenWidth] - 30, 50)];
        [self.bottomLabel setThemeUIType:kThemeBasicLabel_MiddleGray14];
        self.bottomLabel.numberOfLines = 0;
        self.bottomLabel.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.topImageView];
        [self.contentView addSubview:self.topLabel];
        [self.contentView addSubview:self.middleLabel];
        [self.contentView addSubview:self.bottomLabel];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKAboutTopCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.topImageView.image = [UIImage imageNamed:@"app-icon"];
    self.topLabel.text = [NSString stringWithFormat:@"V%@",[UIApplication wholeAppVersion]];
    self.middleLabel.text = @"知产通";
    
    self.bottomLabel.height = cellItem.infoHeight;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:cellItem.infoStr];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:5];//调整行间距
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [cellItem.infoStr length])];
    self.bottomLabel.attributedText = attributedString;
}


@end
