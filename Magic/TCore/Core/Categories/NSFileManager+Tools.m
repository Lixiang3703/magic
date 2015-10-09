//
//  NSFileManager+Tools.m
//  Wuya
//
//  Created by Tong on 15/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSFileManager+Tools.h"

@implementation NSFileManager (Tools)

- (void)touchDirectoryAtPath:(NSString *)path {
    BOOL exists = [self fileExistsAtPath:path];
    if (!exists) {
        [self createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
}

@end
