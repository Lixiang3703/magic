//
//  DDBaseItemFactory.m
//  Wuya
//
//  Created by Tong on 06/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDItemFactory.h"

@interface DDItemFactory ()

@property (atomic, strong) NSMapTable *items;

@end

@implementation DDItemFactory
SYNTHESIZE_SINGLETON_FOR_CLASS(DDItemFactory);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Initialzation
- (instancetype)init {
    self = [super init];
    if (self) {
        self.items = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsStrongMemory valueOptions:NSPointerFunctionsWeakMemory capacity:10];
    }
    return self;
}

#pragma mark -
#pragma mark Factory Methods

- (id)itemWithInfo:(NSDictionary *)info class:(Class)itemClass {
    if (![info isKindOfClass:[NSDictionary class]] || [info count] == 0) {
        return nil;
    }
    return [self itemWithId:[info objectForSafeKey:@"id"] info:info class:itemClass];
}

- (id)itemWithId:(NSString *)Id class:(Class)itemClass {
    if (nil == Id) {
        return nil;
    }
    return [self itemWithId:Id info:nil class:itemClass];
}

- (id)itemWithId:(NSString *)Id info:(NSDictionary *)info class:(Class)itemClass {
    DDBaseItem *baseItem = [self.items objectForKey:[self keyWithId:Id itemClass:itemClass]];
    if (nil == baseItem) {
        baseItem = [[itemClass alloc] initWithDict:info];
        [self.items setObject:baseItem forKey:[self keyWithId:Id itemClass:itemClass]];
    } else if ([info count] > 0){
        [baseItem copyValuesFromDict:info];
    }
    
    return baseItem;
}

#pragma mark -
#pragma mark key
- (NSString *)keyWithId:(NSString *)Id itemClass:(Class)itemClass {
    return [NSString stringWithFormat:@"%@|%@", Id, [itemClass description]];
}


#pragma mark -
#pragma mark Notification
- (void)appWillLogout:(NSNotification *)notification {
    [self.items removeAllObjects];
}

- (void)appDidPurge:(NSNotification *)notification {
    [self.items removeAllObjects];
}


@end
