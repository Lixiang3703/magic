//
//  DDPlaceholderCellItem.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDPlaceholderCellItem.h"

@implementation DDPlaceholderCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.optional = YES;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    
    self.selectable = NO;
}

@end
