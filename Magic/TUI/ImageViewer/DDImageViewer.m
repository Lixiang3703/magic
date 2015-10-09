//
//  DDImageViewer.m
//  Wuya
//
//  Created by Tong on 18/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDImageViewer.h"
#import "AppDelegate.h"
#import "DDTImageView.h"
#import "WSDownloadCache.h"

@interface DDImageViewer ()

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, assign) CGRect startFrame;
@property (nonatomic, assign) CGRect endFrame;
@property (nonatomic, strong) UIActivityIndicatorView *spinner;

@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) DDTImageView *imageView;


@end

@implementation DDImageViewer
SYNTHESIZE_SINGLETON_FOR_CLASS(DDImageViewer);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Accessors 

- (UIView *)containerView {
    if (nil == _containerView) {
        _containerView = [[UIView alloc] initWithFrame:[AppDelegate sharedAppDelegate].window.bounds];
        _containerView.backgroundColor = [UIColor clearColor];
        _containerView.tag = kTag_Global_ImageViewer;
        
        [_containerView addTarget:self tapAction:@selector(viewDidTap:)];
        
        self.bgView = [[UIView alloc] initWithFrame:self.containerView.bounds];
        self.bgView.backgroundColor = [UIColor blackColor];
        self.bgView.userInteractionEnabled = NO;
        
        self.imageView = [[DDTImageView alloc] initWithFrame:CGRectZero];
        self.imageView.alwaysClearBgColor = YES;
        self.imageView.userInteractionEnabled = NO;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        self.spinner.frame = _containerView.bounds;
        
        [_containerView addSubview:self.bgView];
        [_containerView addSubview:self.imageView];
        [_containerView addSubview:self.spinner];
        
        //  Gesture
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
        [_containerView addGestureRecognizer:longPressGesture];
    }
    return _containerView;
}

#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];
        
        
    }
    return self;
}

- (void)displayWithAnimated:(BOOL)animated {
    //  Prepare
    self.bgView.alpha = 0.0f;
    self.imageView.frame = self.startFrame;
    
    
    BOOL cacheDidExist = [[WSDownloadCache getInstance] cacheDidExistWithUrl:self.imageUrl resource:YES];

    DDTImageBlock completeBlock = nil;
    
    if (!cacheDidExist) {
        __weak __typeof(self)weakSelf = self;
        [self.spinner startAnimating];
        completeBlock = ^(UIImageView *imageView, UIImage *image) {
            [weakSelf.spinner stopAnimating];
        };
    }
    
    self.imageView.restImageViewbeforeLoad = NO;
    [self.imageView loadImageWithUrl:self.imageUrl localImage:NO reuseCacheBlock:nil successBlock:completeBlock failedBlock:completeBlock];
    
    [UIView animateWithDuration:0.3 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        
        self.bgView.alpha = 1.0f;
        self.imageView.frame = self.endFrame;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissWithAnimated:(BOOL)animated {
    [UIView animateWithDuration:0.3 animations:^{
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        
        self.bgView.alpha = 0.0f;
        self.imageView.frame = self.startFrame;
        
    } completion:^(BOOL finished) {
        [self.containerView removeFromSuperview];
        self.containerView = nil;
    }];

}

- (void)viewFullScreenImageWithImageUrl:(NSString *)imageUrl placeHolderImage:(UIImage *)image startFrame:(CGRect)startFrame endFrame:(CGRect)endFrame animated:(BOOL)animated {

    //  Check if displayed or not
    if ([self.containerView superview]) {
        return;
    }
    
    //  Assign Values
    self.imageUrl = imageUrl;
    self.startFrame = startFrame;
    self.endFrame = endFrame;
    
    //  Window
    [[AppDelegate sharedAppDelegate].window addSubview:self.containerView];
    
    [self displayWithAnimated:animated];
}


#pragma mark -
#pragma mark Notification
- (void)applicationDidEnterBackgroundNotification:(NSNotification *)notification {
    [self dismissWithAnimated:NO];
}

#pragma mark -
#pragma mark Buttons
- (void)viewDidTap:(UITapGestureRecognizer *)gesture {
    [self dismissWithAnimated:YES];
}

#pragma mark -
#pragma mark Gesture
- (void)longPressed:(UILongPressGestureRecognizer *)sender {
    
    
    if (sender.state == UIGestureRecognizerStateBegan){
        UIImage *image = [[WSDownloadCache getInstance] imageWithUrl:self.imageUrl];
        if (nil == image) {
            [UIAlertView postAlertWithMessage:_(@"正在下载清晰大图")];
        } else {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [UIAlertView postAlertWithMessage:_(@"已保存至手机相册")];
    } else {
        [UIAlertView postAlertWithMessage:_(@"保存至手机相册失败")];
    }
}


@end
