//
//  KKModifyBaseViewController.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"

#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKModifyDelegate.h"

@interface KKModifyBaseViewController : YYBaseTableViewController<KKModifyDelegate>

@property (nonatomic, assign) BOOL isNaviPush;

@property (nonatomic, assign) CGPoint startPoint;

@property (nonatomic, assign) CGRect originTableViewFrame;

/*默认高度的Header*/
- (YYGroupHeaderCellItem *)groupHeaderCellItemWithTitle:(NSString *)tiltle seperatorLeft:(CGFloat)left;

- (void)leftBarButtonItemClick:(id)sender;

- (void)rightBarButtonItemClick:(id)sender;

- (void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer;

- (void)setupRawItemFromUI;
@end
