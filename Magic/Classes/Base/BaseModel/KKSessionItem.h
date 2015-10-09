//
//  KKSessionItem.h
//  Magic
//
//  Created by lixiang on 15/4/9.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDBaseItem.h"

@interface KKSessionItem : DDBaseItem

@property (nonatomic, copy) NSString *lastCrashedVCName;

@property (nonatomic, assign) NSTimeInterval startTimeStamp;
@property (nonatomic, assign) NSTimeInterval length;
@property (nonatomic, strong) NSMutableArray *userPathes;

- (void)sessionWillEnd;
@end
