//
//  DDTImageView.m
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTImageView.h"
#import "WSDownloadCache.h"

@interface DDTImageView ()

@property (nonatomic, copy) DDTImageBlock successBlock;
@property (nonatomic, copy) DDTImageBlock failedBlock;

@property (atomic, assign) BOOL loading;

@property (nonatomic, copy) NSString *placeholderImageName;


@end

@implementation DDTImageView

#pragma mark -
#pragma mark Accessors
- (void)setAlwaysClearBgColor:(BOOL)alwaysClearBgColor {
    _alwaysClearBgColor = alwaysClearBgColor;
    
    if (alwaysClearBgColor) {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (UIColor *)defaultBgColor {
    return self.alwaysClearBgColor ? [UIColor clearColor] : [UIColor grayColor];
}

- (void)setMaskImageView:(UIImageView *)maskImageView {
    if (_maskImageView != maskImageView) {
        _maskImageView = maskImageView;
        maskImageView.userInteractionEnabled = NO;
        maskImageView.hidden = YES;
        [maskImageView fullfillPrarentView];
        [self addSubview:maskImageView];
    }
}

#pragma mark -
#pragma mark Initialization

- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame placeHolderImageName:nil];
}

- (instancetype)initWithFrame:(CGRect)frame placeHolderImageName:(NSString *)placeHolderImageName {
    self = [super initWithFrame:frame];
    if (self) {
        self.placeholderImageName = placeHolderImageName;
        self.contentMode = UIViewContentModeScaleToFill;
        self.backgroundColor = [UIColor clearColor];
        self.restImageViewbeforeLoad = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Load Image Operations

- (void)loadImageWithUrl:(NSString *)imageUrl {
    [self loadImageWithUrl:imageUrl localImage:NO];
}

- (void)loadImageWithUrl:(NSString *)imageUrl localImage:(BOOL)localImage {
    [self loadImageWithUrl:imageUrl localImage:localImage reuseCacheBlock:nil successBlock:nil failedBlock:nil];
}

- (void)loadImageWithUrl:(NSString *)imageUrl localImage:(BOOL)localImage reuseCacheBlock:(DDTImageBlock)reuseCacheBlock successBlock:(DDTImageBlock)successBlock failedBlock:(DDTImageBlock)failedBlock {
    if (nil == imageUrl) {
        [self resetImageView];
        return;
    }
//    DDLog(@"%@", imageUrl);
    
    self.successBlock = successBlock;
    self.failedBlock = failedBlock;
    
    if (![imageUrl isEqualToString:self.imageUrl] && self.restImageViewbeforeLoad) {
        [self resetImageView];
    } else if (self.loading) {
        DDLog(@"!!! loading now");
        return;
    }
    
    self.imageUrl = imageUrl;
    
    __weak typeof(self) weakSelf = self;
    
    
    void (^success)(NSURLRequest *, NSHTTPURLResponse *, UIImage *) = ^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        typeof(weakSelf) strongSelf = weakSelf; // make local strong reference to protect against race conditions
        strongSelf.loading = NO;
        if (!strongSelf) return;
        
        NSString *theImageUrl = request.URL.absoluteString;
        if (nil != request && ![weakSelf.imageUrl isEqualToString:theImageUrl]) {
            return;
        }
        
        if (nil != request) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [[WSDownloadCache getInstance] saveImage:image headers:response.allHeaderFields forUrl:request.URL.absoluteString];
            });
        }
        
        if (localImage) {
            strongSelf.image = image;
            strongSelf.maskImageView.hidden = NO;
            strongSelf.backgroundColor = [UIColor clearColor];
            
        } else {
            [UIView transitionWithView:strongSelf
                              duration:0.3
                               options:UIViewAnimationOptionTransitionCrossDissolve
                            animations:^{
                                strongSelf.maskImageView.hidden = NO;
                                strongSelf.image = image;
                            }
                            completion:^(BOOL finished) {
                                strongSelf.backgroundColor = [UIColor clearColor];
                                
                                if (strongSelf.successBlock) {
                                    strongSelf.successBlock(strongSelf, image);
                                }
                            }];
        }
        
        
    };
    
    void (^failure)(NSURLRequest *, NSHTTPURLResponse *, NSError *) = ^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        weakSelf.loading = NO;
        weakSelf.backgroundColor = [weakSelf defaultBgColor];
        if (weakSelf.failedBlock) {
            weakSelf.failedBlock(weakSelf, nil);
        }
    };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:imageUrl.networkURL];
    
    UIImage *cachedImage = [[[self class] sharedImageCache] cachedImageForRequest:request];
    
    BOOL cacheDidExist = [[WSDownloadCache getInstance] cacheDidExistWithUrl:imageUrl resource:YES];

    
    if (cacheDidExist && nil != reuseCacheBlock) {
        reuseCacheBlock(self, cachedImage);
    }
    
    UIImage *placeHolderImage = self.placeholderImageName ? [UIImage imageNamed:self.placeholderImageName] : self.placeHolderImage;
    self.loading = YES;
    
    if (!cacheDidExist) {
        self.backgroundColor = [self defaultBgColor];
    }
    
    if (nil == cachedImage && cacheDidExist) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [[WSDownloadCache getInstance] imageWithUrl:imageUrl];
            dispatch_async(dispatch_get_main_queue(), ^{
                [[[weakSelf class] sharedImageCache] cacheImage:image forRequest:request];
                [weakSelf setImageWithURLRequest:request placeholderImage:placeHolderImage success:success failure:failure];
            });
        });
    } else {
        [self setImageWithURLRequest:request placeholderImage:placeHolderImage success:success failure:failure];
    }
    
    
//    else if (!localImage) {
//        [self setImageWithURLRequest:request placeholderImage:placeHolderImage success:success failure:failure];
//    } else {
//        self.loading = NO;
//    }
}

#pragma mark -
#pragma mark UI Logic
- (void)resetImageView {
    self.successBlock = nil;
    self.failedBlock = nil;
    self.image = nil;
    self.maskImageView.hidden = YES;
    self.backgroundColor = [UIColor clearColor];
}

#pragma mark -
#pragma mark Local Image
- (void)setLocalImage:(UIImage *)image {
    self.image = image;
    self.loading = NO;
    self.imageUrl = nil;
    self.backgroundColor = [UIColor clearColor];
}

@end
