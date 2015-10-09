//
//  DDObjectsPool.m
//  Wuya
//
//  Created by Tong on 06/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDObjectsPool.h"

@interface DDObjectsPool ()


@end

@implementation DDObjectsPool
SYNTHESIZE_SINGLETON_FOR_CLASS(DDObjectsPool);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.objectsPool = [NSMutableSet set];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidReceiveMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return self;
}

- (void)applicationDidReceiveMemoryWarningNotification:(NSNotification *)notification {
    [self.objectsPool removeAllObjects];
}

@end
