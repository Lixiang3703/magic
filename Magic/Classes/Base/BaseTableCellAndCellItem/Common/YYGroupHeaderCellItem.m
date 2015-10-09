//
//  YYGroupHeaderCellItem.m
//  Wuya
//
//  Created by Tong on 20/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

@implementation YYGroupHeaderCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.defaultWhiteBgColor = NO;
    self.selectable = NO;
    self.seperatorLineHidden = YES;
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}

+ (YYGroupHeaderCellItem *)groupHeaderCellItemForModifyInfoWithTitle:(NSString *)tiltle {
    YYGroupHeaderCellItem *groupHeaderCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_MarginH title:tiltle];
    groupHeaderCellItem.seperatorLineHidden = NO;
    groupHeaderCellItem.cellWillDisplayBlock = ^(YYGroupHeaderCellItem *cellItem, YYGroupHeaderCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        cell.seperatorLine.left = 0;
        cell.seperatorLine.width = cell.width;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    };
    groupHeaderCellItem.cellLayoutBlock = ^(YYGroupHeaderCell *cell) {
        cell.textLabel.left = kUI_TableView_Common_Margin;
    };
    return groupHeaderCellItem;
}

@end
