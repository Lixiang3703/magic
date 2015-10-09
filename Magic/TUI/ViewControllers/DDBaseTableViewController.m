//
//  DDBaseTableViewController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseTableViewController.h"
#import "DDSectionDataSource.h"
#import "DDMoreCell.h"


@interface DDBaseTableViewController () <DDMoreCellActions>

/** Group */
@property (nonatomic, readonly) BOOL group;

/** Images */
@property (nonatomic, retain) NSDate *lastDateOfLoadingImages;

/** ContentOffset */
@property (nonatomic, assign) CGFloat lastContentOffsetY;

/** last drag down refresh date */
@property (nonatomic, copy) NSDate *lastDragDownRefreshDate;

@end

@implementation DDBaseTableViewController

#pragma mark -
#pragma mark Group
- (BOOL)isGroupTableView {
    return self.tableView.style == UITableViewStyleGrouped;
}

- (DDDataSource *)dataSource {
    if (nil == _dataSource) {
        _dataSource = [[DDDataSource alloc] init];
    }
    return _dataSource;
}

#pragma mark -
#pragma mark Initialization
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super init];
    if (self) {
        self.tableViewStyle = style;
    }
    return self;
}

- (void)initSettings {
    [super initSettings];
}

#pragma mark -
#pragma mark Life cycle

- (void)dealloc{
    self.tableView.dataSource = nil;
    self.tableView.delegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //  View
    self.view.clipsToBounds = YES;
    
    //  TableView
    self.tableView = [[DDTableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //  UI Settings
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = 0;
    
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //  DataSource
    if ([self.dataSource isEmpty]) {
        [self generateDataSource];
        [self.tableView reloadData];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView.refreshControl.superview sendSubviewToBack:self.tableView.refreshControl];
}

#pragma mark -
#pragma mark Memory

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Data Source
- (DDBaseCellItem *)cellItemWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView {
    return [self.dataSource cellItemForIndexPath:indexPath];
}

- (void)generateDataSource {

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource cellItemsCount];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellItemWithIndexPath:indexPath tableView:tableView].cellHeight;
}

#pragma mark -
#pragma mark TableView Delegate
- (void)tableviewWillReload:(UIRefreshControl *)refreshControl {
    
}

- (void)tableViewWillLoadingMore {

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DDBaseCellItem *cellItem = [self cellItemWithIndexPath:indexPath tableView:tableView];
    
    DDBaseCell *cell = (DDBaseCell *)[tableView dequeueReusableCellWithIdentifier:cellItem.cellIdentifier];
    
    if (cell == nil) {
        cell = [[cellItem.cellClass alloc] initWithStyle:cellItem.cellStyle reuseIdentifier:cellItem.cellIdentifier];
    }
    
    if (cellItem.cellValuesWillSetBlock) {
        cellItem.cellValuesWillSetBlock(cellItem, cell, indexPath, self);
    }
    
    [cell setValuesWithCellItem:cellItem];
    
    if (cellItem.cellValuesDidSetBlock) {
        cellItem.cellValuesDidSetBlock(cellItem, cell, indexPath, self);
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDBaseCellItem *cellItem = [self cellItemWithIndexPath:indexPath tableView:tableView];
    
    if (!cellItem.selectable) {
        return;
    }
    
    DDBaseCell *cell = (DDBaseCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    if ([cellItem isKindOfClass:[DDBaseCellItem class]] && [cell isKindOfClass:[DDBaseCell class]] && cellItem.cellSelectionBlock) {
        cellItem.cellSelectionBlock(cellItem, cell, indexPath, self);
    }
    
    if (cellItem.selectable) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
    [self cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    DDBaseCellItem *cellItem = [self cellItemWithIndexPath:indexPath tableView:tableView];

    if ([UIDevice below7] && cellItem.defaultWhiteBgColor) {
        cell.backgroundColor = [UIColor whiteColor];
    }
    
    if (cellItem.cellWillDisplayBlock) {
        cellItem.cellWillDisplayBlock(cellItem, cell, indexPath, self);
    }
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    DDBaseCellItem *cellItem = [self cellItemWithIndexPath:indexPath tableView:tableView];
    return cellItem.selectable;
}

#pragma mark -
#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isDragging) {
        CGFloat contentOffsetYDelta = fabs(scrollView.contentOffset.y - self.lastContentOffsetY);
        if (contentOffsetYDelta < 0.6) {
            [self loadImagesForOnscreenRows];
        }
        self.lastContentOffsetY = scrollView.contentOffset.y;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.lastContentOffsetY = scrollView.contentOffset.y;
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

- (void)dragDownRefresh {
    if (!self.tableView.hasRefreshControl) {
        return;
    }
    
    if (nil != [self lastDragDownRefreshDate]) {
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:self.lastDragDownRefreshDate];
        
        if (timeInterval < 0.3f) {
            return;
        }
    }

    self.lastDragDownRefreshDate = [NSDate date];
    
    
    [self.tableView setContentOffset:CGPointMake(0, -64) animated:YES];

    
    __weak typeof(self)weakSelf = self;
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [weakSelf.tableView.refreshControl endRefreshing];
        [weakSelf.tableView.refreshControl beginRefreshing];
        [weakSelf tableviewWillReload:weakSelf.tableView.refreshControl];
    });

}

#pragma mark -
#pragma mark DDMoreCellActions
- (void)moreCellDidAppear:(NSDictionary *)info {
    [self tableViewWillLoadingMore];
}

#pragma mark -
#pragma mark Cell Selection Actions
- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [[self.view.window findFirstResponder] resignFirstResponder];
}

#pragma mark -
#pragma mark YYBaseCellActions
- (void)yycellBaseDefaultOperationButtonPressedWithInfo:(NSDictionary *)info {
    
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
    if ([self.dataSource cellItemsCount] > 0) {
        
        NSArray *visiblePaths = [self.tableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths) {
            
            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            DDBaseCellItem *cellItem = [self cellItemWithIndexPath:indexPath tableView:self.tableView];
            
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
#pragma mark Deleting
- (void)deleteCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self deleteCellItem:cellItem atIndexPath:indexPath withRowAnimation:animation completion:^{}];
}

- (void)deleteCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion {

    if ([self.dataSource cellItemsCount] <= indexPath.row) {
        return;
    }
    
    if ([self.dataSource containsCellItem:cellItem]) {
        [self.tableView beginUpdates];
        [self.dataSource removeCellItem:cellItem];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        [self.tableView endUpdates];
        
        __weak typeof(self)weakSelf = self;
        if (nil != completion) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (nil != completion) {
                    completion();
                }
                
                [weakSelf.tableView reloadData];
            });
        }
    }
}

#pragma mark -
#pragma mark Insert
- (void)insertCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation {
    [self insertCellItem:cellItem atIndexPath:indexPath withRowAnimation:animation completion:^{}];
}

- (void)insertCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion {

    if ([self.dataSource cellItemsCount] < indexPath.row) {
        return;
    }
    
    
    [self.tableView beginUpdates];
    [self.dataSource insertCellItem:cellItem atIndex:indexPath.row];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    [self.tableView endUpdates];
    
    
    __weak typeof(self)weakSelf = self;
    if (nil != completion) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (nil != completion) {
                completion();
            }
            [weakSelf.tableView reloadData];
        });
    }
}

- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion {
    
    [self.tableView beginUpdates];
    
    NSMutableArray *indexes = [NSMutableArray arrayWithCapacity:[cellItems count]];
    NSIndexPath *curIndexPath;
    for (int i = 0; i < [cellItems count]; i++) {
        id cellItem = [cellItems objectAtSafeIndex:i];
        curIndexPath = [NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section];
        [self.dataSource insertCellItem:cellItem atIndex:curIndexPath.row];
        [indexes addObject:curIndexPath];
    }
    
    [self.tableView insertRowsAtIndexPaths:indexes withRowAnimation:animation];
    [self.tableView endUpdates];
    
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:YES];
    
    __weak typeof(self)weakSelf = self;
    if (nil != completion) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (nil != completion) {
                completion();
            }
            [weakSelf.tableView reloadData];
        });
    }
}

- (void)appendCellItems:(NSArray *)cellItems withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion {
    if ([cellItems count] == 0) {
        return;
    }
    [self insertCellItems:cellItems atIndexPath:[NSIndexPath indexPathForRow:[self.dataSource cellItemsCount] inSection:0] withRowAnimation:animation completion:completion];

}


@end
