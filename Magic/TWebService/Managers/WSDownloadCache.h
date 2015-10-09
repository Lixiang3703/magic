//
//  WSDownloadCache.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface WSDownloadCache : DDSingletonObject

/** Singleton */
+ (WSDownloadCache *)getInstance;
- (void)clearAllCache;
- (void)reset;

/** Cached Status */
- (BOOL)cacheDidExistWithUrl:(NSString *)url resource:(BOOL)resource;
- (NSString *)cachePathWithUrl:(NSString *)url resource:(BOOL)resource;

/** Copy Resource Locally */
- (void)moveItemsFromLocalForUrl:(NSString *)url resource:(BOOL)resource;

/** Cache Operations */
- (void)removeCacheForUrl:(NSString *)url resource:(BOOL)resource;

- (void)saveImage:(UIImage *)image headers:(NSDictionary *)headers forUrl:(NSString *)url;
- (UIImage *)imageWithUrl:(NSString *)url;

- (void)saveInfo:(NSDictionary *)info headers:(NSDictionary *)headers forUrl:(NSString *)url;
- (NSDictionary *)resultForUrl:(NSString *)url;
- (NSDictionary *)headersForUrl:(NSString *)url;

- (void)saveData:(NSData *)data headers:(NSDictionary *)headers forUrl:(NSString *)url;
- (NSData *)dataWithUrl:(NSString *)url;

/** Clear */
- (void)removeAllNonResourceCache;

@end
