//
//  KKCaseMessageViewController.m
//  Magic
//
//  Created by lixiang on 15/4/29.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseMessageViewController.h"
#import "KKSingleBigImageCellItem.h"
#import "KKSingleBigImageCell.h"

#import "KKShowTagCellItem.h"
#import "KKShowTagCell.h"
#import "KKCaseDetailTitleCellItem.h"
#import "KKCaseDetailTitleCell.h"
#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"
#import "KKPhotoBigShowManager.h"

#import "KKCaseMsgOneRequestModel.h"

static const NSInteger topCellItemCount = 3;

@interface KKCaseMessageViewController ()

@property (nonatomic, strong) KKShowTagCellItem *contentCellItem;
@property (nonatomic, strong) KKCaseDetailTitleCellItem *titleCellItem;

@property (nonatomic, strong) KKCaseMessageItem *caseMessageItem;
@property (nonatomic, assign) NSInteger itemId;

@property (nonatomic, strong) KKCaseMsgOneRequestModel *oneRequestModel;

@end

@implementation KKCaseMessageViewController

#pragma mark -
#pragma mark Accessor

- (KKCaseMsgOneRequestModel *)oneRequestModel {
    if (_oneRequestModel == nil) {
        __weak __typeof(self)weakSelf = self;
        _oneRequestModel = [[KKCaseMsgOneRequestModel alloc] init];
        _oneRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKCaseMsgOneRequestModel* requestModel) {
            weakSelf.caseMessageItem = requestModel.resultItem;
            [weakSelf reloadMyDataSource];
            [weakSelf.tableView reloadData];
        };
        _oneRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKCaseMsgOneRequestModel* requestModel){
            [UIAlertView postAlertWithMessage:@"fail"];
        };
    }
    return _oneRequestModel;
}

- (KKShowTagCellItem *)contentCellItem {
    if (_contentCellItem == nil) {
        _contentCellItem = [[KKShowTagCellItem alloc] init];
        _contentCellItem.cellLayoutType = KKShowTagCellLayoutTypeFloatTop;
        _contentCellItem.seperatorLineHidden = YES;
    }
    return _contentCellItem;
}

- (KKCaseDetailTitleCellItem *)titleCellItem {
    if (_titleCellItem == nil) {
        _titleCellItem = [[KKCaseDetailTitleCellItem alloc] init];
    }
    return _titleCellItem;
}

#pragma mark -
#pragma mark Life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

- (instancetype)initWithItemId:(NSInteger)itemId {
    self = [self init];
    if (self) {
        self.itemId = itemId;
        self.oneRequestModel.itemId = itemId;
    }
    return self;
}

- (instancetype)initWithCaseMessageItem:(KKCaseMessageItem *)caseMessageItem {
    self = [self init];
    if (self) {
        self.caseMessageItem = caseMessageItem;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.caseMessageItem) {
        if (self.messageId > 0) {
            self.oneRequestModel.messageId = self.messageId;
        }
        [self.oneRequestModel load];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Navigation Bar
- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"消息")];
    
}

#pragma mark -
#pragma mark DataSrouce
- (void)generateDataSource {
    [super generateDataSource];
    
    [self reloadMyDataSource];
}

- (void)reloadMyDataSource {
    [self.dataSource clear];
    
    if (!self.caseMessageItem) {
        return;
    }
    
    self.titleCellItem.caseItem = self.caseMessageItem.caseItem;
    
    NSMutableArray *cellItemArray = [NSMutableArray array];
    
    [cellItemArray addSafeObject:[YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil]];
    [cellItemArray addSafeObject:self.titleCellItem];
    
    KKShowTagItem *showTagItem1 = [[KKShowTagItem alloc] init];
    showTagItem1.tagName = @"";
    showTagItem1.titleName = self.caseMessageItem.content;
    showTagItem1.cellLayoutType = KKShowTagCellLayoutTypeFloatTop;
    
    [self.contentCellItem updateCellItemWithTagItem:showTagItem1];
    [cellItemArray addSafeObject:self.contentCellItem];
    
    if (self.caseMessageItem.imageItemArray && self.caseMessageItem.imageItemArray.count > 0) {
        for (int i = 0; i < self.caseMessageItem.imageItemArray.count; i++) {
            KKImageItem *imageItem = [self.caseMessageItem.imageItemArray objectAtSafeIndex:i];
            KKSingleBigImageCellItem *cellItem = [[KKSingleBigImageCellItem alloc] init];
            cellItem.rawObject = imageItem;
            
            [cellItemArray addSafeObject:cellItem];
        }
    }
    
    
//    for (int i = 0; i < 5; i ++) {
//        KKSingleBigImageCellItem *cellItem = [[KKSingleBigImageCellItem alloc] init];
//        KKImageItem *imageItem = [[KKImageItem alloc] initWithUrlOrigin:@"" urlMiddle:@"http://f.hiphotos.baidu.com/image/pic/item/cdbf6c81800a19d8a1d53c0c31fa828ba71e46e0.jpg" urlSmall:@""];
//        cellItem.rawObject = imageItem;
//        
//        [cellItemArray addSafeObject:cellItem];
//    }
    
    [self.dataSource addCellItems:cellItemArray];
}

#pragma mark -
#pragma mark TableView

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    if (self.caseMessageItem.imageItemArray && self.caseMessageItem.imageItemArray.count > 0) {
        [[KKPhotoBigShowManager getInstance] showPublishControllerWithImageItemArray:self.caseMessageItem.imageItemArray initialIndex:indexPath.row - topCellItemCount];
    }
}



@end


