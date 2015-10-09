//
//  KKCaseMessageViewController.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseMessageListViewController.h"
#import "KKCaseMessageCellItem.h"
#import "KKCaseMessageCell.h"
#import "AppDelegate.h"
#import "DDImageViewer.h"

#import "KKCaseMessageViewController.h"
#import "KKCaseMessageListRequestModel.h"


@interface KKCaseMessageListViewController ()<KKCaseMessageCellActions>

@property (nonatomic, strong) KKCaseMessageListRequestModel *listRequestModel;

@property (nonatomic, strong) KKCaseItem *caseItem;
@end

@implementation KKCaseMessageListViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseMessageListRequestModel *)listRequestModel {
    if (_listRequestModel == nil) {
        _listRequestModel = [[KKCaseMessageListRequestModel alloc] init];
    }
    return _listRequestModel;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    self.requestModel = self.listRequestModel;
}

- (instancetype)initWithCaseItem:(KKCaseItem *)caseItem {
    self = [self init];
    if (self) {
        self.caseItem = caseItem;
        self.listRequestModel.caseId = self.caseItem.kkId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    BOOL viewDidAppear = self.viewDidAppear;
    [super viewWillAppear:animated];
    if (!viewDidAppear) {
 
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"消息列表")];
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
//    [self insertTestCellItems];
}

- (void)insertTestCellItems {
    [self.dataSource clear];
    
    NSMutableArray *cellItemArray = [NSMutableArray array];
        
    for (int i = 0; i < 5; i ++) {
        KKCaseMessageCellItem *cellItem = [[KKCaseMessageCellItem alloc] init];
        [cellItemArray addSafeObject:cellItem];
    }
    
    [self.dataSource addCellItems:cellItemArray];
}

#pragma mark -
#pragma mark TableView

- (Class)cellItemClass {
    return [KKCaseMessageCellItem class];
}

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(KKCaseMessageCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    KKCaseMessageItem *caseMessageItem = cellItem.rawObject;
    if (caseMessageItem && [caseMessageItem isKindOfClass:[KKCaseMessageItem class]]) {
        KKCaseMessageViewController *viewController = [[KKCaseMessageViewController alloc] initWithCaseMessageItem:caseMessageItem];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    
}

#pragma mark -
#pragma mark KKCaseMessageCellActions

- (void)kkCaseMessageImageButtonPressed:(NSDictionary *)info {
    NSLog(@"image button");
    
//    KKCaseMessageCellItem *cellItem = [info objectForKey:kDDTableView_Action_Key_CellItem];
    KKCaseMessageCell *cell = [info objectForKey:kDDTableView_Action_Key_Cell];
    
    CGRect startFrame = [cell.photoImageView convertRect:cell.photoImageView.frame toView:[AppDelegate sharedAppDelegate].window];
    CGRect endFrame = [AppDelegate sharedAppDelegate].window.bounds;
    
    [[DDImageViewer getInstance] viewFullScreenImageWithImageUrl:@"http://e.hiphotos.baidu.com/image/w%3D2048/sign=ef84a046c88065387beaa313a3e5a044/77c6a7efce1b9d16816dbf69f1deb48f8c54640b.jpg" placeHolderImage:cell.photoImageView.image startFrame:startFrame endFrame:endFrame animated:YES];
}

@end

