//
//  YYImagePickerViewController.h
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "YYBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, YYImagePickerControllerFilterType) {
    YYImagePickerControllerFilterTypeNone,
    YYImagePickerControllerFilterTypePhotos,
    YYImagePickerControllerFilterTypeVideos
};

UIKIT_EXTERN ALAssetsFilter * ALAssetsFilterFromYYImagePickerControllerFilterType(YYImagePickerControllerFilterType type);

@class YYImagePickerController;

@protocol YYImagePickerControllerDelegate <NSObject>

@optional
- (void)yy_imagePickerController:(YYImagePickerController *)imagePickerController didSelectAsset:(ALAsset *)asset;
- (void)yy_imagePickerController:(YYImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets;
- (void)yy_imagePickerControllerDidCancel:(YYImagePickerController *)imagePickerController;

@end

@interface YYImagePickerController : YYBaseTableViewController

@property (nonatomic, strong, readonly) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, copy, readonly) NSArray *assetsGroups;
@property (nonatomic, strong, readonly) NSMutableOrderedSet *selectedAssetURLs;

@property (nonatomic, weak) id<YYImagePickerControllerDelegate> delegate;
@property (nonatomic, copy) NSArray *groupTypes;
@property (nonatomic, assign) YYImagePickerControllerFilterType filterType;
@property (nonatomic, assign) BOOL showsCancelButton;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) NSUInteger minimumNumberOfSelection;
@property (nonatomic, assign) NSUInteger maximumNumberOfSelection;

@property (nonatomic, copy) NSString *maximumCustomAlertTitle;
+ (BOOL)isAccessible;

@end
