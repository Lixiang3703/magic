//
//  YYBaseAPIItem.h
//  Wuya
//
//  Created by Tong on 15/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseItem.h"

@interface YYBaseAPIItem : DDBaseItem

@property (nonatomic, copy) NSString *ddId;
@property (nonatomic, assign) NSInteger kkId;
@property (nonatomic, assign) BOOL fake;


@property (nonatomic, assign) DDBaseItemBool deleted;
@property (nonatomic, assign) NSTimeInterval insertTimestamp;
@property (nonatomic, assign) NSTimeInterval updateTimestamp;

@end
