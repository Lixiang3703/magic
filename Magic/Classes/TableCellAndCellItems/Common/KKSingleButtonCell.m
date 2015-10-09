//
//  KKSingleButtonCell.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKSingleButtonCell.h"
#import "KKSingleButtonCellItem.h"

@interface KKSingleButtonCell()

@property (nonatomic, strong) UIButton *button;

@end

@implementation KKSingleButtonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat button_MarginLeft = kUI_TableView_Common_Margin;
        CGFloat buttonWidth = [UIDevice screenWidth] - 2*button_MarginLeft;
        self.button = [[UIButton alloc] initWithFrame:CGRectMake(button_MarginLeft, kSingleButtonCell_button_marginTop, buttonWidth, kSingleButtonCell_button_height)];
        [self.button setBackgroundColor:[UIColor KKGreenColor]];
        self.button.layer.cornerRadius = 4.0f;
        self.button.clipsToBounds = YES;
        [self.button setTitle:@"立即支付" forState:UIControlStateNormal];
        
        [self.button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:self.button];
        
    }
    return self;
}

- (void)setValuesWithCellItem:(KKSingleButtonCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    if (cellItem.buttonColor) {
        [self.button setBackgroundColor:cellItem.buttonColor];
    }
    if (cellItem.buttonTitle) {
        [self.button setTitle:cellItem.buttonTitle forState:UIControlStateNormal];
    }
}

- (void)showImagesWithCellItem:(KKSingleButtonCellItem *)cellItem {
    [super showImagesWithCellItem:cellItem];
}

#pragma mark -
#pragma mark Actions

- (void)buttonPressed:(id)sender {
    [self.ddTableView cellActionWithCell:self control:sender userInfo:nil selector:@selector(kkSingleButtonPressed:)];
}

@end






