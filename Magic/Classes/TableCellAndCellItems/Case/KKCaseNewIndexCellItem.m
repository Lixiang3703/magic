//
//  KKCaseNewIndexCellItem.m
//  Magic
//
//  Created by lixiang on 15/7/4.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseNewIndexCellItem.h"

@implementation KKCaseNewIndexCellItem

- (void)initSettings {
    [super initSettings];
    
    self.seperatorLineHidden = YES;
    CGFloat buttonWidth = ([UIDevice screenWidth] - 2*kCaseNewIndexOneButton_marginLeft)/3;
    CGFloat buttonHeight = buttonWidth * kCaseNewIndexOneButton_heightRatio;
    
    self.cellHeight = buttonHeight * 2 + 2*kCaseNewIndexOneButton_marginTop;
}


@end
