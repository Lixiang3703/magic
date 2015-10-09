//
//  KKClassicsItem.h
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKImageItem.h"

@interface KKClassicsItem : YYBaseAPIItem

@property (nonatomic, assign) NSInteger industryId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, copy) NSString *custom;

@property (nonatomic, strong) KKImageItem *imageItem;

@end
