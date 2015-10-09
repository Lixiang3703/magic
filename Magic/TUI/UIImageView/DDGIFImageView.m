//
//  DDGIFImageView.m
//  Wuya
//
//  Created by lilingang on 14-8-6.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "DDGIFImageView.h"
#import "WSDownloadCache.h"
#import "DDTImageView.h"
#import "DDTImageView+WebService.h"


@interface DDGIFImageView ()

@property (nonatomic, strong) DDTImageView *downloadImageView;
@property (nonatomic, copy) NSString *gifImageUrl;


@end

@implementation DDGIFImageView

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.downloadImageView = [[DDTImageView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

#pragma mark -
#pragma mark Logic
- (void)playWithImageUrl:(NSString *)imageUrl{
    
    NSString *localPath = [self gifPathWithImageUrl:imageUrl];
    
    if ([self.gifImageUrl isEqualToString:localPath] && self.isGIFPlaying) {
        return;
    }
    
    if (![self.gifImageUrl isEqualToString:localPath]) {
        self.gifData = nil;
        [self stopGIF];
    }
    
    if ([[WSDownloadCache getInstance] cacheDidExistWithUrl:localPath resource:YES]) {
        self.gifData = [[WSDownloadCache getInstance] dataWithUrl:localPath];
        self.gifImageUrl = localPath;
        [self startGIF];
    } else {
        __weak typeof(self)weakSelf = self;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageUrl.networkURL];
        
        [self.downloadImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            [[WSDownloadCache getInstance] saveData:weakSelf.downloadImageView.imageRequestOperation.responseData headers:response.allHeaderFields forUrl:localPath];
            
            weakSelf.gifData = weakSelf.downloadImageView.imageRequestOperation.responseData;
            weakSelf.gifImageUrl = localPath;
            [weakSelf startGIF];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            
        }];
    }
}

- (void)playWithImageUrl:(NSString *)imageUrl local:(BOOL)local {

    NSString *localPath = [self gifPathWithImageUrl:imageUrl];
    
    if ([self.gifImageUrl isEqualToString:localPath] && self.isGIFPlaying) {
        return;
    }
    
    if (![self.gifImageUrl isEqualToString:localPath]) {
        self.gifData = nil;
        [self stopGIF];
    }
    
    if ([[WSDownloadCache getInstance] cacheDidExistWithUrl:localPath resource:YES]) {
        if (local) {
            self.gifData = [[WSDownloadCache getInstance] dataWithUrl:localPath];
            self.gifImageUrl = localPath;
            [self startGIF];
        }

    } else if (!local) {
        __weak typeof(self)weakSelf = self;
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageUrl.networkURL];
        
        [self.downloadImageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            
            [[WSDownloadCache getInstance] saveData:weakSelf.downloadImageView.imageRequestOperation.responseData headers:response.allHeaderFields forUrl:localPath];
            
            weakSelf.gifData = weakSelf.downloadImageView.imageRequestOperation.responseData;
            weakSelf.gifImageUrl = localPath;
            [weakSelf startGIF];
            
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {

        }];
    }
}

- (NSString *)gifPathWithImageUrl:(NSString *)imageUrl {
    return [NSString stringWithFormat:@"%@|%@", @"GIF", imageUrl];
}


@end
