//
//  DDDataSource.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDBaseCellItem;

@interface DDDataSource : NSObject

@property (nonatomic, strong) NSMutableArray *cellItems;

- (BOOL)isEmpty;
- (NSUInteger)cellItemsCount;

- (DDBaseCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath;
- (DDBaseCellItem *)cellItemForRow:(NSUInteger)row;
- (DDBaseCellItem *)topCellItem;
- (DDBaseCellItem *)lastCellItem;

- (id)firstCellItemForClass:(Class)cellItemClass;
- (id)lastCellItemForClass:(Class)cellItemClass;

- (BOOL)containsCellItem:(DDBaseCellItem *)cellItem;
- (void)addCellItem:(DDBaseCellItem *)cellItem;
- (void)addCellItems:(NSArray *)cellItems;
- (void)removeCellItem:(DDBaseCellItem *)cellItem;
- (void)removeCellItems:(NSArray *)cellItems;
- (void)removeCellItemAtIndex:(NSUInteger)index;
- (void)insertCellItem:(DDBaseCellItem *)cellItem atIndex:(NSUInteger)index;
- (void)extendCellItems:(NSArray *)cellItems;
- (void)insertTopCellItems:(NSArray *)cellItems;

- (NSUInteger)rowIndexForCellItem:(DDBaseCellItem *)cellItem;

- (void)clear;
- (void)trim;
- (void)trimExcept:(Class)exceptClass;

- (CGFloat)totalCellHeiht;

@end
