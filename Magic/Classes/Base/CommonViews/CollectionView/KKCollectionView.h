//
//  KKCollectionView.h
//  Link
//
//  Created by Lixiang on 14/11/6.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDCollectionView.h"
#import "DDBaseCollectionViewFlowLayout.h"
#import "DDCollectionView.h"
#import "DDCollectionDataSource.h"
#import "DDBaseCollectionCellItem.h"
#import "DDBaseCollectionCell.h"

@interface KKCollectionView : DDCollectionView<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** Images */
@property (nonatomic, retain) NSDate *lastDateOfLoadingImages;

- (void)loadImagesForOnscreenRows;
- (void)delayLoadImagesForOnscreenRows;
- (void)delayLoadImagesForOnscreenRowsAfter:(NSTimeInterval)delay;

/** DataSource */
@property (nonatomic, strong) DDCollectionDataSource *collectionDataSource;

- (void)generateDataSource;

/** Layout */
@property (nonatomic, readonly) UICollectionViewLayout *defaultLayout;

/** cell selection */
- (void)cellDidSelectWithCollectionView:(UICollectionView *)collectionView cellItem:(DDBaseCollectionCellItem *)cellItem cell:(DDBaseCollectionCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
