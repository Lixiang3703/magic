//
//  KKImageItem.m
//  Link
//
//  Created by Lixiang on 14/11/3.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKImageItem.h"

@implementation KKImageItem


- (instancetype)initWithUrlOrigin:(NSString *)urlOrigin urlMiddle:(NSString *)urlMiddle urlSmall:(NSString *)urlSmall {
    self = [super init];
    if (self) {
        self.urlOrigin = urlOrigin;
        self.urlMiddle = urlMiddle;
        self.urlSmall = urlSmall;
    }
    return self;
}

+ (CGSize)imageSizeWithWidth:(CGFloat)width height:(CGFloat)height maxSide:(CGFloat)maxSide {
    CGFloat nWidth = 0;
    CGFloat nHeight = 0;
    if (0 == width || 0 == height) {
        //  Pass
    } else {
        if (width > height) {
            nWidth = MIN(maxSide, width);
            nHeight = maxSide * height / width;
            nHeight = MIN(nHeight, height);
            if (nWidth > 2 * nHeight) {
                nHeight = ceilf(nWidth / 2);
            }
        } else {
            nHeight = MIN(maxSide, height);
            nWidth = maxSide * width / height;
            nWidth = MIN(nWidth, width);
            if (nHeight > 2 * nWidth) {
                nWidth = ceilf(nHeight / 2);
            }
        }
    }
    
    return CGSizeMake(ceilf(nWidth / [[UIScreen mainScreen] scale]), ceilf(nHeight / [[UIScreen mainScreen] scale]));
}

@end
