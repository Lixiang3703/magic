//
//  DDCollectionView.h
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDDTableView_Action_Key_Cell            (@"LBTableCell")
#define kDDTableView_Action_Key_CellItem        (@"LBTableCellItem")
#define kDDTableView_Action_Key_IndexPath       (@"LBTableIndexPath")
#define kDDTableView_Action_Key_Control         (@"LBTableControl")
#define kDDTableView_Action_Key_UserInfo        (@"LBTableUserInfo")

@class DDBaseCollectionCell;
@class DDBaseCollectionCellItem;

@interface DDCollectionView : UICollectionView


/** Actions */
- (void)cellActionWithCell:(id)cell control:(id)sender userInfo:(id)userInfo selector:(SEL)selector;

/** Spinner */
- (void)addInitialLoadingSpinner;
- (void)dismissLoadingSpinner;

/** Scroll */
- (void)scrollToFirstCellAnimated:(BOOL)animated;
- (void)scrollToLastCellAnimated:(BOOL)animated;

/** CellItem And Cell */
- (DDBaseCollectionCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath;
- (DDBaseCollectionCellItem *)cellItemWithCell:(DDBaseCollectionCell *)cell;

/** Reload */
- (void)reloadDataWithWillHandler:(void (^)(void))willHanlder didHandler:(void (^)(void))didHanlder;

@end
