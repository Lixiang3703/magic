//
//  KKProfileIntroCellItem.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKProfileIntroCellItem.h"

@implementation KKProfileIntroCellItem

- (void)initSettings {
    [super initSettings];
    
    self.seperatorLineHidden = YES;
    self.cellHeight = kProfileIntroCell_Height;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    
    self.selectable = NO;
}

@end
