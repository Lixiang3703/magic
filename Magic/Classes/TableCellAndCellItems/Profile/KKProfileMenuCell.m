//
//  KKProfileMenuCell.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKProfileMenuCell.h"

#import "KKProfileOneButton.h"
#import "KKProfileMenuCellItem.h"
#import "KKCaseFieldManager.h"

@interface KKProfileMenuCell()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation KKProfileMenuCell

#pragma mark -
#pragma mark Accessor

- (NSMutableArray *)buttonArray {
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return _buttonArray;
}


#pragma mark -
#pragma mark Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        CGFloat button_width = [UIDevice screenWidth]/(KKProfileMenuTagTypeCount - 1);
        CGFloat button_height = kProfileMenuCellItem_height - 10;
        
        for (int tag = KKProfileMenuTagTypeNeedPay; tag < KKProfileMenuTagTypeCount; tag ++) {
            KKProfileOneButton *oneButton = [[KKProfileOneButton alloc] initWithFrame:CGRectMake((tag - 1) * button_width, 0, button_width, button_height)];
            oneButton.iconImageView.image = [self iconImageForTag:tag];
            oneButton.button.tag = tag;
            [oneButton.button addTarget:self action:@selector(oneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *title = [[KKCaseFieldManager getInstance] titleForProfileMenuType:tag];
            oneButton.titleLabel.text = title;
            
            UIView *separateLineView = [[UIView alloc] initWithFrame:CGRectMake(oneButton.right, 10, 1, button_height - 20)];
            separateLineView.backgroundColor = [UIColor YYLineColor];
            if (tag < (KKProfileMenuTagTypeCount - 1)) {
                [self.contentView addSubview:separateLineView];
            }
            
            [self.contentView addSubview:oneButton];
        }
        
    }
    return self;
}

- (void)setValuesWithCellItem:(DDBaseCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
}

- (void)showImagesWithCellItem:(id)cellItem {
    [super showImagesWithCellItem:cellItem];
    
}

#pragma mark -
#pragma mark Actions

- (void)oneButtonClicked:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkProfileMenuButtonPressed:)];
}

- (UIImage *)iconImageForTag:(KKProfileMenuTagType)tag {
    switch (tag) {
        case KKProfileMenuTagTypeNeedPay:
            return [UIImage imageNamed:@"icon_gray_middle_dollar"];
            break;
        case KKProfileMenuTagTypeOver:
            return [UIImage imageNamed:@"icon_gray_middle_list"];
            break;
        case KKProfileMenuTagTypeShare:
            return [UIImage imageNamed:@"icon_gray_middle_share"];
            break;
        default:
            break;
    }
    return [UIImage imageNamed:@"icon_gray_middle_list"];
}

@end



