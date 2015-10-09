//
//  DDBaseItemFactory.h
//  Wuya
//
//  Created by Tong on 06/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface DDItemFactory : DDSingletonObject

/** Singleton */
+ (DDItemFactory *)getInstance;

- (id)itemWithInfo:(NSDictionary *)info class:(Class)itemClass;
- (id)itemWithId:(NSString *)Id class:(Class)itemClass;

@end
