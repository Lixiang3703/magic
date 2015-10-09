//
//  KKSingleBigImageCellItem.m
//  Link
//
//  Created by Lixiang on 14/11/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKSingleBigImageCellItem.h"

@implementation KKSingleBigImageCellItem

- (void)initSettings {
    [super initSettings];
    self.cellHeight = kUI_ImageSize_Avatar_Big + 2*kUI_TableView_Common_Margin;
}

- (void)setRawObject:(id)rawObject {
    [super setRawObject:rawObject];
    
}

@end
