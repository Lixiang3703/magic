//
//  KKBroadcastItem.h
//  Magic
//
//  Created by lixiang on 15/5/7.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKDynamicItem.h"
#import "KKImageItem.h"

@interface KKBroadcastItem : KKDynamicItem

@property (nonatomic, copy) NSString *image;

@property (nonatomic, strong) KKImageItem *imageItem;

@end
