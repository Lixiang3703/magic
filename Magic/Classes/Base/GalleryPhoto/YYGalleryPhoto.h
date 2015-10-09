//
//  YYGalleryPhoto.h
//  Wuya
//
//  Created by Lixiang on 14-9-16.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
	YYGalleryPhotoSizeThumbnail,
	YYGalleryPhotoSizeFullsize
} YYGalleryPhotoSize;

@protocol YYGalleryPhotoDelegate;

@interface YYGalleryPhoto : NSObject

@property (nonatomic, assign) NSUInteger tag;

@property (nonatomic, assign) BOOL useNetwork;
@property (nonatomic, readonly) BOOL isThumbLoading;
@property (nonatomic, readonly) BOOL hasThumbLoaded;

@property (nonatomic, readonly) BOOL isFullsizeLoading;
@property (nonatomic, readonly) BOOL hasFullsizeLoaded;

@property (nonatomic, strong) UIImage *thumbnail;
@property (nonatomic, strong) UIImage *fullsize;

@property (nonatomic,assign) id<YYGalleryPhotoDelegate> delegate;

- (instancetype)initWithImage:(UIImage *)image;

- (id)initWithThumbnailUrl:(NSString*)thumb fullsizeUrl:(NSString*)fullsize delegate:(id<YYGalleryPhotoDelegate>)delegate;
- (id)initWithThumbnailPath:(NSString*)thumb fullsizePath:(NSString*)fullsize delegate:(id<YYGalleryPhotoDelegate>)delegate;

- (void)loadThumbnail;
- (void)loadFullsize;

- (void)unloadFullsize;
- (void)unloadThumbnail;

@end



@protocol YYGalleryPhotoDelegate <NSObject>

@required
- (void)galleryPhoto:(YYGalleryPhoto*)photo didLoadThumbnail:(UIImage*)image;
- (void)galleryPhoto:(YYGalleryPhoto*)photo didLoadFullsize:(UIImage*)image;

@optional
- (void)galleryPhoto:(YYGalleryPhoto*)photo willLoadThumbnailFromUrl:(NSString*)url;
- (void)galleryPhoto:(YYGalleryPhoto*)photo willLoadFullsizeFromUrl:(NSString*)url;

- (void)galleryPhoto:(YYGalleryPhoto*)photo willLoadThumbnailFromPath:(NSString*)path;
- (void)galleryPhoto:(YYGalleryPhoto*)photo willLoadFullsizeFromPath:(NSString*)path;

- (void)galleryPhotoFailLoad:(YYGalleryPhoto *)photo;

@end
