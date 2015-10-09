//
//  YYTakePhotoViewController.h
//  Mood
//
//  Created by Tong on 18/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "YYBaseViewController.h"
#import "DDTImageView.h"

@interface YYTakePhotoViewController : YYBaseViewController

- (instancetype)initWithViewFrame:(CGRect)viewFrame;

@property (nonatomic, strong) DDTImageView *photoImageView;
@property (nonatomic, readonly) UIImage *selectedImage;
- (void)revertImageView;

@property (nonatomic, assign, getter = isImagePickerDidFinish) BOOL imagePickerDidFinish;

@property (nonatomic, copy) DDBlock imagePickerDidFinishBlock;
@property (nonatomic, copy) DDBlock imagePickerDidCancelBlock;

@end
