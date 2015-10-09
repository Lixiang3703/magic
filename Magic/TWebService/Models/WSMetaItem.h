//
//  WSDDMetaItem.h
//  iPhone
//
//  Created by Cui Tong on 08/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "DDBaseItem.h"

@interface WSMetaItem : DDBaseItem

@property (nonatomic, assign) NSUInteger code;
@property (nonatomic, copy) NSString *hostname;
@property (nonatomic, assign) NSInteger cost;

@property (nonatomic, assign) NSTimeInterval timestamp;

@property (nonatomic, readonly) BOOL isErrorCode;



@end
