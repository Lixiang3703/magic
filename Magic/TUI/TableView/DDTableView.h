//
//  DDTableView.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDRefreshControl.h"

#define kDDTableView_Action_Key_Cell            (@"LBTableCell")
#define kDDTableView_Action_Key_CellItem        (@"LBTableCellItem")
#define kDDTableView_Action_Key_IndexPath       (@"LBTableIndexPath")
#define kDDTableView_Action_Key_Control         (@"LBTableControl")
#define kDDTableView_Action_Key_UserInfo        (@"LBTableUserInfo")

@class DDBaseCell;
@class DDBaseCellItem;

@interface DDTableView : UITableView

@property (nonatomic, assign) BOOL hasRefreshControl;
@property (nonatomic, assign) BOOL multipleCellSwipable;
@property (nonatomic, weak) DDRefreshControl *refreshControl;

- (void)cellActionWithCell:(id)cell control:(id)sender userInfo:(id)userInfo selector:(SEL)selector;

/** Spinner */
- (void)addInitialLoadingSpinner;
- (void)dismissLoadingSpinner;

/** Scroll */
- (void)scrollToFirstCellAnimated:(BOOL)animated;
- (void)scrollToLastCellAnimated:(BOOL)animated;

/** Swipe */
- (void)cellDidOpen:(DDBaseCell *)cell;

/** CellItem And Cell */
- (DDBaseCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath;
- (DDBaseCellItem *)cellItemWithCell:(DDBaseCell *)cell;
- (DDBaseCell *)cellForCellItem:(DDBaseCellItem *)cellItem;


/** Reload */
- (void)delayReload;
- (void)reloadDataWithWillHandler:(void (^)(void))willHanlder didHandler:(void (^)(void))didHanlder;

@end
