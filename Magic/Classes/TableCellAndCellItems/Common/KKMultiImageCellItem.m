//
//  KKMultiImageCellItem.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKMultiImageCellItem.h"

@implementation KKMultiImageCellItem

- (void)initSettings {
    [super initSettings];
    
    self.cellHeight = kMultiImageCell_Relative_Height * [UIDevice screenWidth] / 320;
}


@end
