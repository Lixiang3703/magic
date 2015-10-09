//
//  DDTImageView+WebService.h
//  Wuya
//
//  Created by Tong on 14/08/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTImageView.h"
#import "AFHTTPRequestOperation.h"

@class AFHTTPRequestOperation;

@interface DDTImageView (WebService)

@property (nonatomic, strong, readonly) AFHTTPRequestOperation *imageRequestOperation;

@end
