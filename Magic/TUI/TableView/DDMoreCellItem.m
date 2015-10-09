//
//  DDMoreCellItem.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDMoreCellItem.h"
#import "DDMoreCell.h"

@implementation DDMoreCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];

    self.showSpinner = YES;
    self.selectable = NO;
    self.optional = YES;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
    self.cellAccessoryType = UITableViewCellAccessoryNone;
    
    
    self.cellWillDisplayBlock = ^(DDMoreCellItem *cellItem, id cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        if (!cellItem.didSendLoadingMoreMessage) {
            [viewController tableViewWillLoadingMore];
        }
        cellItem.didSendLoadingMoreMessage = YES;
    };
}


@end
