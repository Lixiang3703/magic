//
//  YYAssetsCCell.h
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "DDBaseCollectionCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface YYAssetsCCell : DDBaseCollectionCell

@property (nonatomic, strong) ALAsset *asset;
@property (nonatomic, assign) BOOL showsOverlayViewWhenSelected;

@property (nonatomic, assign) BOOL shouldShowOverlayView;

@end
