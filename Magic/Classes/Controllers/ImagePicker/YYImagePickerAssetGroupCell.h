//
//  YYImagePickerAssetGroupCell.h
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYBaseCell.h"
#import "YYImagePickerThumbnailView.h"

@interface YYImagePickerAssetGroupCell : YYBaseCell

@property (nonatomic, strong) YYImagePickerThumbnailView *thumbnailView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *countLabel;

@end
