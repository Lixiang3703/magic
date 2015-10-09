//
//  YYAssetsCollectionViewController.h
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "DDBaseCollectionViewController.h"

// ViewControllers
#import "YYImagePickerController.h"
#import "YYImagePickerDefine.h"



@class YYAssetsCollectionViewController;

@protocol YYAssetsCollectionViewControllerDelegate <NSObject>

@optional
- (void)assetsCollectionViewController:(YYAssetsCollectionViewController *)assetsCollectionViewController didSelectAsset:(ALAsset *)asset;
- (void)assetsCollectionViewController:(YYAssetsCollectionViewController *)assetsCollectionViewController didDeselectAsset:(ALAsset *)asset;
- (void)assetsCollectionViewControllerDidFinishSelection:(YYAssetsCollectionViewController *)assetsCollectionViewController;
- (void)assetsCollectionViewControllerShowPreview:(YYAssetsCollectionViewController *)assetsCollectionViewController;

@end

@interface YYAssetsCollectionViewController : DDBaseCollectionViewController

@property (nonatomic, weak) YYImagePickerController *imagePickerController;

@property (nonatomic, weak) id<YYAssetsCollectionViewControllerDelegate> delegate;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, assign) YYImagePickerControllerFilterType filterType;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *maximumCustomAlertTitle;

- (void)clearAll;
- (void)selectAssetHavingURL:(NSURL *)URL;
- (void)resetBottomButton;
@end
