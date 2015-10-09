//
//  YYButtonCellItem.m
//  Wuya
//
//  Created by lilingang on 14-6-27.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYButtonCellItem.h"

@implementation YYButtonCellItem

#pragma mark -
#pragma mark  Life Cycle

- (void)initSettings{
    [super initSettings];
    
    self.defaultWhiteBgColor = NO;
    self.seperatorLineHidden = YES;
    
    self.selectable = NO;
}
@end
