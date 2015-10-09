//
//  NSObject+Tools.h
//  PMP
//
//  Created by Tong on 06/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Tools)

+ (NSArray *)allProperties;
+ (NSArray *)selfProperties;

+ (NSString *)propertyType:(NSString *)propertyName;

@end
