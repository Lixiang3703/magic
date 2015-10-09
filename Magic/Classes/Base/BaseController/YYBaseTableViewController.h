//
//  YYBaseTableViewController.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseTableViewController.h"
#import "YYBaseRequestModel.h"
#import "YYEmptyCellItem.h"


@interface YYBaseTableViewController : DDBaseTableViewController {
    YYBaseRequestModel *_requestModel;
}


/** Up or Down loading more */
@property (nonatomic, assign) BOOL loadingMoreUp;

/** Common Params */
@property (nonatomic, copy) NSString *rawItemId;

/** Request Model */
@property (nonatomic, assign) BOOL tableSpinnerHidden;
@property (nonatomic, strong) YYBaseRequestModel *requestModel;

/** DataSource */
@property (nonatomic, strong) DDEmptyCellItem *emptyCellItem;
- (void)clearAllCellItemsAndShowEmptyCellItem;

/** RequestModel Handler */
- (void)updateSuccessTableViewWithReqeustModel:(YYBaseRequestModel *)requestModel;
- (void)updateFailTableViewWithReqeustModel:(YYBaseRequestModel *)requestModel;

/** Empty Cell Item */
- (DDEmptyCellItem *)theEmptyCellItemWithCorrectCellHeight;
@property (nonatomic, assign) CGFloat emptyCellItemHeightDelta;


/** Refresh Flag */
@property (nonatomic, assign) BOOL needRefreshWhenViewDidAppear;

/** RequestModel Handler Templates */
- (Class)cellItemClass;
- (DDBaseCellItem *)cellItemForRawItem:(id)baseItem;
- (NSUInteger)cellItemRawItemsCountWithRequestModel:(YYBaseRequestModel *)requestModel;
- (CGPoint)initialContentOffsetWithRequestModel:(YYBaseRequestModel *)requestModel;
- (UIEdgeInsets)inititalContentInsetWithRequestModel:(YYBaseRequestModel *)requestModel;
- (NSMutableArray *)generateCellItemsWithReqeustModel:(YYBaseRequestModel *)requestModel resultItems:(NSArray *)resultitems;
- (NSMutableArray *)generateMultiRawItemCellItemsWithReqeustModel:(YYBaseRequestModel *)requestModel resultItems:(NSArray *)resultitems count:(NSUInteger)count;
- (BOOL)dataSourceShouldClearWithRequestModel:(YYBaseRequestModel *)requestModel;
- (void)tableViewWillReloadWithRequestModel:(YYBaseRequestModel *)requestModel;
- (void)tableViewDidReloadWithRequestModel:(YYBaseRequestModel *)requestModel;
- (BOOL)cellItemShouldAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(DDBaseCellItem *)cellItem;
- (void)cellItemDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItem:(DDBaseCellItem *)cellItem cellItems:(NSMutableArray *)cellItems;
- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems;
- (void)cellItemsDidAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems;
- (BOOL)tableViewShouldReloadDataWithRequestModel:(YYBaseRequestModel *)requestModel;
- (void)tableViewWillUpdateWithRequestModel:(YYBaseRequestModel *)requestModel;
- (void)tableViewDidUpdateWithRequestModel:(YYBaseRequestModel *)requestModel;
- (BOOL)tableViewShouldLoadRequestWhenWillAppearRequestModel:(YYBaseRequestModel *)requestModel;
- (BOOL)tableViewShouldReloadIfDidUseCacheWithRequestModel:(YYBaseRequestModel *)requestModel;
- (BOOL)tableViewShouldAddMoreCellWithRequestModel:(YYBaseRequestModel *)requestModel;


- (void)tableViewWillModifyDataSourceWithRequestModel:(YYBaseRequestModel *)requestModel;
- (void)tableViewDidModifyDataSourceWithRequestModel:(YYBaseRequestModel *)requestModel;

@end
