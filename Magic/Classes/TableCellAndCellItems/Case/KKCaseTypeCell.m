//
//  KKCaseTypeCell.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseTypeCell.h"
#import "KKCaseTypeCellItem.h"
#import "KKCaseTypeItem.h"
#import "DDTImageView.h"

@interface KKCaseTypeCell()

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UIView *rightContentView;

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation KKCaseTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        CGFloat avaterView_width = 50;
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (KCaseTypeCellItem_height - 1 - avaterView_width)/2, avaterView_width, avaterView_width)];
        
        self.rightContentView = [[UIView alloc] initWithFrame:CGRectMake(self.iconImageView.right + 10, 0, [UIDevice screenWidth] - self.iconImageView.right -30, KCaseTypeCellItem_height)];
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.rightContentView.width - 10, KCaseTypeCellItem_height)];
        [self.titleLabel setThemeUIType:kThemeBasicLabel_Black17];
        [self.titleLabel setFont:[UIFont systemFontOfSize:20]];
        [self.titleLabel setTextColor:[UIColor KKBlueColor]];
    
        [self.rightContentView addSubview:self.titleLabel];

        UIView *bottomSeparateLineView = [[UIView alloc] initWithFrame:CGRectMake(0, KCaseTypeCellItem_height - 1, [UIDevice screenWidth], 1)];
        bottomSeparateLineView.backgroundColor = [UIColor YYLineColor];
        
        [self.contentView addSubview:self.iconImageView];
        [self.contentView addSubview:self.rightContentView];
        [self.contentView addSubview:bottomSeparateLineView];
    }
    return self;
}

- (void)setValuesWithCellItem:(KKCaseTypeCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.iconImageView.image = [UIImage imageNamed:@"icon_green_law"];
    
    KKCaseTypeItem *caseTypeItem = cellItem.rawObject;
    if (!caseTypeItem || ![caseTypeItem isKindOfClass:[KKCaseTypeItem class]]) {
        return;
    }
    self.titleLabel.text = caseTypeItem.name;
    self.iconImageView.image = [self iconImageForTag:caseTypeItem.type];
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
}



#pragma mark -
#pragma mark Actions 

- (void)enterButtonClick:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkCaseTypeMoreInfoPressed:)];
}

- (UIImage *)iconImageForTag:(KKCaseType)tag {
    switch (tag) {
        case KKCaseTypeTrademark:
            return [UIImage imageNamed:@"icon_green_trademark"];
            break;
        case KKCaseTypeCopyright:
            return [UIImage imageNamed:@"icon_green_copyright"];
            break;
        case KKCaseTypePatent:
            return [UIImage imageNamed:@"icon_green_lamp"];
            break;
        case KKCaseTypeLegal:
            return [UIImage imageNamed:@"icon_green_law"];
            break;
        default:
            break;
    }
    return [UIImage imageNamed:@"icon_green_law"];
}
@end




