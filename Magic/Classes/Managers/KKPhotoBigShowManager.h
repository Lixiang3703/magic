//
//  KKPhotoBigShowManager.h
//  Link
//
//  Created by Lixiang on 14/12/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

@interface KKPhotoBigShowManager : DDSingletonObject

/** Singleton */
+ (KKPhotoBigShowManager *)getInstance;

- (void)showPublishControllerWithLocalImageArray:(NSArray *)localImageArray initialIndex:(NSInteger)initialIndex;
- (void)showPublishControllerWithImageItemArray:(NSArray *)imageItemArray initialIndex:(NSInteger)initialIndex;

@end
