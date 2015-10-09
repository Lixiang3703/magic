//
//  WSCertificationManager.h
//  Wuya
//
//  Created by Tong on 14/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface WSCertificationManager : DDSingletonObject

@property (nonatomic, strong) NSArray *certificates;
+ (WSCertificationManager *)getInstance;

@end
