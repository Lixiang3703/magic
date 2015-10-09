//
//  YYSingleImageViewCell.m
//  Wuya
//
//  Created by lilingang on 14-7-9.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYSingleImageViewCell.h"
#import "YYSingleImageViewCellItem.h"

@interface YYSingleImageViewCell ()

@property (nonatomic, strong) UIImageView *singleImageView;

@end

@implementation YYSingleImageViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.singleImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.singleImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.singleImageView.clipsToBounds = YES;
        
        self.bottomSepareateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], kUI_TableView_Common_Margin)];
        self.bottomSepareateView.backgroundColor = [UIColor YYLineColor];
        
        [self.contentView addSubview:self.singleImageView];
        [self.contentView addSubview:self.bottomSepareateView];
    }
    return self;
}


- (void)setValuesWithCellItem:(YYSingleImageViewCellItem *)cellItem{
    [super setValuesWithCellItem:cellItem];
    if (cellItem.singleImageName) {
        self.singleImageView.image = [UIImage imageNamed:cellItem.singleImageName];
    } else {
        self.singleImageView.image = [UIImage imageNamed:@"topic_banner"];
    }
    
    self.singleImageView.frame = CGRectMake(0, 0, [UIDevice screenWidth], cellItem.imageHeight);
    self.bottomSepareateView.top = self.singleImageView.bottom;
}

@end
