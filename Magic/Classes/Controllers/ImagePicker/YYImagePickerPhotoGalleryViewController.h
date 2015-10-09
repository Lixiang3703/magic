//
//  YYImagePickerPhotoGalleryViewController.h
//  Wuya
//
//  Created by lixiang on 15/2/28.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "PhotoGalleryViewController.h"
#import "YYImagePickerDefine.h"
#import <AssetsLibrary/AssetsLibrary.h>

@protocol YYImagePickerPhotoGalleryViewControllerDelegate;

@interface YYImagePickerPhotoGalleryViewController : PhotoGalleryViewController

@property (weak, nonatomic) id <YYImagePickerPhotoGalleryViewControllerDelegate> imagePickerDelegate;

@property (nonatomic, strong) NSArray *assets;

@end

@protocol YYImagePickerPhotoGalleryViewControllerDelegate <NSObject>

@optional

- (BOOL)yyImpagePickerPhotoGalleryChoose:(YYImagePickerPhotoGalleryViewController *)gallery choose:(BOOL)choose asset:(ALAsset *)asset;

- (void)yyImagePickerPhotoGalleryDone:(YYImagePickerPhotoGalleryViewController *)gallery;

@end
