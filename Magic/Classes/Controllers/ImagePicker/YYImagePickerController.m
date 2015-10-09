//
//  YYImagePickerViewController.m
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>

// Views
#import "YYAssetsCollectionViewLayout.h"

// ViewControllers
#import "YYAssetsCollectionViewController.h"
#import "PhotoGalleryViewController.h"
#import "YYNavigationController.h"

#import "YYAssetHandler.h"

#import "AppDelegate.h"

#import "YYImagePickerAssetGroupCell.h"
#import "YYImagePickerAssetGroupCellItem.h"

#import "YYImagePickerPhotoGalleryViewController.h"

ALAssetsFilter * ALAssetsFilterFromYYImagePickerControllerFilterType(YYImagePickerControllerFilterType type) {
    switch (type) {
        case YYImagePickerControllerFilterTypeNone:
            return [ALAssetsFilter allAssets];
            break;
            
        case YYImagePickerControllerFilterTypePhotos:
            return [ALAssetsFilter allPhotos];
            break;
            
        case YYImagePickerControllerFilterTypeVideos:
            return [ALAssetsFilter allVideos];
            break;
    }
}

@interface YYImagePickerController ()<YYAssetsCollectionViewControllerDelegate,YYPhotoGalleryViewControllerDelegate,YYImagePickerPhotoGalleryViewControllerDelegate>

@property (nonatomic, strong, readwrite) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, copy, readwrite) NSArray *assetsGroups;
@property (nonatomic, strong, readwrite) NSMutableOrderedSet *selectedAssetURLs;
@property (nonatomic, strong) YYAssetsCollectionViewController *assetsCollectionViewController;
@end

@implementation YYImagePickerController

+ (BOOL)isAccessible
{
    return ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary] &&
            [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum]);
}

#pragma mark -
#pragma mark life cycle

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    
    self.allowsMultipleSelection = YES;
    self.showsCancelButton = YES;
    self.filterType = YYImagePickerControllerFilterTypePhotos;
    
    [self setUpProperties];
}


- (void)setUpProperties
{
    // Property settings
    self.selectedAssetURLs = [NSMutableOrderedSet orderedSet];
    
//    self.groupTypes = @[
//                        @(ALAssetsGroupSavedPhotos),
//                        @(ALAssetsGroupPhotoStream),
//                        @(ALAssetsGroupAlbum)
//                        ];
    
    self.groupTypes = @[
                        @(ALAssetsGroupSavedPhotos),
                        @(ALAssetsGroupAlbum)
                        ];
    
    self.filterType = YYImagePickerControllerFilterTypeNone;
    self.showsCancelButton = YES;
    
    // View settings
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Create assets library instance
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    self.assetsLibrary = assetsLibrary;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // View controller settings
    self.title = NSLocalizedStringFromTableInBundle(@"title",
                                                    @"QBImagePickerController",
                                                    [NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"QBImagePickerController" ofType:@"bundle"]],
                                                    nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // Load assets groups
    [self loadAssetsGroupsWithTypes:self.groupTypes
                         completion:^(NSArray *assetsGroups) {
                             self.assetsGroups = assetsGroups;
                             
                             [self reloadMyDataSource];
                             [self.tableView reloadData];
                         }];
    
    // Validation
    self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:self.selectedAssetURLs.count];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


#pragma mark - Accessors

- (void)setShowsCancelButton:(BOOL)showsCancelButton
{
    _showsCancelButton = showsCancelButton;
    
    // Show/hide cancel button
    if (showsCancelButton) {
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    } else {
        [self.navigationItem setLeftBarButtonItem:nil animated:NO];
    }
}

- (void)setAllowsMultipleSelection:(BOOL)allowsMultipleSelection
{
    _allowsMultipleSelection = allowsMultipleSelection;
    
    // Show/hide done button
    if (allowsMultipleSelection) {
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:doneButton animated:NO];
    } else {
        [self.navigationItem setRightBarButtonItem:nil animated:NO];
    }
}


#pragma mark - Actions

- (void)done:(id)sender
{
    [self passSelectedAssetsToDelegate];
}

- (void)cancel:(id)sender
{
    // Delegate
    if (self.delegate && [self.delegate respondsToSelector:@selector(yy_imagePickerControllerDidCancel:)]) {
        [self.delegate yy_imagePickerControllerDidCancel:self];
    }
}


#pragma mark - Validating Selections

- (BOOL)validateNumberOfSelections:(NSUInteger)numberOfSelections
{
    // Check the number of selected assets
    NSUInteger minimumNumberOfSelection = MAX(1, self.minimumNumberOfSelection);
    BOOL qualifiesMinimumNumberOfSelection = (numberOfSelections >= minimumNumberOfSelection);
    
    BOOL qualifiesMaximumNumberOfSelection = YES;
    if (minimumNumberOfSelection <= self.maximumNumberOfSelection) {
        qualifiesMaximumNumberOfSelection = (numberOfSelections <= self.maximumNumberOfSelection);
    }
    
    return (qualifiesMinimumNumberOfSelection && qualifiesMaximumNumberOfSelection);
}


#pragma mark - Managing Assets

- (void)loadAssetsGroupsWithTypes:(NSArray *)types completion:(void (^)(NSArray *assetsGroups))completion
{
    __block NSMutableArray *assetsGroups = [NSMutableArray array];
    __block NSUInteger numberOfFinishedTypes = 0;
    
    for (NSNumber *type in types) {
        __weak typeof(self) weakSelf = self;
        
        [self.assetsLibrary enumerateGroupsWithTypes:[type unsignedIntegerValue]
                                          usingBlock:^(ALAssetsGroup *assetsGroup, BOOL *stop) {
                                              if (assetsGroup) {
                                                  // Filter the assets group
                                                  [assetsGroup setAssetsFilter:ALAssetsFilterFromYYImagePickerControllerFilterType(weakSelf.filterType)];
                                                  
                                                  if (assetsGroup.numberOfAssets > 0) {
                                                      // Add assets group
                                                      [assetsGroups addObject:assetsGroup];
                                                  }
                                              } else {
                                                  numberOfFinishedTypes++;
                                              }
                                              
                                              // Check if the loading finished
                                              if (numberOfFinishedTypes == types.count) {
                                                  // Sort assets groups
                                                  NSArray *sortedAssetsGroups = [self sortAssetsGroups:(NSArray *)assetsGroups typesOrder:types];
                                                  
                                                  // Call completion block
                                                  if (completion) {
                                                      completion(sortedAssetsGroups);
                                                  }
                                              }
                                          } failureBlock:^(NSError *error) {
                                              NSLog(@"Error: %@", [error localizedDescription]);
                                          }];
    }
}

- (NSArray *)sortAssetsGroups:(NSArray *)assetsGroups typesOrder:(NSArray *)typesOrder
{
    NSMutableArray *sortedAssetsGroups = [NSMutableArray array];
    
    for (ALAssetsGroup *assetsGroup in assetsGroups) {
        if (sortedAssetsGroups.count == 0) {
            [sortedAssetsGroups addObject:assetsGroup];
            continue;
        }
        
        ALAssetsGroupType assetsGroupType = [[assetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
        NSUInteger indexOfAssetsGroupType = [typesOrder indexOfObject:@(assetsGroupType)];
        
        for (NSInteger i = 0; i <= sortedAssetsGroups.count; i++) {
            if (i == sortedAssetsGroups.count) {
                [sortedAssetsGroups addObject:assetsGroup];
                break;
            }
            
            ALAssetsGroup *sortedAssetsGroup = sortedAssetsGroups[i];
            ALAssetsGroupType sortedAssetsGroupType = [[sortedAssetsGroup valueForProperty:ALAssetsGroupPropertyType] unsignedIntegerValue];
            NSUInteger indexOfSortedAssetsGroupType = [typesOrder indexOfObject:@(sortedAssetsGroupType)];
            
            if (indexOfAssetsGroupType < indexOfSortedAssetsGroupType) {
                [sortedAssetsGroups insertObject:assetsGroup atIndex:i];
                break;
            }
        }
    }
    
    return [sortedAssetsGroups copy];
}

- (void)passSelectedAssetsToDelegate {
    if (self.selectedAssetURLs.count <= 0) {
        [UIAlertView postAlertWithMessage:@"请选择照片"];
    }
    
    // Load assets from URLs
    __block NSMutableArray *assets = [NSMutableArray array];
    __weak __typeof(self)weakSelf = self;
    
    for (NSURL *selectedAssetURL in self.selectedAssetURLs) {
        [self.assetsLibrary assetForURL:selectedAssetURL
                            resultBlock:^(ALAsset *asset) {
                                
                                if (asset == nil) {
                                    return;
                                }
                                
                                // Add asset
                                [assets addObject:asset];
                                
                                // Check if the loading finished
                                if (assets.count == weakSelf.selectedAssetURLs.count) {
                                    // Delegate
                                    if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(yy_imagePickerController:didSelectAssets:)]) {
                                        [weakSelf.delegate yy_imagePickerController:weakSelf didSelectAssets:[assets copy]];
                                    }
                                }
                            } failureBlock:^(NSError *error) {
                                NSLog(@"Error: %@", [error localizedDescription]);
                            }];
    }
}

- (void)showPreview {
    // Load assets from URLs
    __block NSMutableArray *assets = [NSMutableArray array];
    __weak __typeof(self)weakSelf = self;
    
    for (NSURL *selectedAssetURL in self.selectedAssetURLs) {
        [self.assetsLibrary assetForURL:selectedAssetURL
                            resultBlock:^(ALAsset *asset) {
                                
                                if (asset == nil) {
                                    return;
                                }
                                
                                // Add asset
                                [assets addObject:asset];
                                
                                // Check if the loading finished
                                if (assets.count == weakSelf.selectedAssetURLs.count) {
                                    
                                    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:[assets count]];
                                    YYAssetHandler *handle = nil;
                                    
                                    // reverse the array.
//                                    [assets reverse];
                                    
                                    for (ALAsset *asset in assets) {
                                        handle = [[YYAssetHandler alloc] initWithAsset:asset];
                                        [imageArray addSafeObject:[handle fullScreenImage]];
                                    }
                                    
                                    if (imageArray.count == 0) {
                                        return;
                                    }
                                    
//                                    [imageArray reverse];
                                    
                                    YYImagePickerPhotoGalleryViewController *viewController = [[YYImagePickerPhotoGalleryViewController alloc] initWithPhotoSource:self initialIndex:0 localUIImageArray:imageArray supportDelete:NO];
                                    viewController.isPushAnimation = YES;
                                    viewController.imagePickerDelegate = self;
                                    viewController.assets = assets;
                                    [self.navigationController pushViewController:viewController animated:YES];
                                    
                                }
                            } failureBlock:^(NSError *error) {
                                NSLog(@"Error: %@", [error localizedDescription]);
                            }];
    }
}

#pragma mark -
#pragma mark DataSource

- (void)reloadMyDataSource {
    [self.dataSource clear];
    
    NSMutableArray *cellItemsArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    for (int i = 0; i < self.assetsGroups.count; i ++) {
        ALAssetsGroup *assetsGroup = self.assetsGroups[i];
        YYImagePickerAssetGroupCellItem *cellItem = [[YYImagePickerAssetGroupCellItem alloc] init];
        cellItem.assetsGroup = assetsGroup;
        [cellItemsArray addSafeObject:cellItem];
    }
    
    [self.dataSource addCellItems:cellItemsArray];
}

#pragma mark -
#pragma mark TableView Template methond

- (void)cellDidSelectWithTableView:(UITableView *)tableView cellItem:(DDBaseCellItem *)cellItem cell:(DDBaseCell *)cell didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super cellDidSelectWithTableView:tableView cellItem:cellItem cell:cell didSelectRowAtIndexPath:indexPath];
    
    self.assetsCollectionViewController = [[YYAssetsCollectionViewController alloc] init];
    self.assetsCollectionViewController.imagePickerController = self;
    self.assetsCollectionViewController.filterType = self.filterType;
    self.assetsCollectionViewController.allowsMultipleSelection = self.allowsMultipleSelection;
    self.assetsCollectionViewController.minimumNumberOfSelection = self.minimumNumberOfSelection;
    self.assetsCollectionViewController.maximumNumberOfSelection = self.maximumNumberOfSelection;
    self.assetsCollectionViewController.maximumCustomAlertTitle = self.maximumCustomAlertTitle;
    
    ALAssetsGroup *assetsGroup = self.assetsGroups[indexPath.row];
    self.assetsCollectionViewController.delegate = self;
    self.assetsCollectionViewController.assetsGroup = assetsGroup;
    
    [self.selectedAssetURLs removeAllObjects];
    
//    for (NSURL *assetURL in self.selectedAssetURLs) {
//        [self.assetsCollectionViewController selectAssetHavingURL:assetURL];
//    }
    
    [self.navigationController pushViewController:self.assetsCollectionViewController animated:YES];
    
}

#pragma mark - YYAssetsCollectionViewControllerDelegate

- (void)assetsCollectionViewController:(YYAssetsCollectionViewController *)assetsCollectionViewController didSelectAsset:(ALAsset *)asset {
    if (self.allowsMultipleSelection) {
        // Add asset URL
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        [self.selectedAssetURLs addObject:assetURL];
        
        // Validation
        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:self.selectedAssetURLs.count];
    } else {
        // Delegate
        if (self.delegate && [self.delegate respondsToSelector:@selector(yy_imagePickerController:didSelectAsset:)]) {
            [self.delegate yy_imagePickerController:self didSelectAsset:asset];
        }
    }
}


- (void)assetsCollectionViewController:(YYAssetsCollectionViewController *)assetsCollectionViewController didDeselectAsset:(ALAsset *)asset {
    if (self.allowsMultipleSelection) {
        // Remove asset URL
        NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
        [self.selectedAssetURLs removeObject:assetURL];
        
        // Validation
        self.navigationItem.rightBarButtonItem.enabled = [self validateNumberOfSelections:self.selectedAssetURLs.count];
    }
}

- (void)assetsCollectionViewControllerDidFinishSelection:(YYAssetsCollectionViewController *)assetsCollectionViewController {
    [self passSelectedAssetsToDelegate];
}

- (void)assetsCollectionViewControllerShowPreview:(YYAssetsCollectionViewController *)assetsCollectionViewController {
    
//    YYMainSettingsViewController *viewController = [[YYMainSettingsViewController alloc] init];
//    [self.navigationController pushViewController:viewController animated:YES];
    
    [self showPreview];
    
}

#pragma mark -
#pragma mark YYPhotoGalleryViewControllerDelegate

- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoGalleryViewController *)gallery {
    return [self.selectedAssetURLs count];
}

#pragma mark -
#pragma mark YYImagePickerPhotoGalleryViewControllerDelegate

- (BOOL)yyImpagePickerPhotoGalleryChoose:(YYImagePickerPhotoGalleryViewController *)gallery choose:(BOOL)choose asset:(ALAsset *)asset {
    
    NSURL *assetURL = [asset valueForProperty:ALAssetPropertyAssetURL];
    if (choose) {
        [self.selectedAssetURLs addObject:assetURL];
    }
    else {
        [self.selectedAssetURLs removeObject:assetURL];
    }
    
//    [self.assetsCollectionViewController clearAll];
//    
//    for (NSURL *assetURL in self.selectedAssetURLs) {
//        [self.assetsCollectionViewController selectAssetHavingURL:assetURL];
//    }
    
//    [self.assetsCollectionViewController resetBottomButton];
    
    return YES;
}

- (void)yyImagePickerPhotoGalleryDone:(YYImagePickerPhotoGalleryViewController *)gallery {
    [self passSelectedAssetsToDelegate];
}

@end
