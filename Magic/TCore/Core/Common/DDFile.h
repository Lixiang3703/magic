//
//  DDFile.h
//  LuckyTRCore
//
//  Created by Tong on 30/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDFile : NSObject

+ (NSArray *)allLinesWithFileName:(NSString *)fileName type:(NSString *)type;
+ (NSArray *)allLinesWithFileName:(NSString *)fileName type:(NSString *)type encrypt:(BOOL)encrypt;

@end
