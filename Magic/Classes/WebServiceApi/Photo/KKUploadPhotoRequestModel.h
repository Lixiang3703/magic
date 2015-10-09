//
//  KKUploadPhotoRequestModel.h
//  Magic
//
//  Created by lixiang on 15/5/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseRequestModel.h"
#import "KKImageItem.h"

@interface KKUploadPhotoRequestModel : YYBaseRequestModel

@property (atomic, strong) UIImage *image;
@property (nonatomic, assign) NSInteger entityId;
@property (nonatomic, assign) KKUploadPhotoType uploadPhotoType;

@property (nonatomic, strong) KKImageItem *imageItem;

@end
