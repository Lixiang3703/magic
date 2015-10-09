//
//  DDTransparentCellItem.m
//  Wuya
//
//  Created by Tong on 25/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTransparentCellItem.h"

@implementation DDTransparentCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.optional = YES;
    self.selectable = NO;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    self.userInteractionEnabled = NO;
}


@end
