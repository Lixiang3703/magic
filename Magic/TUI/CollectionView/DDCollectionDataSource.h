//
//  DDCDataSource.h
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DDBaseCollectionCellItem;

@interface DDCollectionDataSource : NSObject

@property (nonatomic, strong) NSMutableArray *cellItems;

- (BOOL)isEmpty;
- (NSUInteger)cellItemsCount;

- (DDBaseCollectionCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath;
- (DDBaseCollectionCellItem *)cellItemForRow:(NSUInteger)row;
- (DDBaseCollectionCellItem *)topCellItem;
- (DDBaseCollectionCellItem *)lastCellItem;

- (id)firstCellItemForClass:(Class)cellItemClass;
- (id)lastCellItemForClass:(Class)cellItemClass;

- (BOOL)containsCellItem:(DDBaseCollectionCellItem *)cellItem;
- (void)addCellItem:(DDBaseCollectionCellItem *)cellItem;
- (void)addCellItems:(NSArray *)cellItems;
- (void)removeCellItem:(DDBaseCollectionCellItem *)cellItem;
- (void)removeCellItems:(NSArray *)cellItems;
- (void)removeCellItemAtIndex:(NSUInteger)index;
- (void)insertCellItem:(DDBaseCollectionCellItem *)cellItem atIndex:(NSUInteger)index;
- (void)extendCellItems:(NSArray *)cellItems;
- (void)insertTopCellItems:(NSArray *)cellItems;

- (NSUInteger)rowIndexForCellItem:(DDBaseCollectionCellItem *)cellItem;

- (void)clear;
- (void)trim;

@end
