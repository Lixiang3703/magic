//
//  UICollectionViewCell+DDCollectionView.h
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDBaseCollectionCellItem;
@class DDCollectionView;

@interface UICollectionViewCell (DDCollectionView)

- (DDCollectionView *)ddCollectionView;

@end
