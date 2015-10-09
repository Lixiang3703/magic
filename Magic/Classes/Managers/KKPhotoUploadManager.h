//
//  KKPhotoUploadManager.h
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

@interface KKPhotoUploadManager : DDSingletonObject

/** Singleton */
+ (KKPhotoUploadManager *)getInstance;

@property (nonatomic, assign) NSInteger uploadMaxCount;

- (void)uploadPhotoWithType:(KKUploadPhotoType)uploadPhotoType entityId:(NSInteger)entityId withMaxCount:(NSInteger)maxCount;

- (void)uploadPhotoWithType:(KKUploadPhotoType)uploadPhotoType entityId:(NSInteger)entityId;@end
