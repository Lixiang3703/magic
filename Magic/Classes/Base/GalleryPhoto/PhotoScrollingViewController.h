//
//  PhotoScrollingViewController.h
//  Wuya
//
//  Created by Lixiang on 14-9-15.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYBaseViewController.h"

#import "YYGalleryPhotoView.h"
#import "YYGalleryPhoto.h"

typedef void (^GalleryPhotoBlock)(id userInfo);

@protocol PhotoGalleryViewControllerDelegate;

@interface PhotoScrollingViewController : YYBaseViewController<YYGalleryPhotoDelegate,YYGalleryPhotoViewDelegate>

@property (nonatomic, assign) BOOL isLocalUIImages;
@property (nonatomic, strong) NSArray *localUIImageArray;

@property (nonatomic, assign) BOOL isPushAnimation;

@property (nonatomic, assign) BOOL supportDelete;
@property (assign, nonatomic) CGFloat prevNextButtonSize;
@property (nonatomic, strong) NSMutableArray *barItemsArray;

@property (nonatomic, strong) NSMutableArray *photoViewsArray;
@property (nonatomic, strong) NSMutableDictionary *photoLoadersDictionary;

@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, assign) BOOL isFullscreen;
@property (nonatomic, assign) BOOL isActive;

@property (nonatomic, assign) NSInteger currentIndex;

@property (weak, nonatomic) id <PhotoGalleryViewControllerDelegate> photoSource;

- (id)initWithPhotoSource:(id<PhotoGalleryViewControllerDelegate>)photoSrc;
- (id)initWithPhotoSource:(id<PhotoGalleryViewControllerDelegate>)photoSrc initialIndex:(NSInteger)initialIndex;
- (void)reloadGallery;
- (void)reloadGalleryWithIndex:(NSInteger)gotoIndex;
- (void)gotoImageByIndex:(NSUInteger)index animated:(BOOL)animated;

@end

@protocol PhotoGalleryViewControllerDelegate <NSObject>

@required
- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoScrollingViewController *)gallery;

@optional
- (NSString*)photoGallery:(PhotoScrollingViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index;

// the photosource must implement one of these methods depending on which FGalleryPhotoSourceType is specified
- (NSString*)photoGallery:(PhotoScrollingViewController *)gallery filePathForPhotoSize:(YYGalleryPhotoSize)size atIndex:(NSUInteger)index;
- (NSString*)photoGallery:(PhotoScrollingViewController *)gallery urlForPhotoSize:(YYGalleryPhotoSize)size atIndex:(NSUInteger)index;
- (BOOL)photoGalleryDeletePhoto:(PhotoScrollingViewController *)gallery
                        atIndex:(NSUInteger)index
                   successBlock:(GalleryPhotoBlock)successblock
                    failedBlock:(GalleryPhotoBlock)failedblock;
- (void)photoGalleryViewControllerWillDismiss:(PhotoScrollingViewController *)gallery touched:(BOOL)touched;

@end

