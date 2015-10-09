//
//  DDMultiSet.h
//  Wuya
//
//  Created by w.vela on 14-5-16.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDMultiSet : NSObject

- (void)addObject:(id)anObject;
- (void)addObject:(id)anObject occurrences:(NSInteger)occur;
- (NSUInteger)count;
- (NSUInteger)countObject:(id)object;
- (NSArray *)allObjects;

@property (nonatomic, readonly) NSDictionary *dictionary;

+ (void)addObjectWithDict:(NSMutableDictionary *)dict object:(id)object;
+ (void)addObjectWithDict:(NSMutableDictionary *)dict object:(id)object occurrences:(NSInteger)occur;



@end
