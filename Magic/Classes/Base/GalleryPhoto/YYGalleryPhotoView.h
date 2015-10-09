//
//  YYGalleryPhotoView.h
//  Wuya
//
//  Created by Lixiang on 14-9-16.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYGalleryPhotoViewDelegate;

@interface YYGalleryPhotoView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, assign) id<YYGalleryPhotoViewDelegate> photoDelegate;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIActivityIndicatorView *activity;

@property (nonatomic, assign) BOOL isZoomed;
@property (nonatomic, strong) NSTimer *tapTimer;

- (void)killActivityIndicator;

// inits this view to have a button over the image
- (id)initWithFrame:(CGRect)frame target:(id)target action:(SEL)action;
- (void)resetZoom;

@end

@protocol YYGalleryPhotoViewDelegate <NSObject>

// indicates single touch and allows controller repsond and go toggle fullscreen
- (void)didTapPhotoView:(YYGalleryPhotoView*)photoView;

@end