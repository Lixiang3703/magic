//
//  DDEmptyCellItem.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDEmptyCellItem.h"

@implementation DDEmptyCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.tip = _(@"这里什么都没有");
    self.optional = YES;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
}

@end
