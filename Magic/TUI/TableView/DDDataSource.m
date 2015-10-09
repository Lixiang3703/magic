//
//  DDDataSource.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDDataSource.h"

@interface DDDataSource ()


@end


@implementation DDDataSource

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

- (DDBaseCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath {
    return [self.cellItems objectAtSafeIndex:indexPath.row];
}

- (DDBaseCellItem *)cellItemForRow:(NSUInteger)row {
    return [self.cellItems objectAtSafeIndex:row];
}

- (DDBaseCellItem *)topCellItem {
    return [self.cellItems firstObject];
}

- (DDBaseCellItem *)lastCellItem {
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

- (BOOL)containsCellItem:(DDBaseCellItem *)cellItem {
    return [self.cellItems containsObject:cellItem];
}

- (void)addCellItem:(DDBaseCellItem *)cellItem {
    [self.cellItems addSafeObject:cellItem];
}

- (void)addCellItems:(NSArray *)cellItems {
    [self.cellItems addObjectsFromArray:cellItems];
}

- (void)removeCellItem:(DDBaseCellItem *)cellItem {
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

- (void)insertCellItem:(DDBaseCellItem *)cellItem atIndex:(NSUInteger)index {
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

- (NSUInteger)rowIndexForCellItem:(DDBaseCellItem *)cellItem {
    return [self.cellItems indexOfObject:cellItem];
}

- (void)clear {
    [self.cellItems removeAllObjects];
}

- (void)trim {
    DDBaseCellItem *cellItem = nil;
    
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

- (void)trimExcept:(Class)exceptClass {
    DDBaseCellItem *cellItem = nil;
    
    //  Trim Last
    cellItem = [self lastCellItem];
    while (cellItem.isOptional && ![cellItem isKindOfClass:exceptClass]) {
        [self removeCellItem:cellItem];
        cellItem = [self lastCellItem];
    }
    
    //  Trim Top
    cellItem = [self topCellItem];
    while (cellItem.isOptional && ![cellItem isKindOfClass:exceptClass]) {
        [self removeCellItem:cellItem];
        cellItem = [self topCellItem];
    }
}

- (CGFloat)totalCellHeiht {
    __block CGFloat totalHeight = 0;
    [self.cellItems enumerateObjectsUsingBlock:^(DDBaseCellItem *obj, NSUInteger idx, BOOL *stop) {
        totalHeight += obj.cellHeight;
    }];
    
    return totalHeight;
}

@end
