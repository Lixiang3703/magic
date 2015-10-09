//
//  YYBaseCellItem.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseCellItem.h"

@implementation YYBaseCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    //  Default white bg color
    self.defaultWhiteBgColor = YES;
    
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    self.seperatorLineFat = NO;
}

@end
