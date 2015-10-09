//
//  YYBaseTableViewController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "DDTableView.h"

@interface YYBaseTableViewController ()

@end

@implementation YYBaseTableViewController

#pragma mark -
#pragma mark Initialzation
- (void)initSettings {
    [super initSettings];
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    self.view.backgroundColor = [UIColor YYViewBgColor];
    
    //  EmptyCell
    self.emptyCellItem = [[YYEmptyCellItem alloc] init];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.viewDidAppear && nil == self.requestModel.successBlock && nil == self.requestModel.failBlock) {
        //  RequsetModel Hander Settings
        __weak typeof(self)weakSelf = self;
        
        self.requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
            [weakSelf.tableView dismissLoadingSpinner];
            [weakSelf updateSuccessTableViewWithReqeustModel:requestModel];
            
        };
        self.requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
            [weakSelf.tableView dismissLoadingSpinner];
            [weakSelf updateFailTableViewWithReqeustModel:requestModel];
        };
        
        self.requestModel.cancelBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
            [weakSelf.tableView.refreshControl endRefreshing];
        };
        
        //  Inital Spinner
        if (!self.tableSpinnerHidden) {
            [self.tableView addInitialLoadingSpinner];
        }
    }
    
    if ([self tableViewShouldLoadRequestWhenWillAppearRequestModel:self.requestModel] && !self.viewDidAppear) {
        [self.requestModel loadLocalData];
    } else if ([self.dataSource cellItemsCount] > 0){
        [self.tableView reloadData];
        [self loadImagesForOnscreenRows];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    BOOL viewDidAppear = self.viewDidAppear;
    
    [super viewDidAppear:animated];
    
    //  Refresh
    if (viewDidAppear && self.needRefreshWhenViewDidAppear && ![self.dataSource isEmpty]) {
        [self.requestModel loadWithLoadingMore:NO];
    }
    
    self.needRefreshWhenViewDidAppear = NO;
}

#pragma mark -
#pragma mark DataSource
- (void)clearAllCellItemsAndShowEmptyCellItem {
    [self.dataSource clear];
    [self.dataSource addCellItem:[self theEmptyCellItemWithCorrectCellHeight]];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark Empty CellItem
- (DDEmptyCellItem *)theEmptyCellItemWithCorrectCellHeight {
    self.emptyCellItem.cellHeight = self.view.height + self.emptyCellItemHeightDelta;
    return self.emptyCellItem;
}

#pragma mark -
#pragma mark RequestModel Handler
- (void)updateSuccessTableViewWithReqeustModel:(YYBaseRequestModel *)requestModel {
    if (requestModel.customHandle) {
        return;
    }

    [self tableViewWillModifyDataSourceWithRequestModel:requestModel];
    
    if (!requestModel.isLoadingMore && [self dataSourceShouldClearWithRequestModel:requestModel]) {
        [self.dataSource clear];
    } else if (requestModel.isLoadingMore) {
        [self.dataSource trim];
    }
    
    
    NSMutableArray *cellItems = nil;
    
    if (1 == [self cellItemRawItemsCountWithRequestModel:requestModel]) {
        cellItems = [self generateCellItemsWithReqeustModel:requestModel resultItems:requestModel.resultItems];
    } else if ([self cellItemRawItemsCountWithRequestModel:requestModel] > 1) {
        cellItems = [self generateMultiRawItemCellItemsWithReqeustModel:requestModel resultItems:requestModel.resultItems count:[self cellItemRawItemsCountWithRequestModel:requestModel]];
    }
    
    
    [self cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
    
    if (self.loadingMoreUp) {
        [self.dataSource insertTopCellItems:cellItems];
    } else {
        [self.dataSource extendCellItems:cellItems];
    }
    [self cellItemsDidAddWithRequestModel:requestModel cellItems:cellItems];

    NSUInteger cellItemsCount = [cellItems count];
    
    if ([self.dataSource isEmpty] && !requestModel.didUseLocalData) {
        [self.dataSource addCellItem:[self theEmptyCellItemWithCorrectCellHeight]];
        cellItemsCount ++;
    }
    
    if (requestModel.hasNext && [self tableViewShouldAddMoreCellWithRequestModel:requestModel]) {
        
        if (self.loadingMoreUp) {
            [self.dataSource insertCellItem:[DDMoreCellItem cellItem] atIndex:0];
        } else {
            [self.dataSource addCellItem:[DDMoreCellItem cellItem]];
        }
        
        cellItemsCount ++;
    }
    
    [self tableViewWillUpdateWithRequestModel:requestModel];
    
    if ([self tableViewShouldReloadDataWithRequestModel:requestModel]) {
        __weak typeof(self) weakSelf = self;
        [self.tableView reloadDataWithWillHandler:^{
            [weakSelf tableViewWillReloadWithRequestModel:requestModel];
        } didHandler:^{
            [weakSelf tableViewDidReloadWithRequestModel:requestModel];
        }];
    }
    
    [self tableViewDidUpdateWithRequestModel:requestModel];
    
    if (requestModel.didUseLocalData && [self tableViewShouldReloadDataWithRequestModel:requestModel]) {
        [requestModel loadWithLoadingMore:NO];
    }
    
    [self delayLoadImagesForOnscreenRows];
    
    [self.tableView.refreshControl endRefreshing];
    
    if (self.loadingMoreUp) {
        if (!requestModel.isLoadingMore) {
            [self.tableView scrollToLastCellAnimated:NO];
        } else {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:MAX(0, cellItemsCount - 1) inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        }
    } else {
        if (!requestModel.isLoadingMore) {
            
            if (self.tableView.contentOffset.y < [UIDevice screenHeight]) {
                [self.tableView setContentOffset:[self initialContentOffsetWithRequestModel:requestModel] animated:!requestModel.didUseLocalData];
            }
            
            [self.tableView setContentInset:[self inititalContentInsetWithRequestModel:requestModel]];
        }
    }
    
    [self tableViewDidModifyDataSourceWithRequestModel:requestModel];
}

- (void)updateFailTableViewWithReqeustModel:(YYBaseRequestModel *)requestModel {
    if ([self.dataSource isEmpty]) {
        [self.dataSource addCellItem:[self theEmptyCellItemWithCorrectCellHeight]];
    }
    [self.tableView reloadData];
    [self.tableView.refreshControl endRefreshing];
}

- (NSMutableArray *)generateCellItemsWithReqeustModel:(YYBaseRequestModel *)requestModel resultItems:(NSArray *)resultitems {
    
    NSMutableArray *cellItems = [NSMutableArray arrayWithCapacity:[resultitems count]];
    DDBaseCellItem *cellItem = nil;
    
    for (DDBaseItem *rawItem in resultitems) {
        cellItem = [self cellItemForRawItem:rawItem];
        if (nil == cellItem) {
            cellItem = [[[self cellItemClass] alloc] init];
        }
        
        if ([rawItem respondsToSelector:NSSelectorFromString(@"type")]) {
            NSInteger type = [[rawItem valueForKey:@"type"] integerValue];
            if (0 == type) {
                continue;
            }
        }
        
        cellItem.rawObject = rawItem;
        cellItem.useCachedRawItem = requestModel.didUseLocalData;
        
        BOOL shouldAdd = [self cellItemShouldAddWithRequestModel:requestModel cellItem:cellItem];
        if (shouldAdd) {
            [cellItems addSafeObject:cellItem];
            [self cellItemDidAddWithRequestModel:requestModel cellItem:cellItem cellItems:cellItems];
        }
    }
    return cellItems;
}


- (DDBaseItem *)baseItemWithResultItems:(NSArray *)resultItems index:(NSUInteger *)index {
    NSUInteger resultCount = [resultItems count];
    DDBaseItem *baseItem = nil;
    while (nil == baseItem && *index < resultCount) {
        baseItem = [resultItems objectAtSafeIndex:*index];
        
        if ([baseItem respondsToSelector:NSSelectorFromString(@"type")]) {
            NSInteger type = [[baseItem valueForKey:@"type"] integerValue];
            if (0 == type) {
                baseItem = nil;
                *index += 1;
            }
        }
        
    }
    return baseItem;
}



- (NSMutableArray *)generateMultiRawItemCellItemsWithReqeustModel:(YYBaseRequestModel *)requestModel resultItems:(NSArray *)resultitems count:(NSUInteger)count {
    
    NSUInteger index = 0;
    NSUInteger resultCount = [resultitems count];
    
    if (NSIntegerMax == count) {
        count = resultCount;
    }
    
    NSMutableArray *cellItems = [NSMutableArray array];
    
    DDBaseCellItem *lastCellItem = [self.dataSource lastCellItem];
    
    NSArray *rawItem = lastCellItem.rawObject;
    if ([rawItem isKindOfClass:[NSArray class]] && rawItem.count < count) {
        NSMutableArray *items = [NSMutableArray array];
        [items addObjectsFromArray:rawItem];

        while ([items count] < count) {
            DDBaseItem *firstBaseItem = [self baseItemWithResultItems:resultitems index:&index];
            index ++;
            [items addSafeObject:firstBaseItem];
        }
        
        lastCellItem.rawObject = items;
    }
    
    DDBaseCellItem *cellItem = nil;
    NSMutableArray *tempRawItem = nil;
    while (index < resultCount) {
        tempRawItem = [NSMutableArray array];
        
        while ([tempRawItem count] < count && index < resultCount) {
            DDBaseItem *baseItem = [self baseItemWithResultItems:resultitems index:&index];
            index ++;
            [tempRawItem addSafeObject:baseItem];
        }
        
        cellItem = [self cellItemForRawItem:tempRawItem];
        if (nil == cellItem) {
            cellItem = [[[self cellItemClass] alloc] init];
        }
        
        cellItem.rawObject = tempRawItem;
        cellItem.useCachedRawItem = requestModel.didUseLocalData;
        
        BOOL shouldAdd = [self cellItemShouldAddWithRequestModel:requestModel cellItem:cellItem];
        if (shouldAdd) {
            [cellItems addSafeObject:cellItem];
            [self cellItemDidAddWithRequestModel:requestModel cellItem:cellItem cellItems:cellItems];
        }
    }
    
    return cellItems;
}


#pragma mark -
#pragma mark RequestModel Handler Templates
- (void)tableviewWillReload:(UIRefreshControl *)refreshControl {
    [super tableviewWillReload:refreshControl];
    [self.requestModel loadWithLoadingMore:NO];
}

- (void)tableViewWillLoadingMore {
    [super tableViewWillLoadingMore];
    [self.requestModel loadWithLoadingMore:YES];
}

- (Class)cellItemClass {
    return [DDBaseCellItem class];
}

- (DDBaseCellItem *)cellItemForRawItem:(id)baseItem {
    return nil;
}

- (NSUInteger)cellItemRawItemsCountWithRequestModel:(YYBaseRequestModel *)requestModel {
    return 1;
}

- (CGPoint)initialContentOffsetWithRequestModel:(YYBaseRequestModel *)requestModel {
    return CGPointZero;
}

- (UIEdgeInsets)inititalContentInsetWithRequestModel:(YYBaseRequestModel *)requestModel {
    return UIEdgeInsetsZero;
}

- (BOOL)dataSourceShouldClearWithRequestModel:(YYBaseRequestModel *)requestModel {
    return YES;
}

- (void)tableViewWillReloadWithRequestModel:(YYBaseRequestModel *)requestModel {

}

- (void)tableViewDidReloadWithRequestModel:(YYBaseRequestModel *)requestModel {

}

- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(DDBaseCellItem *)cellItem {
    return YES;
}

- (void)cellItemDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(DDBaseCellItem *)cellItem cellItems:(NSMutableArray *)cellItems {
    
}

- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {

}

- (void)cellItemsDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {

}

- (BOOL)tableViewShouldReloadDataWithRequestModel:(YYBaseRequestModel *)requestModel {
    return YES;
}

- (void)tableViewWillUpdateWithRequestModel:(YYBaseRequestModel *)requestModel {
    
}

- (void)tableViewDidUpdateWithRequestModel:(YYBaseRequestModel *)requestModel {
    
}

- (BOOL)tableViewShouldLoadRequestWhenWillAppearRequestModel:(YYBaseRequestModel *)requestModel {
    return YES;
}
- (BOOL)tableViewShouldReloadIfDidUseCacheWithRequestModel:(YYBaseRequestModel *)requestModel {
    return YES;
}
- (BOOL)tableViewShouldAddMoreCellWithRequestModel:(YYBaseRequestModel *)requestModel {
    return YES;
}

- (void)tableViewWillModifyDataSourceWithRequestModel:(YYBaseRequestModel *)requestModel {

}

- (void)tableViewDidModifyDataSourceWithRequestModel:(YYBaseRequestModel *)requestModel {

}

@end
