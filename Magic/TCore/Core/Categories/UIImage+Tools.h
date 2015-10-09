//
//  UIImage+Tools.h
//  Wuya
//
//  Created by Tong on 14/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Tools)

@property (nonatomic, assign, readonly) CGFloat width;
@property (nonatomic, assign, readonly) CGFloat height;

- (void)writeToFile:(NSString *)filePath;

@end


@interface UIImage (Drawing)
- (UIImage *)reSize:(CGSize)size;
- (UIImage *)subImageAtRect:(CGRect)rect;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize;
+ (UIImage *)imageFromView:(UIView *)captureView size:(CGSize)size;
+ (UIImage *)imageFromView:(UIView *)captureView size:(CGSize)size backgroundImage:(UIImage *)backgroundImage;
- (UIImage *)squarize;

+ (UIImage *)mergeImageWithOrigin:(UIImage *)originImage mergeImage:(UIImage *)mergeImage rect:(CGRect)rect alpha:(CGFloat)alpha;
+ (UIImage *)combineImages:(NSArray *)images;

- (UIImage *)fixOrientation;
- (UIImage *)ordinaryCrop:(UIImage *)imageToCrop toRect:(CGRect)cropRect formCamera:(BOOL)fromCamera;
@end