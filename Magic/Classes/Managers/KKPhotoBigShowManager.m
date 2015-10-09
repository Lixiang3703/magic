//
//  KKPhotoBigShowManager.m
//  Link
//
//  Created by Lixiang on 14/12/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKPhotoBigShowManager.h"
#import "KKImageItem.h"

#import "PhotoScrollingViewController.h"
#import "YYNavigationController.h"

@interface KKPhotoBigShowManager()<PhotoGalleryViewControllerDelegate>

@property (nonatomic, strong) NSArray *imageItemArray;

@end

@implementation KKPhotoBigShowManager

SYNTHESIZE_SINGLETON_FOR_CLASS(KKPhotoBigShowManager);

- (void)showPublishControllerWithLocalImageArray:(NSArray *)localImageArray initialIndex:(NSInteger)initialIndex {
    
    PhotoScrollingViewController *photoScrollingViewController = [[PhotoScrollingViewController alloc] initWithPhotoSource:self initialIndex:initialIndex];
    photoScrollingViewController.localUIImageArray = localImageArray;
    photoScrollingViewController.isLocalUIImages = YES;
    photoScrollingViewController.supportDelete = NO;
    
    [[UINavigationController appNavigationController] presentViewController:photoScrollingViewController animated:YES completion:^{

    }];
}

- (void)showPublishControllerWithImageItemArray:(NSArray *)imageItemArray initialIndex:(NSInteger)initialIndex {
    
    self.imageItemArray = [NSArray arrayWithArray:imageItemArray];
    
    PhotoScrollingViewController *photoScrollingViewController = [[PhotoScrollingViewController alloc] initWithPhotoSource:self initialIndex:initialIndex];
    photoScrollingViewController.isLocalUIImages = NO;
    photoScrollingViewController.supportDelete = NO;
    
    [[UINavigationController appNavigationController] presentViewController:photoScrollingViewController animated:YES completion:^{
        
    }];
}

#pragma mark -
#pragma mark PhotoGalleryViewControllerDelegate

- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoScrollingViewController *)gallery {
    if (!self.imageItemArray) {
        return 0;
    }
    return [self.imageItemArray count];
}

- (NSString *)photoGallery:(PhotoScrollingViewController *)gallery urlForPhotoSize:(YYGalleryPhotoSize)size atIndex:(NSUInteger)index {
    if (!self.imageItemArray || self.imageItemArray.count < index) {
        return @"http://h.hiphotos.baidu.com/image/pic/item/ac6eddc451da81cb4e89d63e5066d016082431d1.jpg";
    }
    KKImageItem *imageItem = [self.imageItemArray objectAtIndex:index];
    return imageItem.urlMiddle;
}

@end
