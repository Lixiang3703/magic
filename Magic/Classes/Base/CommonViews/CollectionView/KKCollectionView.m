//
//  KKCollectionView.m
//  Link
//
//  Created by Lixiang on 14/11/6.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKCollectionView.h"

@implementation KKCollectionView

#pragma mark -
#pragma mark Accessor

- (DDCollectionDataSource *)collectionDataSource {
    if (nil == _collectionDataSource) {
        _collectionDataSource = [[DDCollectionDataSource alloc] init];
    }
    return _collectionDataSource;
}

#pragma mark -
#pragma mark init

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceHorizontal = YES;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.alwaysBounceHorizontal = YES;
    }
    return self;
}

#pragma mark -
#pragma mark DataSource
- (DDBaseCollectionCellItem *)cellItemWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    return [self.collectionDataSource cellItemForIndexPath:indexPath];
}

- (void)generateDataSource {
    
}

#pragma mark -
#pragma mark Images
// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows {
    
    if (nil != self.lastDateOfLoadingImages && [[NSDate date] timeIntervalSinceDate:self.lastDateOfLoadingImages] < 0.28f) {
        //  Load frequently
        return;
    }
    self.lastDateOfLoadingImages = [NSDate date];
    if ([self.collectionDataSource cellItemsCount] > 0) {
        for (int i = 0 ; i < [self.collectionDataSource cellItemsCount]; i ++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            
            DDBaseCollectionCellItem *cellItem = [self cellItemWithIndexPath:indexPath collectionView:self];
            DDBaseCollectionCell *cell = (DDBaseCollectionCell *)[self cellForItemAtIndexPath:indexPath];

            if ([cell conformsToProtocol:@protocol(DDBaseCollectionCellImageShowing)]) {
                [(id<DDCellImageShowing> )cell showImagesWithCellItem:cellItem];
            }
        }
    }
}

- (void)delayLoadImagesForOnscreenRowsAfter:(NSTimeInterval)delay {
    [self performSelector:@selector(loadImagesForOnscreenRows) withObject:nil afterDelay:delay];
}

- (void)delayLoadImagesForOnscreenRows {
    [self delayLoadImagesForOnscreenRowsAfter:0.3f];
}

#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.collectionDataSource cellItemsCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDBaseCollectionCellItem *cellItem = [self cellItemWithIndexPath:indexPath collectionView:collectionView];
    
    [self registerClass:cellItem.cellClass forCellWithReuseIdentifier:cellItem.cellIdentifier];
    
    DDBaseCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellItem.cellIdentifier forIndexPath:indexPath];
    
    
    if (cellItem.cellValuesWillSetBlock) {
        cellItem.cellValuesWillSetBlock(cellItem, cell, indexPath, self);
    }
    
    [cell setValuesWithCellItem:cellItem];
    
    if (cellItem.cellValuesDidSetBlock) {
        cellItem.cellValuesDidSetBlock(cellItem, cell, indexPath, self);
    }
    
    if (cellItem.cellWillDisplayBlock) {
        cellItem.cellWillDisplayBlock(cellItem, cell, indexPath, self);
    }
    
    return cell;
    
}

#pragma mark -
#pragma mark UICollectionViewDelegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DDBaseCollectionCellItem *cellItem = [self cellItemWithIndexPath:indexPath collectionView:collectionView];
    return cellItem.selectable;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DDBaseCollectionCellItem *cellItem = [self cellItemWithIndexPath:indexPath collectionView:collectionView];
    
    if (!cellItem.selectable) {
        return;
    }
    
    DDBaseCollectionCell *cell = (DDBaseCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    if ([cellItem isKindOfClass:[DDBaseCellItem class]] && [cell isKindOfClass:[DDBaseCell class]] && cellItem.cellSelectionBlock) {
        cellItem.cellSelectionBlock(cellItem, cell, indexPath, self);
    }
    
    if (cellItem.selectable) {
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    }
    
    
    [self cellDidSelectWithCollectionView:collectionView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
}

#pragma mark -
#pragma mark cell selection
- (void)cellDidSelectWithCollectionView:(UICollectionView *)collectionView cellItem:(DDBaseCollectionCellItem *)cellItem cell:(DDBaseCollectionCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
