//
//  DDBaseCollectionCell.h
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICollectionViewCell+DDCollectionView.h"
#import "DDCollectionView.h"

@class DDBaseCollectionCellItem;

@protocol DDBaseCollectionCellImageShowing <NSObject>

- (void)showImagesWithCellItem:(id)cellItem;

@end

@protocol DDBaseCollectionCellActions <NSObject>

@end


@interface DDBaseCollectionCell : UICollectionViewCell <DDBaseCollectionCellImageShowing>

@property (nonatomic, assign, getter=isFirstAssignValues) BOOL firstAssignValues;

- (void)initSettings;

- (void)setValuesWithCellItem:(DDBaseCollectionCellItem *)cellItem;
- (void)firstAssignValuesSettingsWithCellItem:(DDBaseCollectionCellItem *)cellItem;

@end
