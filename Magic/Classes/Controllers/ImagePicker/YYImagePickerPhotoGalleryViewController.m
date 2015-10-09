//
//  YYImagePickerPhotoGalleryViewController.m
//  Wuya
//
//  Created by lixiang on 15/2/28.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYImagePickerPhotoGalleryViewController.h"
#import "YYAssetsCollectionCheckmarkView.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface YYImagePickerPhotoGalleryViewController ()

@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) YYAssetsCollectionCheckmarkView *checkmarkView;

@property (nonatomic, strong) NSMutableSet *deSelectedItems;

@end

@implementation YYImagePickerPhotoGalleryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.deSelectedItems = [NSMutableSet set];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)loadView{
    [super loadView];
    
    self.checkmarkView = [[YYAssetsCollectionCheckmarkView alloc] initWithFrame:CGRectMake((self.naviView.width - 40), (self.naviView.height - 24)/2, 24.0, 24.0)];
    self.checkmarkView.autoresizingMask = UIViewAutoresizingNone;
    
    self.checkmarkView.layer.shadowColor = [[UIColor grayColor] CGColor];
    self.checkmarkView.layer.shadowOffset = CGSizeMake(0, 0);
    self.checkmarkView.layer.shadowOpacity = 0.6;
    self.checkmarkView.layer.shadowRadius = 2.0;
    
    UIButton *chooseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.naviView.width - 50, 0, 40, 44)];
    chooseButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [chooseButton setBackgroundColor:[UIColor clearColor]];
    [chooseButton addTarget:self action:@selector(chooseButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(delButtonLongPressed:)];
    [chooseButton addGestureRecognizer:longPressGesture];
    
    [self.naviView addSubview:self.checkmarkView];
    [self.naviView addSubview:chooseButton];
    
    CGFloat doneButtonLeft = [UIDevice screenWidth] - 10 - kImagePickerToolbarButton_width;
    CGFloat buttonTop = (kImagePickerToolbarHeight - kImagePickerToolbarButton_height) / 2;
    
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(doneButtonLeft, buttonTop, kImagePickerToolbarButton_width, kImagePickerToolbarButton_height)];
    [self.doneButton setBackgroundColor:[UIColor clearColor]];
    [self.doneButton setTitle:@"完成" forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor colorWithRed:1 green:0.6 blue:0.14 alpha:1] forState:UIControlStateNormal];
    [self.doneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self resetBottomButton];
    
    [self.toolBar addSubview:self.doneButton];
}

#pragma mark -
#pragma mark PhotoGallery template

- (void)updateOnePhotoContent {
    [super updateOnePhotoContent];
    
    NSString *caption = [NSString stringWithFormat:@"%ld / %lu", (long)(self.currentIndex + 1),(unsigned long)[self.photoViewsArray count]];
    [self.naviTitleLabel setText:caption];
    
    ALAsset *asset = [self.assets objectAtSafeIndex:self.currentIndex];
    
    if ([self.deSelectedItems containsObject:asset]) {
        self.checkmarkView.choose = NO;
    }
    else {
        self.checkmarkView.choose = YES;
    }
}

- (void)resetBottomButton {
    
    NSString *title = [NSString stringWithFormat:@"完成(%ld)",(unsigned long)self.assets.count - self.deSelectedItems.count];
    [self.doneButton setTitle:title forState:UIControlStateNormal];
    
    if (((unsigned long)self.assets.count - self.deSelectedItems.count) <= 0) {
        self.doneButton.enabled = NO;
    }
    else {
        self.doneButton.enabled = YES;
    }
}

#pragma mark -
#pragma mark Button actions

- (void)chooseButtonClick:(id)sender {
    ALAsset *asset = [self.assets objectAtSafeIndex:self.currentIndex];
    
    BOOL choose  = NO;
    
    if ([self.deSelectedItems containsObject:asset]) {
        [self.deSelectedItems removeObject:asset];
        choose = YES;
    }
    else {
        [self.deSelectedItems addSafeObject:asset];
        choose = NO;
    }
    
    if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(yyImpagePickerPhotoGalleryChoose:choose:asset:)]) {
        [self.imagePickerDelegate yyImpagePickerPhotoGalleryChoose:self choose:choose asset:asset];
    }
    
    [self updateOnePhotoContent];
    [self resetBottomButton];
}

- (void)doneButtonClick:(id)sender {
    if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(yyImagePickerPhotoGalleryDone:)]) {
        [self.imagePickerDelegate yyImagePickerPhotoGalleryDone:self];
    }
}

@end
