//
//  UICollectionViewCell+DDCollectionView.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "UICollectionViewCell+DDCollectionView.h"
#import "DDCollectionView.h"

@implementation UICollectionViewCell (DDCollectionView)


//  Sometimes, it might be nil
- (DDCollectionView *)ddCollectionView {
    id view = [self superview];
    
    while (view && ![view isKindOfClass:[DDCollectionView class]]) {
        view = [view superview];
    }
    
    return (DDCollectionView *)view;
}


@end
