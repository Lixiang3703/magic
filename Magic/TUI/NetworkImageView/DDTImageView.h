//
//  DDTImageView.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"

@interface DDTImageView : UIImageView

typedef void (^DDTImageBlock)(UIImageView *imageView, UIImage *image);

/** Initialization */
- (instancetype)initWithFrame:(CGRect)frame placeHolderImageName:(NSString *)placeHolderImageName;

/** ImageUrl */
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, strong) UIImage *placeHolderImage;

@property (nonatomic, assign) BOOL restImageViewbeforeLoad;
/** BackgroundColor */
@property (nonatomic, assign) BOOL alwaysClearBgColor;

/** Gif */
@property (nonatomic, assign) BOOL gif;

/** Load Image Operations */
- (void)loadImageWithUrl:(NSString *)imageUrl;
- (void)loadImageWithUrl:(NSString *)imageUrl localImage:(BOOL)localImage;
- (void)loadImageWithUrl:(NSString *)imageUrl localImage:(BOOL)localImage reuseCacheBlock:(DDTImageBlock)reuseCacheBlock successBlock:(DDTImageBlock)successBlock failedBlock:(DDTImageBlock)failedBlock;

/** MaskImageView */
@property (nonatomic, strong) UIImageView *maskImageView;

/** UI Logic */
- (void)resetImageView;

/** Local Image */
- (void)setLocalImage:(UIImage *)image;

@end
