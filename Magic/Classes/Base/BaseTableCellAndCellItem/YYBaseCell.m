//
//  YYBaseCell.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseCell.h"
#import "YYBaseCellItem.h"

@implementation YYBaseCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //  SeperatorLine
        self.seperatorLine = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.height - 1, self.width, 1)];
        self.seperatorLine.autoresizesSubviews = UIViewAutoresizingFlexibleTopMargin;
        self.seperatorLine.image = [UIImage yyImageWithColor:[UIColor YYLineColor]];

//        self.seperatorLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.seperatorLine.width = [UIDevice screenWidth];
        
        //  Default seperatorLine left
        self.seperatorLine.left = kUI_TableView_Common_Margin;
        self.seperatorLine.width = [UIDevice screenWidth] - kUI_TableView_Common_Margin;
        
        //  Default Operation Container
        self.operationContainerView.width = 70;
        self.defaultOperationButton = [[UIButton alloc] initWithFrame:self.operationContainerView.bounds];
        [self.defaultOperationButton addTarget:self tapAction:@selector(defaultOperationButtonPressed:)];
        
        self.defaultOperationButton.backgroundColor = [UIColor YYGrayColor];
        self.defaultOperationButton.titleLabel.font = [UIFont YYFontLarge];
        self.defaultOperationButton.titleLabel.numberOfLines = 0;
        
        //  z-order
        [self.defaultOperationButton fullfillPrarentView];
        [self.operationContainerView addSubview:self.defaultOperationButton];
        
        [self addSubview:self.seperatorLine];
    }
    return self;
}

- (void)firstAssignValuesSettingsWithCellItem:(YYBaseCellItem *)cellItem {
    [super firstAssignValuesSettingsWithCellItem:cellItem];
    
    if (cellItem.seperatorLineFat) {
        self.seperatorLine.height = kUI_TableView_SeperatorLine_Fat;
    } else {
        self.seperatorLine.height = 0.5;
    }

}

- (void)setValuesWithCellItem:(YYBaseCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    
    //  Seperator Line
    self.seperatorLine.bottom = cellItem.cellHeight;
    self.seperatorLine.hidden = cellItem.seperatorLineHidden;
    
}

#pragma mark -
#pragma mark Buttons
- (void)defaultOperationButtonPressed:(UIButton *)button {
    [self.ddTableView cellActionWithCell:self control:button userInfo:nil selector:@selector(yycellBaseDefaultOperationButtonPressedWithInfo:)];
}


@end
