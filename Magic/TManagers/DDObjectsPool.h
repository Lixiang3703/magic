//
//  DDObjectsPool.h
//  Wuya
//
//  Created by Tong on 06/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface DDObjectsPool : DDSingletonObject

/** Singleton */
+ (DDObjectsPool *)getInstance;


/** ObjectsPool */
@property (nonatomic, strong) NSMutableSet *objectsPool;

@end
