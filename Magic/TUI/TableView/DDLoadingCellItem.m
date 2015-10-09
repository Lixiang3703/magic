//
//  DDLoadingCellItem.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDLoadingCellItem.h"

@implementation DDLoadingCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.optional = YES;
    self.selectable = NO;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
}

@end
