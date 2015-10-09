//
//  DDBaseTableViewController.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseViewController.h"
#import "DDTableView.h"
#import "DDBaseCellItem.h"
#import "DDBaseCell.h"
#import "DDDataSource.h"
#import "DDPlaceholderCellItem.h"
#import "DDLoadingCellItem.h"
#import "DDMoreCellItem.h"
#import "DDEmptyCellItem.h"
#import "DDTransparentCellItem.h"


@interface DDBaseTableViewController : DDBaseViewController <UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate>

/** Initialization */
- (instancetype)initWithStyle:(UITableViewStyle)style;
@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@property (nonatomic, readonly) BOOL isGroupTableView;

/** UITableView */
@property (nonatomic, strong) DDTableView *tableView;

/** DataSource */
@property (nonatomic, strong) DDDataSource *dataSource;
- (DDBaseCellItem *)cellItemWithIndexPath:(NSIndexPath *)indexPath tableView:(UITableView *)tableView;
- (void)generateDataSource;

/** StoryBoard Support */
@property (nonatomic, assign) BOOL staticTableView;
@property (nonatomic, assign) Class mainCellClass;

/** Table View Delegate*/
- (void)tableviewWillReload:(UIRefreshControl *)refreshControl;
- (void)tableViewWillLoadingMore;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/** Scroll */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate;
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;


/** Refresh */
- (void)dragDownRefresh;


/** Cell Selection Actions */
- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath;


/** Images */
- (void)loadImagesForOnscreenRows;
- (void)delayLoadImagesForOnscreenRowsAfter:(NSTimeInterval)delay;
- (void)delayLoadImagesForOnscreenRows;

/** Common CellActions */
- (void)yycellBaseDefaultOperationButtonPressedWithInfo:(NSDictionary *)info;


/** Delete CellItems */
- (void)deleteCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion;

/** Insert CellItems */
- (void)insertCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation;
- (void)insertCellItem:(DDBaseCellItem *)cellItem atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion;

- (void)insertCellItems:(NSArray *)cellItems atIndexPath:(NSIndexPath *)indexPath withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion;
- (void)appendCellItems:(NSArray *)cellItems withRowAnimation:(UITableViewRowAnimation)animation completion:(void (^)(void))completion;

@end
