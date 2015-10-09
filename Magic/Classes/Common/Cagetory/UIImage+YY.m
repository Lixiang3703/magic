//
//  UIImage+YY.m
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIImage+YY.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (YY)

+ (UIImage *)yyMainBlackColorImage {
    return [[self class] yyImageWithColor:[UIColor YYMainTabbarColor]];
}

+ (UIImage *)yyImageWithColor:(UIColor *)color {
    UIImage *image = [UIImage imageWithColor:color];
    return [image stretchableImageWithLeftCapWidth:5 topCapHeight:5];
}

+ (UIImage *)yyLightUnderlineImage{
    UIImage *image = [UIImage imageNamed:@"underLine_tabbar_bgimage"];
    return [image stretchableImageWithLeftCapWidth:0 topCapHeight:20];
}

+ (UIImage *)yyDarkUnderlineImage{
    UIImage *image = [UIImage imageNamed:@"underLine_tabbarbutton_bgimage"];
    return [image stretchableImageWithLeftCapWidth:0 topCapHeight:20];
}


+ (UIImage *) blur:(UIImage *)theImage {
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:theImage.CGImage];
    
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:20.0f] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //create a UIImage for this function to "return" so that ARC can manage the memory of the blur...
    //ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}


@end
