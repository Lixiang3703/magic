//
//  DDCDataSource.m
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDCollectionDataSource.h"
#import "DDBaseCollectionCellItem.h"

@interface DDCollectionDataSource ()


@end

@implementation DDCollectionDataSource

- (instancetype)init {
    self = [super init];
    if (self) {
        self.cellItems = [NSMutableArray array];
    }
    return self;
}

#pragma mark -
#pragma mark Logic
- (BOOL)isEmpty {
    return [self.cellItems count] == 0;
}

- (NSUInteger)cellItemsCount {
    return [self.cellItems count];
}

- (DDBaseCollectionCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath {
    return [self.cellItems objectAtSafeIndex:indexPath.row];
}

- (DDBaseCollectionCellItem *)cellItemForRow:(NSUInteger)row {
    return [self.cellItems objectAtSafeIndex:row];
}

- (DDBaseCollectionCellItem *)topCellItem {
    return [self.cellItems firstObject];
}

- (DDBaseCollectionCellItem *)lastCellItem {
    return [self.cellItems lastObject];
}

- (id)firstCellItemForClass:(Class)cellItemClass {
    __block id resObject = nil;
    [self.cellItems enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:cellItemClass]) {
            resObject = obj;
            *stop = YES;
        }
    }];
    return resObject;
}

- (id)lastCellItemForClass:(Class)cellItemClass {
    id resObect = nil;
    for (id obj in [self.cellItems reverseObjectEnumerator]) {
        if ([obj isKindOfClass:cellItemClass]) {
            resObect = obj;
            break;
        }
    }
    return resObect;
}

- (BOOL)containsCellItem:(DDBaseCollectionCellItem *)cellItem {
    return [self.cellItems containsObject:cellItem];
}

- (void)addCellItem:(DDBaseCollectionCellItem *)cellItem {
    [self.cellItems addSafeObject:cellItem];
}

- (void)addCellItems:(NSArray *)cellItems {
    [self.cellItems addObjectsFromArray:cellItems];
}

- (void)removeCellItem:(DDBaseCollectionCellItem *)cellItem {
    [self.cellItems removeObject:cellItem];
}

- (void)removeCellItems:(NSArray *)cellItems {
    [self.cellItems removeObjectsInArray:cellItems];
}

- (void)removeCellItemAtIndex:(NSUInteger)index {
    if ([self.cellItems count] > index) {
        [self.cellItems removeObjectAtIndex:index];
    }
}

- (void)insertCellItem:(DDBaseCollectionCellItem *)cellItem atIndex:(NSUInteger)index {
    [self.cellItems insertSafeObject:cellItem atIndex:index];
}

- (void)extendCellItems:(NSArray *)cellItems {
    [self.cellItems addObjectsFromArray:cellItems];
}

- (void)insertTopCellItems:(NSArray *)cellItems {
    NSMutableArray *tmpCellItems = [cellItems mutableCopy];
    [tmpCellItems addObjectsFromArray:self.cellItems];
    [self.cellItems removeAllObjects];
    [self.cellItems addObjectsFromArray:tmpCellItems];
}

- (NSUInteger)rowIndexForCellItem:(DDBaseCollectionCellItem *)cellItem {
    return [self.cellItems indexOfObject:cellItem];
}

- (void)clear {
    [self.cellItems removeAllObjects];
}

- (void)trim {
    DDBaseCollectionCellItem *cellItem = nil;
    
    //  Trim Last
    cellItem = [self lastCellItem];
    while (cellItem.isOptional) {
        [self removeCellItem:cellItem];
        cellItem = [self lastCellItem];
    }
    
    //  Trim Top
    cellItem = [self topCellItem];
    while (cellItem.isOptional) {
        [self removeCellItem:cellItem];
        cellItem = [self topCellItem];
    }
}


@end
