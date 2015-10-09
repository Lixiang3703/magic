//
//  WSGlobal.h
//  DDAPI
//
//  Created by Cui Tong on 26/06/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WSDefinitions.h"
#import "NSError+WebService.h"
#import "WSDownloadCache.h"

@interface WSGlobal : NSObject

+ (void)globalSettings;

+ (void)clearCache;

@end
