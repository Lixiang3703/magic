//
//  KKDoubleImageCellItem.m
//  Magic
//
//  Created by lixiang on 15/6/3.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKDoubleImageCellItem.h"

@implementation KKDoubleImageCellItem

- (void)initSettings{
    [super initSettings];
    
    CGFloat imageWidth = [UIDevice screenWidth] / 2;
    
    self.cellHeight = imageWidth;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    
    self.seperatorLineHidden = YES;
    self.seperatorLineFat = NO;
    self.selectable = NO;
    
    self.separeteLine_width = 5;
    self.margin_left = 10;
    self.margin_right = 10;
    self.margin_bottom = 5;
    
    [self resetHeight];
}

- (void)resetHeight {
    CGFloat imageWidth = ([UIDevice screenWidth] - 1* self.separeteLine_width - self.margin_left - self.margin_right)/ 2;
    
    self.cellHeight = imageWidth + self.margin_bottom;
}


@end
