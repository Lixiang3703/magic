//
//  DDBaseCollectionCellItem.m
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseCollectionCellItem.h"

@interface DDBaseCollectionCellItem ()

@end

@implementation DDBaseCollectionCellItem


#pragma mark -
#pragma mark Accessors


#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    return [self initWithRawItem:nil];
}

- (instancetype)initWithRawItem:(DDBaseItem *)item {
    self = [super init];
    if (self) {
        [self initSettings];
        self.rawObject = item;
        
    }
    return self;
}

- (void)initSettings {
    self.cellHeight = 200;
    self.cellWidth = 200;
    //  Remove "Item" from DDBaseCellItem
    NSString *cellClassName = [[[self class] description] substringByRemovingLastIndex:4];
    self.cellClass = NSClassFromString(cellClassName);
    self.cellIdentifier = [[self class] description];
    
    self.selectable = YES;
    
    self.userInteractionEnabled = YES;
}


+ (instancetype)cellItem {
    DDBaseCollectionCellItem *cellItem = [[[self class] alloc] init];
    return cellItem;
}


@end
