//
//  WSDownloadCache.m
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "WSDownloadCache.h"
#import <CommonCrypto/CommonHMAC.h>

static NSString *kCache_StorageIndex = @"kCache_StorageIndex";

static NSString *kCache_CacheFolder = @"DDCache";
static NSString *kCache_CacheFolder_API = @"DDAPI";
static NSString *kCache_CacheFolder_Resource = @"DDResource";

@interface WSDownloadCache ()

@property (atomic, readwrite) NSInteger storageIndex;
@property (atomic, copy) NSString *storagePath;
@property (atomic, copy) NSString *storagePathAPI;
@property (atomic, copy) NSString *storagePathResource;
@property (strong) NSRecursiveLock *accessLock;


@end

@implementation WSDownloadCache
SYNTHESIZE_SINGLETON_FOR_CLASS(WSDownloadCache);

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        
        self.accessLock = [[NSRecursiveLock alloc] init];
        
        [self reset];
    }
    return self;
}

- (void)clearAllCache {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *storagePath = self.storagePath;
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
		
        NSError *error = nil;
        [fileManager removeItemAtPath:storagePath error:&error];
		
		dispatch_async(dispatch_get_main_queue(), ^{
            DDLog(@"Clear Done storagePath %@", storagePath);
		});
		
	});
    //
    self.storageIndex ++;
    [self reset];
}


- (void)reset {
    self.storagePath = [NSString filePathOfCachesFolderWithName:[NSString stringWithFormat:@"%@%ld", kCache_CacheFolder, (long)self.storageIndex]];
    self.storagePathAPI = [self.storagePath stringByAppendingPathComponent:kCache_CacheFolder_API];
    self.storagePathResource = [self.storagePath stringByAppendingPathComponent:kCache_CacheFolder_Resource];

    [[NSFileManager defaultManager] touchDirectoryAtPath:self.storagePathAPI];
    [[NSFileManager defaultManager] touchDirectoryAtPath:self.storagePathResource];
}


#pragma mark -
#pragma mark Storage Path
- (NSInteger)storageIndex {
    return [[NSUserDefaults standardUserDefaults] integerForKey:kCache_StorageIndex];
}

- (void)setStorageIndex:(NSInteger)storageIndex {
    storageIndex = storageIndex % 100;
    [[NSUserDefaults standardUserDefaults] setInteger:storageIndex forKey:kCache_StorageIndex];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark -
#pragma mark Cached Status

- (BOOL)cacheDidExistWithUrl:(NSString *)url resource:(BOOL)resource {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    return [fileManager fileExistsAtPath:[self cachePathWithUrl:url resource:resource]];
}

- (NSString *)cachePathWithUrl:(NSString *)url resource:(BOOL)resource {
    NSString *fileName = [url md5String];
    NSString *filePath = resource ? [self.storagePathResource stringByAppendingPathComponent:fileName] : [self.storagePathAPI stringByAppendingPathComponent:fileName];
    return filePath;
}

- (NSString *)cacheHeaderPathWithUrl:(NSString *)url resource:(BOOL)resource {
    NSString *fileName = [[url md5String] stringByAppendingString:@".headers"];
    NSString *filePath = resource ? [self.storagePathResource stringByAppendingPathComponent:fileName] : [self.storagePathAPI stringByAppendingPathComponent:fileName];
    return filePath;
}


#pragma mark -
#pragma mark Copy Resource Locally
- (void)moveItemsFromLocalForUrl:(NSString *)url resource:(BOOL)resource {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![self cacheDidExistWithUrl:url resource:YES]) {
        NSString *fileName = nil;
        NSString *fileType = nil;
        NSURL *theURL = [NSURL URLWithString:url];
        if (resource) {
            fileName = [theURL path];
            fileType = [theURL pathExtension];
            if (fileName.length > 0) {
                fileName = [fileName substringWithRange:NSMakeRange(1, fileName.length - 2 - fileType.length)];
            }
        } else {
            fileName = [url md5String];
            fileType = @"json";
        }
        
        NSString *localFilePath = [[NSBundle mainBundle] pathForResource:fileName ofType:fileType];
        if ([fileManager fileExistsAtPath:localFilePath]) {
            [fileManager copyItemAtPath:localFilePath toPath:[self cachePathWithUrl:url resource:resource] error:NULL];
        }
        
    }
}

#pragma mark -
#pragma mark Cache Operations

- (void)removeCacheForUrl:(NSString *)url resource:(BOOL)resource {
    [[NSFileManager defaultManager] removeItemAtPath:[self cacheHeaderPathWithUrl:url resource:resource] error:NULL];
    [[NSFileManager defaultManager] removeItemAtPath:[self cachePathWithUrl:url resource:resource] error:NULL];
}

- (void)saveImage:(UIImage *)image headers:(NSDictionary *)headers forUrl:(NSString *)url {
    NSData *data = nil;
    if ([[headers objectForSafeKey:@"Content-Type"] isEqualToString:@"image/png"]) {
        data = UIImagePNGRepresentation(image);
    } else {
        data = UIImageJPEGRepresentation(image, 0.98);
    }
    
    [headers writeToFile:[self cacheHeaderPathWithUrl:url resource:YES] atomically:YES];
    [data writeToFile:[self cachePathWithUrl:url resource:YES] atomically:YES];
}

- (UIImage *)imageWithUrl:(NSString *)url {
    NSData *data = [NSData dataWithContentsOfFile:[self cachePathWithUrl:url resource:YES]];
    UIImage *image = [UIImage imageWithData:data];
    if (nil == image && nil != data) {
        [self removeCacheForUrl:url resource:YES];
    }
    return image;
}

- (void)saveInfo:(NSDictionary *)info headers:(NSDictionary *)headers forUrl:(NSString *)url {
    [headers writeToFile:[self cacheHeaderPathWithUrl:url resource:NO] atomically:YES];
    [info writeToFile:[self cachePathWithUrl:url resource:NO] atomically:YES];
}

- (NSDictionary *)resultForUrl:(NSString *)url {
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[self cachePathWithUrl:url resource:NO]];
    if (nil == info && [self cacheDidExistWithUrl:url resource:NO]) {
        [self removeCacheForUrl:url resource:NO];
    }
    return info;
}

- (NSDictionary *)headersForUrl:(NSString *)url {
    NSDictionary *info = [NSDictionary dictionaryWithContentsOfFile:[self cacheHeaderPathWithUrl:url resource:NO]];

    
    return info;
}

- (void)saveData:(NSData *)data headers:(NSDictionary *)headers forUrl:(NSString *)url {
    if (nil == data) {
        return;
    }
    [headers writeToFile:[self cacheHeaderPathWithUrl:url resource:YES] atomically:YES];
    [data writeToFile:[self cachePathWithUrl:url resource:YES] atomically:YES];
}

- (NSData *)dataWithUrl:(NSString *)url {
    NSData *data = [NSData dataWithContentsOfFile:[self cachePathWithUrl:url resource:YES]];
    if ( nil == data) {
        [self removeCacheForUrl:url resource:YES];
    }
    return data;
}

#pragma mark -
#pragma mark Clear
- (void)removeAllNonResourceCache {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *storagePath = self.storagePathAPI;
    
    NSError *error = nil;
    [fileManager removeItemAtPath:storagePath error:&error];
    
    [self reset];
}


@end
