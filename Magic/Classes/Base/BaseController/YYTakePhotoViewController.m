//
//  YYTakePhotoViewController.m
//  Mood
//
//  Created by Tong on 18/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "YYTakePhotoViewController.h"

#import "DDTActionSheet.h"


@interface YYTakePhotoViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, assign) CGRect viewFrame;

@property (nonatomic, strong) UIImagePickerController *imagePicker;
@property (nonatomic, readonly) UIViewController *parentViewController;

@property (nonatomic, strong) UIImage *selectedImage;

@end

@implementation YYTakePhotoViewController

#pragma mark -
#pragma mark Accessors
- (UIViewController *)parentViewController {
    return self.view.superview.viewController;
}

#pragma mark -
#pragma mark Init

- (instancetype)initWithViewFrame:(CGRect)viewFrame {
    self = [super init];
    if (self) {
        self.viewFrame = viewFrame;
    }
    return self;
}

- (void)initSettings {
    [super initSettings];
    
    self.gatherLogEnable = NO;
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    self.view.backgroundColor = [UIColor clearColor];
    self.view.frame = self.viewFrame;
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    //  Photo Image View
    CGFloat margin = 11;
    self.photoImageView = [[DDTImageView alloc] initWithFrame:CGRectMake(margin, margin, self.view.width - 2 * margin, self.view.height - 2 * margin)];
    self.photoImageView.alwaysClearBgColor = YES;
    self.photoImageView.image = [UIImage imageNamed:@"login_photo"];
    self.photoImageView.contentMode = UIViewContentModeCenter;
    self.photoImageView.clipsToBounds = YES;
    [self.photoImageView fullfillPrarentView];
    [self.photoImageView addTarget:self tapAction:@selector(photoImageViewPressed:)];
    
    [self.view addSubview:self.photoImageView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)revertImageView {
    self.photoImageView.image = [UIImage imageNamed:@"login_photo"];
}

#pragma mark -
#pragma mark Buttons
- (void)photoImageViewPressed:(id)sender {
    [[self.view.window findFirstResponder] resignFirstResponder];
    
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] initWithCapacity:3];
    DDTActionSheetItem *actionSheetItem = nil;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        actionSheetItem = [[DDTActionSheetItem alloc] init];
        actionSheetItem.buttonTitle = _(@"拍照");
        actionSheetItem.selector = @selector(imagePickerPhoto);
        [actionSheetItems addObject:actionSheetItem];
        actionSheetItem = nil;
    }
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"从相册中选择");
    actionSheetItem.selector = @selector(imagePickerAlbum);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    

    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];
    
    actionSheet.lbDelegate = self;
    [actionSheet showInView:[UINavigationController appNavigationController].view];

}


#pragma mark -
#pragma mark ImagePick
- (void)imagePickerAlbum {
    self.imagePicker = nil;
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self.parentViewController presentViewController:self.imagePicker animated:YES completion:^{}];
    
}

- (void)imagePickerPhoto {
    self.imagePicker = nil;
    self.imagePicker = [[UIImagePickerController alloc] init];
    self.imagePicker.allowsEditing = YES;
    self.imagePicker.delegate = self;
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self.parentViewController presentViewController:self.imagePicker animated:YES completion:^{}];
}


#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImage *originalImage = info[UIImagePickerControllerOriginalImage];
    originalImage = [originalImage fixOrientation];
    
    if (![UIDevice below8] && picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary){
        CGRect crop = [info[UIImagePickerControllerCropRect] CGRectValue];
        image = [originalImage ordinaryCrop:originalImage toRect:crop formCamera:NO];
    }
    
    
    //  Bug fix: 照相机方图，有时候返回的EditedImage 会错误（一个小图片在左上角，其余全黑）
    //  解决办法，取原图
    if ([originalImage size].width == [originalImage size].height && [originalImage size].width < [image size].width) {
        image = originalImage;
    }
    //  End
    
    image = [[image reSize:CGSizeMake(640, 640)] squarize];
    self.photoImageView.image = image;
    self.photoImageView.contentMode = UIViewContentModeScaleToFill;
    
    self.imagePickerDidFinish = YES;
    self.selectedImage = image;
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    __weak typeof(self)weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.imagePickerDidFinishBlock) {
            weakSelf.imagePickerDidFinishBlock(weakSelf);
        }
    }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    __weak typeof(self)weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (weakSelf.imagePickerDidCancelBlock) {
            weakSelf.imagePickerDidCancelBlock(weakSelf);
        }
    }];
}


@end
