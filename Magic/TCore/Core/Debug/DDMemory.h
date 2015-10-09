//
//  DDMemory.h
//  LuckyTRCore
//
//  Created by Tong on 30/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

/**
 * fix performSelector leaks warning
 */

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


@interface DDMemory : NSObject


@end