//
//  PhotoGalleryViewController.h
//  Wuya
//
//  Created by Lixiang on 14/12/25.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYBaseViewController.h"
#import "YYGalleryPhotoView.h"
#import "YYGalleryPhoto.h"

#define kPhotoGalleryToolbarHeight      (44)

#define kPhotoGalleryContentView_margin_left      (5)
#define kPhotoGalleryContentView_margin_top      (5)
#define kPhotoGalleryContentLabel_fontSize      (13)

typedef void (^PhotoGalleryBlock)(id userInfo);

@protocol YYPhotoGalleryViewControllerDelegate;


@interface PhotoGalleryViewController : YYBaseViewController

@property (nonatomic, assign) BOOL isLocalUIImages;
@property (nonatomic, strong) NSArray *localUIImageArray;

@property (nonatomic, assign) BOOL isPushAnimation;
@property (nonatomic, assign) BOOL supportDelete;
@property (nonatomic, assign) BOOL toolbarHide;

@property (nonatomic, strong) NSMutableArray *photoViewsArray;
@property (nonatomic, strong) NSMutableDictionary *photoLoadersDictionary;

@property (nonatomic, assign) BOOL isScrolling;
@property (nonatomic, assign) BOOL isFullscreen;
@property (nonatomic, assign) BOOL isActive;

@property (nonatomic, assign) NSInteger currentIndex;

@property (weak, nonatomic) id <YYPhotoGalleryViewControllerDelegate> photoSource;

// UI
@property (nonatomic, strong) UIView *innerContainer;
@property (nonatomic, strong) UINavigationBar *naviBar;
@property (nonatomic, strong) UIView *naviView;
@property (nonatomic, strong) UILabel *naviTitleLabel;

@property (nonatomic, strong) UIToolbar *toolBar;

@property (nonatomic, strong) UIView *statusBarView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UITextView *contentTextView;
@property (nonatomic, assign) CGFloat contentViewHeight;

- (instancetype)initWithPhotoSource:(id<YYPhotoGalleryViewControllerDelegate>)photoSrc;
- (instancetype)initWithPhotoSource:(id<YYPhotoGalleryViewControllerDelegate>)photoSrc initialIndex:(NSInteger)initialIndex;
- (instancetype)initWithPhotoSource:(id<YYPhotoGalleryViewControllerDelegate>)photoSrc initialIndex:(NSInteger)initialIndex localUIImageArray:(NSArray *)uiImageArray supportDelete:(BOOL)supportDelete;

- (void)reloadGallery;
- (void)updateOnePhotoContent;
- (void)delButtonPressed:(id)sender;
- (void)delButtonLongPressed:(id)sender;
- (void)deleteAction;
@end

@protocol YYPhotoGalleryViewControllerDelegate <NSObject>

@required
- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoGalleryViewController *)gallery;

@optional
- (NSString*)photoGallery:(PhotoGalleryViewController *)gallery captionForPhotoAtIndex:(NSUInteger)index;
- (NSString*)photoGallery:(PhotoGalleryViewController *)gallery contentForPhotoAtIndex:(NSUInteger)index;

// the photosource must implement one of these methods depending on which FGalleryPhotoSourceType is specified
- (NSString*)photoGallery:(PhotoGalleryViewController *)gallery filePathForPhotoSize:(YYGalleryPhotoSize)size atIndex:(NSUInteger)index;
- (NSString*)photoGallery:(PhotoGalleryViewController *)gallery urlForPhotoSize:(YYGalleryPhotoSize)size atIndex:(NSUInteger)index;

- (BOOL)photoGalleryDeletePhoto:(PhotoGalleryViewController *)gallery atIndex:(NSUInteger)index successBlock:(PhotoGalleryBlock)successblock failedBlock:(PhotoGalleryBlock)failedblock;

- (void)photoGalleryViewControllerWillDismiss:(PhotoGalleryViewController *)gallery touched:(BOOL)touched;

- (void)photoGalleryViewControllerDidDismiss:(PhotoGalleryViewController *)gallery;

- (BOOL)photoGalleryViewControllerHasNextItem:(PhotoGalleryViewController *)gallery;
- (void)photoGalleryViewControllerDidLoadLastItem:(PhotoGalleryViewController *)gallery;

@end