//
//  KKAboutTopCellItem.m
//  Magic
//
//  Created by lixiang on 15/6/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKAboutTopCellItem.h"

@implementation KKAboutTopCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    self.cellStyle = UITableViewCellStyleValue1;
    
    self.seperatorLineHidden = YES;
    
    self.cellHeight = 200;
}

- (void)setInfoStr:(NSString *)infoStr {
    if (_infoStr != infoStr) {
        _infoStr = [infoStr copy];
    }
    
    CGSize infoSize = [infoStr boundingRectWithSize:CGSizeMake([UIDevice screenWidth] - 30, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    
    self.infoHeight = infoSize.height *1.3;
    
    self.cellHeight = 200 + self.infoHeight;
    
}

@end
