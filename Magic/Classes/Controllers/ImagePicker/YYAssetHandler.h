//
//  YYAssetHandler.h
//  Wuya
//
//  Created by lixiang on 15/2/13.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALAsset;

@interface YYAssetHandler : NSObject

@property (nonatomic, strong) UIImage *image;

- (instancetype)initWithAsset:(ALAsset *)asset;

/*缩略图*/
- (UIImage *)thumbnail;

/*全屏图*/
- (UIImage *)fullScreenImage;

/*高清图*/
- (UIImage *)fullResolutionImage;

// Returns the dimensions of this representation.  If the representation does not have valid dimensions, this method will return CGSizeZero.
- (CGSize)dimensions;

// Returns the size of the file for this representation.
- (long long)size;

// Returns a persistent URL uniquely identifying the representation
- (NSURL *)url;

// Returns a dictionary of dictionaries of metadata for the representation.
// If the representation is one that the system cannot interpret, nil is returned.
- (NSDictionary *)metadata;

// Returns the representation's scale.
- (float)scale;

// Returns a string representing the filename of the representation on disk.
// For representations synced from iTunes, this will be the filename of the represenation on the host.
- (NSString *)filename;

@end
