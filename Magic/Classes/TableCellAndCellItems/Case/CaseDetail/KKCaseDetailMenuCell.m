//
//  KKCaseDetailMenuCell.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseDetailMenuCell.h"
#import "KKCaseDetailMenuCellItem.h"
#import "KKProfileOneButton.h"
#import "KKCaseFieldManager.h"

@implementation KKCaseDetailMenuCell


#pragma mark -
#pragma mark Init

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.seperatorLine.left = 0;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        CGFloat button_width = [UIDevice screenWidth]/(KKCaseDetailMenuTagTypeCount - 1);
        CGFloat button_height = kCaseDetailMenuCell_height;
        
        for (int tag = KKCaseDetailMenuTagTypeChat; tag < KKCaseDetailMenuTagTypeCount; tag ++) {
            KKProfileOneButton *oneButton = [[KKProfileOneButton alloc] initWithFrame:CGRectMake((tag - 1) * button_width, 0, button_width, button_height)];
            oneButton.iconImageView.image = [self iconImageForTag:tag];
            
            CGFloat imageView_width = 20;
            CGFloat imageView_marginTop = 20;
            oneButton.iconImageView.frame = CGRectMake((oneButton.frame.size.width - imageView_width)/2, imageView_marginTop, imageView_width, imageView_width);
            
            oneButton.button.tag = tag;
            [oneButton.button addTarget:self action:@selector(oneButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            NSString *title = [[KKCaseFieldManager getInstance] titleForCaseDetailMenuType:tag];
            oneButton.titleLabel.text = title;
            
            UIView *separateLineView = [[UIView alloc] initWithFrame:CGRectMake(oneButton.right, 10, 1, button_height - 20)];
            separateLineView.backgroundColor = [UIColor YYLineColor];
            if (tag < (KKCaseDetailMenuTagTypeCount - 1)) {
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
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkCaseDetailMenuButtonPressed:)];
}

- (UIImage *)iconImageForTag:(KKCaseDetailMenuTagType)tag {
    switch (tag) {
        case KKCaseDetailMenuTagTypeCall:
            return [UIImage imageNamed:@"icon_gray_middle_phone"];
            break;
        case KKCaseDetailMenuTagTypeChat:
            return [UIImage imageNamed:@"icon_gray_middle_message"];
        default:
            break;
    }
    return [UIImage imageNamed:@"icon_gray_list2"];
}

@end
