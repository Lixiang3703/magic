//
//  KKAudioItem.h
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKAudioItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *localFilePath;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSInteger length;

@end
