//
//  DDTImageView+WebService.m
//  Wuya
//
//  Created by Tong on 14/08/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTImageView+WebService.h"
#import <objc/runtime.h>

@implementation DDTImageView (WebService)

- (AFHTTPRequestOperation *)imageRequestOperation {
    return (AFHTTPRequestOperation *)objc_getAssociatedObject(self, NSSelectorFromString(@"af_imageRequestOperation"));
}

@end
