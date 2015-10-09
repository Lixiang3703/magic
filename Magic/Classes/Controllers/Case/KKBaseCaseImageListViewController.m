//
//  KKBaseCaseImageListViewController.m
//  Magic
//
//  Created by lixiang on 15/6/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKBaseCaseImageListViewController.h"
#import "KKDoubleImageCellItem.h"
#import "KKDoubleImageCell.h"
#import "YYGroupHeaderCellItem.h"
#import "YYGroupHeaderCell.h"

#import "KKPhotoDeleteRequestModel.h"
#import "PhotoScrollingViewController.h"

static const NSInteger topIndexPathCount = 1;

@interface KKBaseCaseImageListViewController ()<KKDoubleImageCellActions, PhotoGalleryViewControllerDelegate>



@end

@implementation KKBaseCaseImageListViewController


#pragma mark -
#pragma mark Accessor

- (NSMutableArray *)imageArray {
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}


#pragma mark -
#pragma mark life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.hasRefreshControl = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    [self setNaviTitle:_(@"申请文件列表")];
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"上传") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

#pragma mark -
#pragma mark Notification

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(photoUploadSuccess:) name:kNotification_Photos_Upload_Success object:nil];
}

- (void)photoUploadSuccess:(NSNotification *)notification {
    [self.requestModel loadWithLoadingMore:NO];
}


- (void)insertTopCellItems {
    [self.dataSource addCellItem:[YYGroupHeaderCellItem cellItemWithHeight:kUI_TableView_Group_Header_HeightS title:nil]];
}

#pragma mark -
#pragma mark RequestModel Handler Templates

- (Class)cellItemClass {
    return [KKDoubleImageCellItem class];
}

#pragma mark -
#pragma mark TableView

- (UIEdgeInsets)inititalContentInset {
    return UIEdgeInsetsMake(10, 0, 0, 0);
}

- (BOOL)tableViewShouldLoadRequestWhenWillAppearRequestModel:(YYBaseRequestModel *)requestModel {
    return YES;
}

- (NSUInteger)cellItemRawItemsCountWithRequestModel:(YYBaseRequestModel *)requestModel {
    return 2;
}


- (void)cellItemsWillAddWithRequestModel:(YYBaseRequestModel *)requestModel cellItems:(NSMutableArray *)cellItems {
    [super cellItemsWillAddWithRequestModel:requestModel cellItems:cellItems];
    
    if (!requestModel.isLoadingMore) {
        [self insertTopCellItems];
        KKDoubleImageCellItem *imageCellItem = [cellItems objectAtSafeIndex:0];
        if (imageCellItem) {
            imageCellItem.supportAdd = YES;
        }

    }
    
    if (!requestModel.isLoadingMore) {
        [self.imageArray removeAllObjects];
    }
    
    [self.imageArray addObjectsFromArray:requestModel.resultItems];
    [self removeSameForImageArray];
}

- (void)tableViewWillModifyDataSourceWithRequestModel:(YYBaseRequestModel *)requestModel {
    [super tableViewWillModifyDataSourceWithRequestModel:requestModel];
    
    // 增加一个占位符。
    if (!requestModel.isLoadingMore) {
        NSMutableArray *array = [NSMutableArray array];
        if (requestModel.resultItems.count > 0) {
            [array addSafeObject:[[KKImageItem alloc] init]];
            [array addObjectsFromArray:requestModel.resultItems];
            requestModel.resultItems = array;
        }
    }
}


#pragma mark -
#pragma mark Navi actions

- (void)rightBarButtonItemClick:(id)sender {
    [[KKPhotoUploadManager getInstance] uploadPhotoWithType:KKUploadPhotoType_caseUserImage entityId:self.caseId withMaxCount:5];
}

#pragma mark -
#pragma mark KKDoubleImageCellActions

- (void)kkDoubleImageCellImageViewPressed:(NSDictionary *)info {
    //    KKDoubleImageCellItem *cellItem = [info objectForKey:kDDTableView_Action_Key_CellItem];
    NSIndexPath *indexPath = [info objectForKey:kDDTableView_Action_Key_IndexPath];
    UIImageView *sender = [info objectForKey:kDDTableView_Action_Key_Control];
    
    NSInteger index = (indexPath.row - topIndexPathCount) * 2 + sender.tag - 1;
    
    PhotoScrollingViewController *photoScrollingViewController = [[PhotoScrollingViewController alloc] initWithPhotoSource:self initialIndex:index];
    photoScrollingViewController.isLocalUIImages = NO;
    photoScrollingViewController.supportDelete = YES;
    
    [[UINavigationController appNavigationController] presentViewController:photoScrollingViewController animated:YES completion:^{
        
    }];
}

- (void)kkDoubleImageCellAddButtonPressed:(NSDictionary *)info {
    [self rightBarButtonItemClick:nil];
}

- (void)removeSameForImageArray {
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (KKImageItem *item in self.imageArray) {
        if (![tempArray containsObject:item]) {
            [tempArray addSafeObject:item];
        }
    }
    
    self.imageArray = tempArray;
}

#pragma mark -
#pragma mark PhotoGalleryViewControllerDelegate

- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoScrollingViewController *)gallery {
    if (!self.imageArray) {
        return 0;
    }
    if (self.imageArray.count > 1) {
        return (self.imageArray.count - 1);
    }
    return 0;
}

- (NSString *)photoGallery:(PhotoScrollingViewController *)gallery urlForPhotoSize:(YYGalleryPhotoSize)size atIndex:(NSUInteger)index {
    if (!self.imageArray || self.imageArray.count < (index + 1)) {
        return @"http://h.hiphotos.baidu.com/image/pic/item/ac6eddc451da81cb4e89d63e5066d016082431d1.jpg";
    }
    KKImageItem *imageItem = [self.imageArray objectAtSafeIndex:(index + 1)];
    if (!imageItem) {
        return @"";
    }
    return imageItem.urlMiddle;
}

- (BOOL)photoGalleryDeletePhoto:(PhotoScrollingViewController *)gallery atIndex:(NSUInteger)index successBlock:(GalleryPhotoBlock)successblock failedBlock:(GalleryPhotoBlock)failedblock {
    
    KKImageItem *imageItem = [self.imageArray objectAtSafeIndex:(index + 1)];
    if (!imageItem) {
        return NO;
    }
    
    
    KKPhotoDeleteRequestModel *requestModel = [[KKPhotoDeleteRequestModel alloc] init];
    requestModel.imageId = imageItem.kkId;
    requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel){
        [self.imageArray removeObject:imageItem];
        
        if (successblock) {
            successblock(nil);
        }
        
        self.needRefreshWhenViewDidAppear = YES;
        
    };
    requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel){
        if (failedblock) {
            failedblock(nil);
        }
    };
    [requestModel load];
    
    return YES;
}



@end
