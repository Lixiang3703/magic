//
//  YYAssetCFlowLayout.m
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetsCFlowLayout.h"

#define kAssetOneImageItemWidth         (3)

@implementation YYAssetsCFlowLayout

#pragma mark -
#pragma mark Init
- (instancetype)init {
    self = [super init];
    if (self) {
        
        CGFloat width = [UIDevice screenWidth] / 4 - kAssetOneImageItemWidth;
        
        self.itemSize = CGSizeMake(width, width);
        self.headerReferenceSize = CGSizeMake(0, kAssetOneImageItemWidth);
        self.footerReferenceSize = CGSizeMake(0, kAssetOneImageItemWidth);
        self.minimumInteritemSpacing = kAssetOneImageItemWidth;
        self.minimumLineSpacing = kAssetOneImageItemWidth;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

@end
