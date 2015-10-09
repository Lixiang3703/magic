//
//  DDSessionItem.h
//  PMP
//
//  Created by Tong on 20/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseItem.h"

@interface DDSessionItem : DDBaseItem

@property (nonatomic, copy) NSString *lastCrashedVCName;
@property (nonatomic, copy) NSString *lastCrashedVCNameFromCA;
@property (nonatomic, assign) NSTimeInterval startTimeStamp;
@property (nonatomic, assign) NSTimeInterval length;

@property (nonatomic, strong) NSMutableArray *userPathes;
@property (nonatomic, strong) NSMutableDictionary *serverFailRequestInfo;
@property (nonatomic, strong) NSMutableArray *events;
@property (nonatomic, strong) NSMutableDictionary *eventCounter;

- (void)sessionWillEnd;

@end
