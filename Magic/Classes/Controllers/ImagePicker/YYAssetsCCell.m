//
//  YYAssetsCCell.m
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetsCCell.h"

// Views
#import "YYAssetsCollectionOverlayView.h"
#import "YYAssetsCollectionVideoIndicatorView.h"

#import "YYAssetsCCellItem.h"

@interface YYAssetsCCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) YYAssetsCollectionOverlayView *overlayView;
@property (nonatomic, strong) YYAssetsCollectionVideoIndicatorView *videoIndicatorView;

@property (nonatomic, strong) UIImage *blankImage;

@end

@implementation YYAssetsCCell

- (void)initSettings{
    [super initSettings];
    
    self.showsOverlayViewWhenSelected = YES;
    
    // Create a image view
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:imageView];
    self.imageView = imageView;
}

- (void)setValuesWithCellItem:(YYAssetsCCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];
    
    self.showsOverlayViewWhenSelected = cellItem.showsOverlayViewWhenSelected;
    self.asset = cellItem.asset;
    
    self.shouldShowOverlayView = cellItem.shouldShowOverlayView;
    
    if (cellItem.shouldShowOverlayView) {
        [self showOverlayView];
    }
    else {
        [self hideOverlayView];
    }
}


- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    
    // Show/hide overlay view
    if (selected && self.showsOverlayViewWhenSelected) {
        [self showOverlayView];
    } else {
        [self hideOverlayView];
    }
}


#pragma mark - Overlay View

- (void)showOverlayView
{
    [self hideOverlayView];
    
    YYAssetsCollectionOverlayView *overlayView = [[YYAssetsCollectionOverlayView alloc] initWithFrame:self.contentView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.contentView addSubview:overlayView];
    self.overlayView = overlayView;
}

- (void)hideOverlayView
{
    if (self.overlayView) {
        [self.overlayView removeFromSuperview];
        self.overlayView = nil;
    }
}


#pragma mark - Video Indicator View

- (void)showVideoIndicatorView
{
    CGFloat height = 19.0;
    CGRect frame = CGRectMake(0, CGRectGetHeight(self.bounds) - height, CGRectGetWidth(self.bounds), height);
    YYAssetsCollectionVideoIndicatorView *videoIndicatorView = [[YYAssetsCollectionVideoIndicatorView alloc] initWithFrame:frame];
    videoIndicatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    videoIndicatorView.duration = [[self.asset valueForProperty:ALAssetPropertyDuration] doubleValue];
    
    [self.contentView addSubview:videoIndicatorView];
    self.videoIndicatorView = videoIndicatorView;
}

- (void)hideVideoIndicatorView
{
    if (self.videoIndicatorView) {
        [self.videoIndicatorView removeFromSuperview];
        self.videoIndicatorView = nil;
    }
}


#pragma mark - Accessors

- (void)setAsset:(ALAsset *)asset
{
    _asset = asset;
    
    // Update view
    CGImageRef thumbnailImageRef = [asset thumbnail];
    
    if (thumbnailImageRef) {
        self.imageView.image = [UIImage imageWithCGImage:thumbnailImageRef];
    } else {
        self.imageView.image = [self blankImage];
    }
    
    // Show video indicator if the asset is video
    if ([[asset valueForProperty:ALAssetPropertyType] isEqualToString:ALAssetTypeVideo]) {
        [self showVideoIndicatorView];
    } else {
        [self hideVideoIndicatorView];
    }
}

- (UIImage *)blankImage
{
    if (_blankImage == nil) {
        CGSize size = CGSizeMake(100.0, 100.0);
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
        
        [[UIColor colorWithWhite:(240.0 / 255.0) alpha:1.0] setFill];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        
        _blankImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
    }
    
    return _blankImage;
}

@end
