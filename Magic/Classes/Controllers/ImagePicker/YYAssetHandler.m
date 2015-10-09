//
//  YYAssetHandler.m
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetHandler.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface YYAssetHandler ()

@property (nonatomic, strong) ALAsset *asset;

@end

@implementation YYAssetHandler


- (instancetype)initWithAsset:(ALAsset *)asset{
    self = [super init];
    if (self) {
        self.asset = asset;
    }
    return self;
}

- (UIImage *)thumbnail{
    if (self.image) {
        return self.image;
    }
    return [UIImage imageWithCGImage:[self.asset thumbnail]];
}

- (UIImage *)fullScreenImage{
    if (self.image) {
        return self.image;
    }
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullScreenImage]];
}

- (UIImage *)fullResolutionImage{
    if (self.image) {
        return self.image;
    }
    return [UIImage imageWithCGImage:[[self.asset defaultRepresentation] fullResolutionImage]];
}

- (CGSize)dimensions{
    return [[self.asset defaultRepresentation] dimensions];
}

- (long long)size{
    return [[self.asset defaultRepresentation] size];
}

- (NSURL *)url{
    return [[self.asset defaultRepresentation] url];
}

- (NSDictionary *)metadata{
    return [[self.asset defaultRepresentation] metadata];
}

- (float)scale{
    return [[self.asset defaultRepresentation] scale];
}

- (NSString *)filename{
    return [[self.asset defaultRepresentation] filename];
}

- (NSString *)description{
    NSDictionary *dict = @{@"filename": [self filename],
                           @"url": [self url],
                           @"scale": @([self scale]),
                           @"size":@([self size]),
                           @"dimensions": NSStringFromCGSize([self dimensions])
                           };
    
    return [dict description];
}


@end
