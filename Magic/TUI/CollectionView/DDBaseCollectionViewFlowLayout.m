//
//  DDCollectionViewLayout.m
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseCollectionViewFlowLayout.h"

@interface DDBaseCollectionViewFlowLayout ()

@end

@implementation DDBaseCollectionViewFlowLayout

#pragma mark -
#pragma mark Init
- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake([UIDevice screenWidth], [UIDevice screenWidth]);
        
        self.headerReferenceSize = CGSizeMake(20, 30);
        self.footerReferenceSize = CGSizeMake(40, 30);

        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
