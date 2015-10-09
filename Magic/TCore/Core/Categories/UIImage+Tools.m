//
//  UIImage+Tools.m
//  Wuya
//
//  Created by Tong on 14/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIImage+Tools.h"

@implementation UIImage (Tools)

- (CGFloat)width {
    return self.size.width;
}

- (CGFloat)height {
    return self.size.height;
}

- (void)writeToFile:(NSString *)filePath {
    NSData *data = UIImageJPEGRepresentation(self, 1);
    [data writeToFile:filePath atomically:YES];
}

@end


@implementation UIImage (Drawing)

- (UIImage *)reSize:(CGSize)size {
    return [self scaleToSize:size force:NO];
}

- (UIImage *)scaleToSize:(CGSize)size force:(BOOL)force {
    if (size.width >= self.size.width - 2 && size.width <= self.size.width + 2 &&
        size.height >= self.size.height - 2 && size.height <= self.size.height + 2) { // 两个像素的误差
        return self;
    }
    if (size.width >= self.size.width - 2 && size.height >= self.size.height - 2) { // 两个像素的误差
        if (!force) {
            return self;
        }
    }
    CGSize newSize;
    if (size.width/size.height > self.size.width/self.size.height) { // 高度优先
        newSize.height = size.height;
        newSize.width = self.size.width/self.size.height*newSize.height;
    } else { // 宽度优先
        newSize.width = size.width;
        newSize.height = self.size.height/self.size.width*newSize.width;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, floorf(newSize.width)+1, floorf(newSize.height)+1)];
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

- (UIImage *)subImageAtRect:(CGRect)rect {
    
	rect = CGRectMake(rect.origin.x * self.scale, rect.origin.y * self.scale, rect.size.width * self.scale, rect.size.height * self.scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    CGImageRelease(imageRef);
    
    return subImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size andRoundSize:(CGFloat)roundSize {
    
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (roundSize > 0) {
        UIBezierPath* roundedRectanglePath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius: roundSize];
        [color setFill];
        [roundedRectanglePath fill];
    } else {
        CGContextSetFillColorWithColor(context, [color CGColor]);
        CGContextFillRect(context, rect);
        
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


+ (UIImage *)imageFromView:(UIView *)captureView size:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    [captureView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedImage;
}

+ (UIImage *)imageFromView:(UIView *)captureView size:(CGSize)size backgroundImage:(UIImage *)backgroundImage {
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    [backgroundImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
    [captureView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *capturedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return capturedImage;
}

/*
 * 用来把非方图加上宽荧幕背景
 */
- (UIImage *)squarize {
    CGFloat maxSide = MAX(self.size.width, self.size.height);
    if (self.size.width != self.size.height) {
        NSArray *images = @[[UIImage imageNamed:@"black_bg.jpg"], self];
        CGRect bgRect = ccr(0, 0, maxSide, maxSide);
        
        CGRect postImageRect;
        if (self.size.width > self.size.height) {
            CGFloat topFactor = (1 - self.size.height / self.size.width) / 2;
            CGFloat heightFactor = self.size.height / self.size.width;
            postImageRect = ccr(0, maxSide * topFactor, maxSide, maxSide * heightFactor);
        } else {
            CGFloat leftFactor = (1 - self.size.width / self.size.height) / 2;
            CGFloat widthFactor = self.size.width / self.size.height;
            postImageRect = ccr(maxSide * leftFactor, 0, maxSide * widthFactor, maxSide);
        }
        
        CGRect rects[] = {bgRect, postImageRect};
        CGSize contextSize = bgRect.size;
        
        return [UIImage mergeImages:images rects:rects contextSize:contextSize];
    } else {
        return self;
    }
}

+ (UIImage *)mergeImages:(NSArray *)images rects:(CGRect *)rects contextSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    for (uint i=0; i<images.count; i++) {
        UIImage *image = [images objectAtIndex:i];
        CGRect rect = rects[i];
        [image drawInRect:rect];
    }
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}

+ (UIImage *)mergeImageWithOrigin:(UIImage *)originImage mergeImage:(UIImage *)mergeImage rect:(CGRect)rect alpha:(CGFloat)alpha{
    UIGraphicsBeginImageContextWithOptions(originImage.size, YES, 0.0f);
    [originImage drawInRect:ccr(0, 0, originImage.size.width, originImage.size.height)];
    [mergeImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:alpha];
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}


+ (UIImage *)combineImages:(NSArray *)images
{
    CGFloat sizeWidth = 0;
    CGFloat sizeHeight = 0;
    for (uint i=0; i<images.count; i++) {
        UIImage *image = [images objectAtIndex:i];
        if (sizeWidth < image.size.width) {
            sizeWidth = image.size.width;
        }
        sizeHeight += image.size.height;
    }
    CGSize size = CGSizeMake(sizeWidth, sizeHeight);
    UIGraphicsBeginImageContextWithOptions(size, YES, 0.0f);
    CGFloat y = 0;
    for (uint i=0; i<images.count; i++) {
        UIImage *image = [images objectAtIndex:i];
        [image drawInRect:CGRectMake(0, y, image.size.width, image.size.height)];
        y += image.size.height;
    }
    
    UIImage *resultImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImg;
}


- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

//iOS 8上系统相机截图按照比例偏移(以320长宽计算 偏移20像素)(ugly:相机向下偏 相册往上偏)
- (UIImage *)ordinaryCrop:(UIImage *)imageToCrop toRect:(CGRect)cropRect formCamera:(BOOL)fromCamera{
    CGFloat height = cropRect.size.height;
    CGFloat offset = height *(20.0/320);
    CGRect fixRect = CGRectMake(cropRect.origin.x, cropRect.origin.y + (fromCamera? ceilf(offset) : -ceilf(offset)), cropRect.size.width, cropRect.size.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([imageToCrop CGImage], fixRect);
    UIImage *cropped = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return cropped;
}

@end



