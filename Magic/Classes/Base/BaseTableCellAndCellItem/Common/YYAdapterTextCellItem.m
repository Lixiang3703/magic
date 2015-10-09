//
//  YYAdapterTextCellItem.m
//  Wuya
//
//  Created by lilingang on 14-6-27.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYAdapterTextCellItem.h"

@implementation YYAdapterTextCellItem

- (void)initSettings{
    [super initSettings];
    
    self.defaultWhiteBgColor = NO;
    self.seperatorLineHidden = YES;
    
    self.selectable = NO;
}


- (void)setRawObject:(id)rawObject{
    [super setRawObject:rawObject];
    
    if ([rawObject isKindOfClass:[NSString class]]) {
        CGSize tipTitleSize = [rawObject sizeWithThemeUIType:kThemeFILightGrayLabel constrainedWidth:[DDRuler screenWidth]];
        self.cellHeight = tipTitleSize.height + 2*kUI_TableView_Common_Margin;
    }
}
@end
