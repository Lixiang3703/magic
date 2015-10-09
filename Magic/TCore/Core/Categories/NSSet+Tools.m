//
//  NSSet+Tools.m
//  Wuya
//
//  Created by Tong on 22/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSSet+Tools.h"

@implementation NSMutableSet (Tools)

- (void)addSafeObject:(id)object {
    if (nil != object) {
        [self addObject:object];
    }
}

@end
