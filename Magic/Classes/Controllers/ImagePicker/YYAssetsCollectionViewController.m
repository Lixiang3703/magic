//
//  YYAssetsCollectionViewController.m
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetsCollectionViewController.h"

// Views
#import "YYAssetsCollectionFooterView.h"

#import "YYAssetsCCell.h"
#import "YYAssetsCCellItem.h"
#import "YYAssetsCFlowLayout.h"

@interface YYAssetsCollectionViewController ()

@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, assign) NSUInteger numberOfAssets;
@property (nonatomic, assign) NSUInteger numberOfPhotos;
@property (nonatomic, assign) NSUInteger numberOfVideos;


@property (nonatomic, assign) BOOL viewDidAppear;
@property (nonatomic, strong) UIView *toolbarView;
@property (nonatomic, strong) UIButton *showPreviewButton;
@property (nonatomic, strong) UIButton *doneButton;

@end

@implementation YYAssetsCollectionViewController

-(UICollectionViewLayout *)defaultLayout{
    return [[YYAssetsCFlowLayout alloc] init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Validation
    if (self.allowsMultipleSelection) {
        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:self.imagePickerController.selectedAssetURLs.count];
    }
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
}

- (void)viewDidAppear:(BOOL)animated {
    BOOL appear = self.viewDidAppear;
    [super viewDidAppear:animated];
    
    self.viewDidAppear = YES;
    
    if (!appear) {
        [self setupBottomToolbar];
    }
    
    [self resetBottomButton];

    [self reloadDataForSelect];
    [self.collectionView reloadData];
}

#pragma mark -
#pragma mark DataSource

- (void)reloadMyDataSource {
    [self.dataSource clear];
    
    [self generateDataSource];
}

- (void)generateDataSource {
    [super generateDataSource];
    
    NSMutableArray *cellItemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < self.assets.count; i ++) {
        ALAsset *asset = self.assets[i];
        YYAssetsCCellItem *cellItem = [[YYAssetsCCellItem alloc] init];
        cellItem.asset = asset;
        cellItem.showsOverlayViewWhenSelected = self.allowsMultipleSelection;
        
        [cellItemsArray addSafeObject:cellItem];
    }
    [self.dataSource addCellItems:cellItemsArray];
}

#pragma mark -
#pragma mark Navi bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
//    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonClick:)];
//    [self.navigationItem setRightBarButtonItem:doneButton animated:NO];
}

#pragma mark -
#pragma mark Setup views

- (void)setupBottomToolbar {
    
    self.collectionView.height -= kImagePickerToolbarHeight;
    
    CGFloat toolbarTop = self.collectionView.bottom;
    
    self.toolbarView = [[UIView alloc] initWithFrame:CGRectMake(0, toolbarTop, [UIDevice screenWidth], kImagePickerToolbarHeight)];
    [self.toolbarView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.87]];
    
    [self.view addSubview:self.toolbarView];
    
    CGFloat buttonTop = (kImagePickerToolbarHeight - kImagePickerToolbarButton_height) / 2;
    
    self.showPreviewButton = [[UIButton alloc] initWithFrame:CGRectMake(18, buttonTop, kImagePickerToolbarButton_width, kImagePickerToolbarButton_height)];
    [self.showPreviewButton setBackgroundColor:[UIColor clearColor]];
    [self.showPreviewButton setTitle:@"预览" forState:UIControlStateNormal];
    [self.showPreviewButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.showPreviewButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.showPreviewButton sizeToFit];
    
    [self.showPreviewButton addTarget:self action:@selector(showPreviewButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat doneButtonLeft = self.toolbarView.width - 18 - kImagePickerToolbarButton_width;
    
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(doneButtonLeft, buttonTop, kImagePickerToolbarButton_width, kImagePickerToolbarButton_height)];
    [self.doneButton setBackgroundColor:[UIColor clearColor]];
    [self.doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor colorWithRed:1 green:0.6 blue:0.14 alpha:1] forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    
    [self.doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.toolbarView addSubview:self.showPreviewButton];
    [self.toolbarView addSubview:self.doneButton];
    
    [self resetBottomButton];
}

- (void)resetBottomButton {
    NSString *title = [NSString stringWithFormat:@"完成(%ld/%ld)",(unsigned long)self.imagePickerController.selectedAssetURLs.count, (unsigned long)self.maximumNumberOfSelection];
    
    if (self.imagePickerController.selectedAssetURLs.count <= 0) {
        title = @"完成";
    }
    
    [self.doneButton setTitle:title forState:UIControlStateNormal];
    [self.doneButton sizeToFit];
    self.doneButton.left = self.toolbarView.width - 18 - self.doneButton.width;
    
//    title = [NSString stringWithFormat:@"预览(%ld)",(unsigned long)self.imagePickerController.selectedAssetURLs.count];
//    [self.showPreviewButton setTitle:title forState:UIControlStateNormal];
    
    if (self.imagePickerController.selectedAssetURLs.count <= 0) {
        self.doneButton.enabled = NO;
        self.showPreviewButton.enabled = NO;
    }
    else {
        self.doneButton.enabled = YES;
        self.showPreviewButton.enabled = YES;
    }
}

- (void)reloadDataForSelect {
    for (NSInteger i = 0; i < self.assets.count; i++) {
        ALAsset *asset = self.assets[i];
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        
        YYAssetsCCellItem *ccellItem = (YYAssetsCCellItem *)[self.collectionView cellItemForIndexPath:indexPath];
        
        BOOL exist = NO;
        for (NSURL *oneAssetURL in self.imagePickerController.selectedAssetURLs) {
            if ([oneAssetURL isEqual:assetURL]) {
                exist = YES;
                break;
            }
        }
        ccellItem.shouldShowOverlayView = exist;
    }
}

#pragma mark -
#pragma mark Button actions

- (void)showPreviewButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCollectionViewControllerShowPreview:)]) {
        [self.delegate assetsCollectionViewControllerShowPreview:self];
    }
}

- (void)doneButtonClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCollectionViewControllerDidFinishSelection:)]) {
        [self.delegate assetsCollectionViewControllerDidFinishSelection:self];
    }
}

#pragma mark - Accessors

- (void)setFilterType:(YYImagePickerControllerFilterType)filterType
{
    _filterType = filterType;
    
    // Set assets filter
    [self.assetsGroup setAssetsFilter:ALAssetsFilterFromYYImagePickerControllerFilterType(self.filterType)];
}

- (void)setAssetsGroup:(ALAssetsGroup *)assetsGroup {
    _assetsGroup = assetsGroup;
    
    // Set title
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    
    // Set assets filter
    [self.assetsGroup setAssetsFilter:ALAssetsFilterFromYYImagePickerControllerFilterType(self.filterType)];
    
    // Load assets
    NSMutableArray *assets = [NSMutableArray array];
    __block NSUInteger numberOfAssets = 0;
    __block NSUInteger numberOfPhotos = 0;
    __block NSUInteger numberOfVideos = 0;
    
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            numberOfAssets++;
            
            NSString *type = [result valueForProperty:ALAssetPropertyType];
            if ([type isEqualToString:ALAssetTypePhoto]) numberOfPhotos++;
            else if ([type isEqualToString:ALAssetTypeVideo]) numberOfVideos++;
            
            [assets addObject:result];
        }
    }];
    
    self.assets = assets;
    self.numberOfAssets = numberOfAssets;
    self.numberOfPhotos = numberOfPhotos;
    self.numberOfVideos = numberOfVideos;
}

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection {
    self.collectionView.allowsMultipleSelection = allowsMultipleSelection;

    [self updateNavigationBar:YES];
}

- (BOOL)allowsMultipleSelection {
    return self.collectionView.allowsMultipleSelection;
}

#pragma mark - Managing Selection

- (void)clearAll {
    for (NSInteger i = 0; i < self.assets.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
        [self.collectionView deselectItemAtIndexPath:indexPath animated:NO];
    }
}

- (void)selectAssetHavingURL:(NSURL *)URL {
    for (NSInteger i = 0; i < self.assets.count; i++) {
        ALAsset *asset = self.assets[i];
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        
        if ([assetURL isEqual:URL]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
//            [self.collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
            
            YYAssetsCCellItem *ccellItem = (YYAssetsCCellItem *)[self.collectionView cellItemForIndexPath:indexPath];
            ccellItem.shouldShowOverlayView = YES;
            
            return;
        }
    }
}


#pragma mark - Validating Selections

- (BOOL)validateNumberOfSelections:(NSUInteger)numberOfSelections {
    NSUInteger minimumNumberOfSelection = MAX(1, self.minimumNumberOfSelection);
    BOOL qualifiesMinimumNumberOfSelection = (numberOfSelections >= minimumNumberOfSelection);
    
    BOOL qualifiesMaximumNumberOfSelection = YES;
    if (minimumNumberOfSelection <= self.maximumNumberOfSelection) {
        qualifiesMaximumNumberOfSelection = (numberOfSelections <= self.maximumNumberOfSelection);
    }
    
    return (qualifiesMinimumNumberOfSelection && qualifiesMaximumNumberOfSelection);
}

- (BOOL)validateMaximumNumberOfSelections:(NSUInteger)numberOfSelections {
    
    NSUInteger minimumNumberOfSelection = MAX(1, self.minimumNumberOfSelection);
    
    if (minimumNumberOfSelection <= self.maximumNumberOfSelection) {
        if (numberOfSelections <= self.maximumNumberOfSelection) {
            return YES;
        } else {
            if (self.maximumCustomAlertTitle) {
                [UIAlertView postAlertWithMessage:self.maximumCustomAlertTitle];
            }
            else {
                [UIAlertView postAlertWithMessage:[NSString stringWithFormat:@"最多只能选择%lu张照片",(unsigned long)self.maximumNumberOfSelection]];
            }
            return NO;
        }
    }
    return YES;
}

#pragma mark -
#pragma mark CollectionView

- (void)cellDidSelectWithCollectionView:(UICollectionView *)collectionView cellItem:(DDBaseCollectionCellItem *)cellItem cell:(DDBaseCollectionCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithCollectionView:collectionView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    YYAssetsCCellItem *assetCellItem = (YYAssetsCCellItem *)cellItem;
    if (![assetCellItem isKindOfClass:[YYAssetsCCellItem class]]) {
        return;
    }
    
    YYAssetsCCell *assetCell = (YYAssetsCCell *)cell;
    if (![assetCell isKindOfClass:[YYAssetsCCell class]]) {
        return;
    }
    
    assetCellItem.shouldShowOverlayView = !assetCellItem.shouldShowOverlayView;
    
    
    ALAsset *asset = assetCellItem.asset;
    
    if (!assetCellItem.showsOverlayViewWhenSelected) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCollectionViewController:didSelectAsset:)]) {
            [self.delegate assetsCollectionViewController:self didSelectAsset:asset];
        }
    }
    else {
        if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCollectionViewController:didDeselectAsset:)]) {
            [self.delegate assetsCollectionViewController:self didDeselectAsset:asset];
        }
    }
    
    assetCellItem.showsOverlayViewWhenSelected = !assetCellItem.showsOverlayViewWhenSelected;
    assetCell.showsOverlayViewWhenSelected = !assetCell.showsOverlayViewWhenSelected;
    [assetCell setSelected:assetCell.showsOverlayViewWhenSelected];
    
    
    // Validation
    if (self.allowsMultipleSelection) {
        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:(self.imagePickerController.selectedAssetURLs.count + 1)];
    }
    

    [self resetBottomButton];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYAssetsCCellItem *assetCellItem = (YYAssetsCCellItem *)[self.collectionView cellItemForIndexPath:indexPath];
    if (assetCellItem && assetCellItem.shouldShowOverlayView) {
        return YES;
    }
    
    return [self validateMaximumNumberOfSelections:(self.imagePickerController.selectedAssetURLs.count + 1)];
}

//
//
//#pragma mark - UICollectionViewDelegateFlowLayout
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(77.5, 77.5);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    return UIEdgeInsetsMake(2, 2, 2, 2);
//}
//
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return [self validateMaximumNumberOfSelections:(self.imagePickerController.selectedAssetURLs.count + 1)];
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ALAsset *asset = self.assets[indexPath.row];
//    
//    // Validation
//    if (self.allowsMultipleSelection) {
//        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:(self.imagePickerController.selectedAssetURLs.count + 1)];
//    }
//    
//    // Delegate
//    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCollectionViewController:didSelectAsset:)]) {
//        [self.delegate assetsCollectionViewController:self didSelectAsset:asset];
//    }
//    [self resetBottomButton];
//    
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    ALAsset *asset = self.assets[indexPath.row];
//    
//    // Validation
//    if (self.allowsMultipleSelection) {
//        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:(self.imagePickerController.selectedAssetURLs.count - 1)];
//    }
//    
//    // Delegate
//    if (self.delegate && [self.delegate respondsToSelector:@selector(assetsCollectionViewController:didDeselectAsset:)]) {
//        [self.delegate assetsCollectionViewController:self didDeselectAsset:asset];
//    }
//    [self resetBottomButton];
//    
//}

@end
