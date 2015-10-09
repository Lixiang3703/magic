//
//  DDMultiSet.m
//  Wuya
//
//  Created by w.vela on 14-5-16.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "DDMultiSet.h"

@interface DDMultiSet()

@property (nonatomic, strong) NSMutableDictionary *innerDictionary;

@end

@implementation DDMultiSet

- (NSDictionary *)dictionary {
    return self.innerDictionary;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.innerDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addObject:(id)anObject {
    [self addObject:anObject occurrences:1];
}

- (void)addObject:(id)anObject occurrences:(NSInteger)occur {
    [DDMultiSet addObjectWithDict:self.innerDictionary object:anObject occurrences:1];
}

- (NSUInteger)count {
    return [self.innerDictionary count];
}

- (NSUInteger)countObject:(id)object {
    id occur = [self.innerDictionary objectForKeyedSubscript:object];
    if (nil == occur) {
        return 0;
    } else {
        return [occur integerValue];
    }
}

- (NSArray *)allObjects {
     return [self.innerDictionary allKeys];
}

- (NSDictionary *)allObjectsWithOccurrence {
    return self.innerDictionary;
}

+ (void)addObjectWithDict:(NSMutableDictionary *)dict object:(id)object {
    [DDMultiSet addObjectWithDict:dict object:object occurrences:1];
}

+ (void)addObjectWithDict:(NSMutableDictionary *)dict object:(id)anObject occurrences:(NSInteger)occur {
    id occurObject = [dict objectForSafeKey:anObject];
    if (nil == occurObject) {
        [dict setObject:@(1) forKey:anObject];
    } else {
        [dict setObject:@([occurObject integerValue] + occur) forKey:anObject];
    }
}

@end
