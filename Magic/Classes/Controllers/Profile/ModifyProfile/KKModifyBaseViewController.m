//
//  KKModifyBaseViewController.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKModifyBaseViewController.h"

#import "UIAlertView+Blocks.h"

@implementation KKModifyBaseViewController
@synthesize hasModified;
@synthesize modifyDidSuccessBlock;

#pragma mark -
#pragma mark Accesser

- (YYGroupHeaderCellItem *)groupHeaderCellItemWithTitle:(NSString *)tiltle seperatorLeft:(CGFloat)left{
    YYGroupHeaderCellItem *groupHeaderCellItem = [YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Common_Margin title:tiltle];
    groupHeaderCellItem.seperatorLineHidden = NO;
    groupHeaderCellItem.cellWillDisplayBlock = ^(YYGroupHeaderCellItem *cellItem, YYGroupHeaderCell *cell, NSIndexPath *indexPath, DDBaseTableViewController *viewController) {
        cell.seperatorLine.left = left;
        cell.seperatorLine.width = cell.width - left;
        cell.textLabel.font = [UIFont systemFontOfSize:16];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
    };
    return groupHeaderCellItem;
}

#pragma mark -
#pragma mark LifeCycle

- (void)viewDidLoad{
    [super viewDidLoad];
//    self.tableView.scrollEnabled = NO;
    self.tableSpinnerHidden = YES;
    
//    UISwipeGestureRecognizer *swipGestureRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGestureRecognizer:)];
//    swipGestureRecognizer.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
//    swipGestureRecognizer.delaysTouchesBegan = YES;
//    [self.view addGestureRecognizer:swipGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.originTableViewFrame = self.tableView.frame;
    
}

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}


#pragma mark -
#pragma mark DataSource

- (void)generateDataSource{
    [super generateDataSource];
    [self.dataSource addCellItem:[self groupHeaderCellItemWithTitle:nil seperatorLeft:0]];
}


#pragma mark -
#pragma mark NavigationBar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setNaviTitle:@"编辑信息"];
    
    [self setLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"取消") target:self action:@selector(leftBarButtonItemClick:)] animated:animated];
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"保存") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
    
//    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithWithTitle:@"保存" buttonTheme:kThemeNavigationBarGoldenButton target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

#pragma mark -
#pragma mark User actions

- (void)leftBarButtonItemClick:(id)sender {
    if (self.hasModified) {
        RIButtonItem *cancelBnt = [RIButtonItem itemWithLabel:_(@"取消")];
        RIButtonItem *okBnt = [RIButtonItem itemWithLabel:_(@"确定")];
        
        __weak typeof(self)weakSelf = self;
        okBnt.action = ^{
            [weakSelf dismissSelf];
        };
        
        [[[UIAlertView alloc] initWithTitle:@"放弃编辑并离开"
                                    message:nil
                           cancelButtonItem:cancelBnt
                           otherButtonItems:okBnt, nil] show];
    } else {
        [self dismissSelf];
    }
}

- (void)rightBarButtonItemClick:(id)sender {
    
}

- (void)swipeGestureRecognizer:(UISwipeGestureRecognizer *)gestureRecognizer {
}

- (void)reloadDataSource{
    [self.dataSource clear];
    [self generateDataSource];
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark actions

- (void)dismissSelf {
    if (self.isNaviPush) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark -
#pragma mark  Notification

- (void)keyboardWillShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification{
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [super scrollViewWillBeginDragging:scrollView];
    self.startPoint = scrollView.contentOffset;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [super scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    if (self.startPoint.y - scrollView.contentOffset.y > 70 || scrollView.contentOffset.y < -10) {
        [[self.view.window findFirstResponder] resignFirstResponder];
        [self setupRawItemFromUI];
        self.tableView.top = 0;
    }
}

#pragma mark -
#pragma mark sub class template

- (void)setupRawItemFromUI {
    
}

@end
