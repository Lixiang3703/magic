//
//  DDMoreCollectionCellItem.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDMoreCollectionCellItem.h"
#import "DDMoreCollectionCell.h"
#import "DDBaseCollectionViewController.h"

@implementation DDMoreCollectionCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.showSpinner = YES;
    self.selectable = NO;
    self.optional = YES;
    
    self.cellWillDisplayBlock = ^(DDMoreCollectionCellItem *cellItem, id cell, NSIndexPath *indexPath, DDBaseCollectionViewController *viewController) {
        if (!cellItem.didSendLoadingMoreMessage) {
            [viewController collectionViewWillLoadingMore];
        }
        cellItem.didSendLoadingMoreMessage = YES;
    };
}


@end
