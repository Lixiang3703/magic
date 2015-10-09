//
//  DDTableView.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTableView.h"
#import "DDBaseTableViewController.h"
#import "DDSwipeCell.h"

@interface DDTableView ()

@property (nonatomic, strong) UIActivityIndicatorView *spinner;


@end

@implementation DDTableView


#pragma mark -
#pragma mark Initialzation

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame style:UITableViewStylePlain];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (void)initSettings {
    self.hasRefreshControl = NO;
    self.multipleCellSwipable = YES;
    self.rowHeight = 44;
    self.backgroundColor = [UIColor clearColor];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self fullfillPrarentView];
}

#pragma mark -
#pragma mark Initial Loading Spinner
- (void)addInitialLoadingSpinner {
    if (nil == self.spinner) {
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        self.spinner.frame = self.frame;
        self.spinner.autoresizingMask = self.autoresizingMask;
        self.spinner.userInteractionEnabled = NO;
    }
    
    if (nil == self.spinner.superview) {
        [self.superview addSubview:self.spinner];
    }
    
    [self.spinner startAnimating];
}

- (void)dismissLoadingSpinner {
    //  Dismiss Loading spinner
    [self.spinner stopAnimating];
    [self.spinner removeFromSuperview];
    self.spinner = nil;
}

#pragma mark -
#pragma mark Reload
- (void)reloadData {
    [super reloadData];
}

- (void)delayReload {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf reloadData];
    });
}

- (void)reloadDataWithWillHandler:(void (^)(void))willHanlder didHandler:(void (^)(void))didHanlder {
    if (willHanlder) {
        willHanlder();
    }
    [self reloadData];
    if (didHanlder) {
        didHanlder();
    }
}

#pragma mark -
#pragma mark Accessors
- (void)setHasRefreshControl:(BOOL)hasRefreshControl {
    _hasRefreshControl = hasRefreshControl;
    if (hasRefreshControl) {
        if (self.refreshControl && self.refreshControl.superview) {
            [self.refreshControl removeFromSuperview];
        }
        DDRefreshControl *refreshControl = [[DDRefreshControl alloc] init];
        [self addSubview:refreshControl];
        self.refreshControl = refreshControl;
        [self.refreshControl addTarget:self.delegate action:@selector(tableviewWillReload:) forControlEvents:UIControlEventValueChanged];
    } else {
        [self.refreshControl removeFromSuperview];
    }
}

- (void)cellActionWithCell:(id)cell control:(id)sender userInfo:(id)userInfo selector:(SEL)selector {
    NSIndexPath *indexPath = [self indexPathForCell:cell];
    DDBaseCellItem *cellItem = [self cellItemForIndexPath:indexPath];
    
    if ([self.delegate respondsToSelector:selector]) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setSafeObject:cell forKey:kDDTableView_Action_Key_Cell];
        [dict setSafeObject:cellItem forKey:kDDTableView_Action_Key_CellItem];
        [dict setSafeObject:sender forKey:kDDTableView_Action_Key_Control];
        [dict setSafeObject:indexPath forKey:kDDTableView_Action_Key_IndexPath];
        [dict setSafeObject:userInfo forKey:kDDTableView_Action_Key_UserInfo];
        
        SuppressPerformSelectorLeakWarning([self.delegate performSelector:selector withObject:dict]);
    }
}

#pragma mark -
#pragma mark Scroll
- (void)scrollToFirstCellAnimated:(BOOL)animated {
    if ([self numberOfSections] != 0 && [self numberOfRowsInSection:0] != 0) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:animated];
    }
}

- (void)scrollToLastCellAnimated:(BOOL)animated {
    if ([self numberOfSections] != 0 && [self numberOfRowsInSection:0] != 0) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self numberOfRowsInSection:0] - 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    }
}

#pragma mark -
#pragma mark Swipe
- (void)cellDidOpen:(DDSwipeCell *)cell {
    [self.visibleCells enumerateObjectsUsingBlock:^(DDSwipeCell *obj, NSUInteger idx, BOOL *stop) {
        if (obj != cell && [obj isKindOfClass:[DDSwipeCell class]]) {
            [obj closeAnimated:YES completion:^{
                
            }];
        }
    }];
    
}

#pragma mark -
#pragma mark Hit Touch


- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:point];
    
    DDBaseCellItem *cellItem = [self cellItemForIndexPath:indexPath];

    if (!cellItem.userInteractionEnabled) {
        return nil;
    } else {
        return [super hitTest:point withEvent:event];
    }
}


#pragma mark -
#pragma mark CellItem
- (DDBaseCellItem *)cellItemForIndexPath:(NSIndexPath *)indexPath {
    DDBaseTableViewController *tableViewController = (DDBaseTableViewController *)self.dataSource;
    DDBaseCellItem *cellItem = [tableViewController cellItemWithIndexPath:indexPath tableView:self];
    return cellItem;
}

- (DDBaseCellItem *)cellItemWithCell:(DDBaseCell *)cell {
    return [self cellItemForIndexPath:[self indexPathForCell:cell]];
}

- (DDBaseCell *)cellForCellItem:(DDBaseCellItem *)cellItem {
    DDBaseTableViewController *tableViewController = (DDBaseTableViewController *)self.dataSource;
    NSUInteger rowIndex = [tableViewController.dataSource rowIndexForCellItem:cellItem];
    if (NSNotFound == rowIndex) {
        return nil;
    }
    return (DDBaseCell *)[self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowIndex inSection:0]];
}

@end
