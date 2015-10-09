//
//  DDCollecitonViewController.h
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDBaseCollectionViewFlowLayout.h"
#import "DDCollectionView.h"
#import "DDCollectionDataSource.h"
#import "DDBaseCollectionCellItem.h"
#import "DDBaseCollectionCell.h"

@interface DDBaseCollectionViewController : DDBaseViewController <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/** UICollectionView */
@property (nonatomic, strong) DDCollectionView *collectionView;

/** Refresh */
@property (nonatomic, assign) BOOL hasRefreshView;
- (void)startSpinRefreshView;
- (void)stopSpinRefreshView;

/** DataSource */
@property (nonatomic, strong) DDCollectionDataSource *dataSource;
- (DDBaseCollectionCellItem *)cellItemWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;
- (void)generateDataSource;


/** Layout */
@property (nonatomic, readonly) UICollectionViewLayout *defaultLayout;

/** Selection */
- (void)cellDidSelectWithCollectionView:(UICollectionView *)collectionView cellItem:(DDBaseCollectionCellItem *)cellItem cell:(DDBaseCollectionCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/** Table View Delegate*/
- (void)collectionViewWillReload;
- (void)collectionViewWillLoadingMore;


/** Scroll */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


/** Refresh */
- (void)dragDownRefresh;


/** Images */
- (void)loadImagesForOnscreenRows;
- (void)delayLoadImagesForOnscreenRowsAfter:(NSTimeInterval)delay;
- (void)delayLoadImagesForOnscreenRows;


@end
