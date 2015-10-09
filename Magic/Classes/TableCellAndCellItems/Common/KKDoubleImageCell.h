//
//  KKDoubleImageCell.h
//  Magic
//
//  Created by lixiang on 15/6/3.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseCell.h"

#import "KKImageItem.h"
#import "DDTImageView.h"

@protocol KKDoubleImageCellActions <DDBaseCellActions>

@required
- (void)kkDoubleImageCellImageViewPressed:(NSDictionary*)info;
- (void)kkDoubleImageCellAddButtonPressed:(NSDictionary*)info;

@end

@interface KKDoubleImageCell : YYBaseCell

@property (nonatomic, strong) NSMutableArray *imageArray;

@property (nonatomic, strong) UIButton *addPhotoButton;
@end
