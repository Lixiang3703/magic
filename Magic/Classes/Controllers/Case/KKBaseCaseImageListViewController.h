//
//  KKBaseCaseImageListViewController.h
//  Magic
//
//  Created by lixiang on 15/6/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseTableViewController.h"
#import "KKImageItem.h"
#import "KKPhotoUploadManager.h"
#import "KKPhotoBigShowManager.h"

@interface KKBaseCaseImageListViewController : YYBaseTableViewController

@property (nonatomic, assign) NSInteger caseId;
@property (nonatomic, strong) NSMutableArray *imageArray;

@end
