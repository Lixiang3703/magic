//
//  DDCollecitonViewController.m
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseCollectionViewController.h"

#import "DDSpinImageView.h"

#import "DDMoreCollectionCell.h"

#define kDDCollectionVC_Refresh_Trigger_Distance    (-64)


@interface DDBaseCollectionViewController () <DDMoreCollectionCellActions>

@property (nonatomic, strong) DDSpinImageView *refreshView;

/** Images */
@property (nonatomic, retain) NSDate *lastDateOfLoadingImages;

/** ContentOffset */
@property (nonatomic, assign) CGPoint lastContentOffset;

/** last drag down refresh date */
@property (nonatomic, copy) NSDate *lastDragDownRefreshDate;

@end

@implementation DDBaseCollectionViewController


- (void)dealloc{
    self.collectionView.delegate = nil;
    self.collectionView.dataSource = nil;
}


#pragma mark -
#pragma mark Accessors
- (void)setHasRefreshView:(BOOL)hasRefreshView {
    if (_hasRefreshView != hasRefreshView) {
        _hasRefreshView = hasRefreshView;
        
        if (hasRefreshView) {
            if (nil == self.refreshView) {
                self.refreshView = [[DDSpinImageView alloc] initWithFrame:CGRectMake(-60, 0, 50, 50)];
                self.refreshView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin;
            }
            
            [self.view addSubview:self.refreshView];
        } else {
            [self.refreshView removeFromSuperview];
            self.refreshView = nil;
        }
    }
}

- (DDCollectionDataSource *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [[DDCollectionDataSource alloc] init];
    }
    return _dataSource;
}

- (UICollectionViewLayout *)defaultLayout {
    return [[DDBaseCollectionViewFlowLayout alloc] init];
}

#pragma mark -
#pragma mark Init
- (void)initSettings {
    [super initSettings];
    
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];

    
    //  CollectionView
    self.collectionView = [[DDCollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.defaultLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.alwaysBounceHorizontal = YES;
    
    [self.view addSubview:self.collectionView];
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //  DataSource
    if ([self.dataSource isEmpty]) {
        [self generateDataSource];
        [self.collectionView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark DataSource
- (DDBaseCollectionCellItem *)cellItemWithIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView {
    return [self.dataSource cellItemForIndexPath:indexPath];
}

- (void)generateDataSource {

}


#pragma mark -
#pragma mark Images
// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows {
    return;
    if (nil != self.lastDateOfLoadingImages && [[NSDate date] timeIntervalSinceDate:self.lastDateOfLoadingImages] < 0.28f) {
        //  Load frequently
        return;
    }
    self.lastDateOfLoadingImages = [NSDate date];
    if ([self.dataSource cellItemsCount] > 0) {
        
        
        NSArray *visiblePaths = [self.collectionView indexPathsForVisibleItems];
        for (NSIndexPath *indexPath in visiblePaths) {
            DDBaseCollectionCellItem *cellItem = [self cellItemWithIndexPath:indexPath collectionView:self.collectionView];
            DDBaseCollectionCell *cell = (DDBaseCollectionCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
            
            if ([cell conformsToProtocol:@protocol(DDCellImageShowing)]) {
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
    return [self.dataSource cellItemsCount];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    DDBaseCollectionCellItem *cellItem = [self cellItemWithIndexPath:indexPath collectionView:collectionView];
    
    [self.collectionView registerClass:cellItem.cellClass forCellWithReuseIdentifier:cellItem.cellIdentifier];
    
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
#pragma mark Cell Selection Actions
- (void)cellDidSelectWithCollectionView:(UICollectionView *)collectionView cellItem:(DDBaseCollectionCellItem *)cellItem cell:(DDBaseCollectionCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self.view.window findFirstResponder] resignFirstResponder];
}

#pragma mark -
#pragma mark CollectionView Common
- (void)collectionViewWillReload {

}

- (void)collectionViewWillLoadingMore {

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

//- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
////    DDLog(@"%@", indexPath);
//}

#pragma mark -
#pragma mark UICollectionViewDelegateFlowLayout


#pragma mark -
#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging) {
        CGFloat contentOffsetYDelta = fabs(scrollView.contentOffset.y - self.lastContentOffset.y);
        CGFloat contentOffsetXDelta = fabs(scrollView.contentOffset.x - self.lastContentOffset.x);
        if (contentOffsetYDelta < 0.6 || contentOffsetXDelta < 0.6) {
            [self loadImagesForOnscreenRows];
        }
        self.lastContentOffset = scrollView.contentOffset;
    }
    
    //  Handle RefreshView
    if (self.hasRefreshView) {
        CGFloat left = - 7.0 / 6 * scrollView.contentOffset.x - 60;
        left = MIN(left, 10);
        left = MAX(-60, left);
        
        if (!self.refreshView.isAnimating) {
            self.refreshView.top = self.collectionView.top;
            self.refreshView.left = left;
            
            if (scrollView.contentOffset.x < kDDCollectionVC_Refresh_Trigger_Distance || scrollView.contentOffset.y < kDDCollectionVC_Refresh_Trigger_Distance) {
                [self startSpinRefreshView];
            }
        }
    }

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffset = scrollView.contentOffset;
}

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self loadImagesForOnscreenRows];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self loadImagesForOnscreenRows];
}


#pragma mark -
#pragma mark Refresh

- (void)startSpinRefreshView {
    [self.refreshView startSpinAnimation];
    
    __weak typeof(self)weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf collectionViewWillReload];
    });
}

- (void)stopSpinRefreshView {
    if (self.collectionView.contentOffset.x < -60) {
        [self.collectionView setContentOffset:CGPointZero animated:YES];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        self.refreshView.left = -60;
    } completion:^(BOOL finished) {
        [self.refreshView stopSpinAnimation];
    }];
}

- (void)dragDownRefresh {
    if (!self.hasRefreshView) {
        return;
    }
    
    if (nil != [self lastDragDownRefreshDate]) {
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastDragDownRefreshDate];
        
        if (timeInterval < 0.3f) {
            return;
        }
    }
    
    self.lastDragDownRefreshDate = [NSDate date];
    
    
    [self.collectionView setContentOffset:CGPointMake(kDDCollectionVC_Refresh_Trigger_Distance - 1, 0) animated:YES];
    
}

#pragma mark -
#pragma mark DDMoreCollectionCellActions

- (void)moreCollectionCellDidAppear:(NSDictionary *)info {
    [self collectionViewWillLoadingMore];
}

@end
