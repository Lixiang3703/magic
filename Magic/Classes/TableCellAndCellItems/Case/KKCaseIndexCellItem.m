//
//  KKCaseIndexCellItem.m
//  Magic
//
//  Created by lixiang on 15/5/17.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseIndexCellItem.h"

static const CGFloat margin = kCaseIndexOneButton_margin;
static const CGFloat marginLeft = kCaseIndexOneButton_marginLeft;
static const CGFloat marginTop = kCaseIndexOneButton_marginTop;

@implementation KKCaseIndexCellItem

- (void)initSettings {
    [super initSettings];
    
    self.seperatorLineHidden = YES;
    CGFloat buttonWidth = ([UIDevice screenWidth] - margin - 2*marginLeft)/2;
    CGFloat buttonHeight = buttonWidth * 0.618;
    
    self.cellHeight = marginTop + buttonHeight +margin+ buttonHeight +margin + buttonHeight + marginTop;
}

@end
