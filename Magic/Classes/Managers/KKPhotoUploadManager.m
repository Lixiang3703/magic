//
//  KKPhotoUploadManager.m
//  Magic
//
//  Created by lixiang on 15/4/27.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKPhotoUploadManager.h"
#import "KKUploadPhotoRequestModel.h"

#import "YYNavigationController.h"

#import "YYImagePickerController.h"
#import "YYAssetHandler.h"

#import "DDTActionSheet.h"
#import "UIAlertView+Blocks.h"
#import "YYAuthorizationManager.h"

@interface KKPhotoUploadManager()<UINavigationControllerDelegate, UIImagePickerControllerDelegate, YYImagePickerControllerDelegate>

@property (nonatomic, assign) KKUploadPhotoType uploadPhotoType;
@property (nonatomic, assign) NSInteger entityId;

@property (nonatomic, strong) KKUploadPhotoRequestModel *uploadPhotoRequestModel;

@property (nonatomic, strong) NSMutableArray *uiImageArray;

/* 辅助多图上传 */
@property (nonatomic, assign) NSInteger uploadedPhotoCount;
@property (nonatomic, assign) BOOL photoUploading;

@end

@implementation KKPhotoUploadManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKPhotoUploadManager);

#pragma mark -
#pragma mark Accessor

- (KKUploadPhotoRequestModel *)uploadPhotoRequestModel {
    if (_uploadPhotoRequestModel == nil) {
        _uploadPhotoRequestModel = [[KKUploadPhotoRequestModel alloc] init];
        _uploadPhotoRequestModel.uploadPhotoType = KKUploadPhotoType_avatar;
    }
    return _uploadPhotoRequestModel;
}

- (NSMutableArray *)uiImageArray {
    if (_uiImageArray == nil) {
        _uiImageArray = [NSMutableArray array];
    }
    return _uiImageArray;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Upload Photo

- (void)uploadPhotoWithType:(KKUploadPhotoType)uploadPhotoType entityId:(NSInteger)entityId withMaxCount:(NSInteger)maxCount {
    self.uploadPhotoType = uploadPhotoType;
    self.entityId = entityId;
    self.uploadMaxCount = maxCount;
    [self selectPhotoByActionsheet];
    
    [self.uploadPhotoRequestModel cancel];
    [self.uiImageArray removeAllObjects];
    self.photoUploading = NO;
}

- (void)uploadPhotoWithType:(KKUploadPhotoType)uploadPhotoType entityId:(NSInteger)entityId{
    [self uploadPhotoWithType:uploadPhotoType entityId:entityId withMaxCount:8];
}

#pragma mark -
#pragma mark Action sheet

- (void)selectPhotoByActionsheet{
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] init];
    DDTActionSheetItem *actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"相机");
    actionSheetItem.selector = @selector(selectPhotoFromCamera);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"从相册中选择");
    actionSheetItem.selector = @selector(selectPhotoFromAlbum);
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];
    actionSheet.lbDelegate = self;
    [actionSheet showInView:[UINavigationController appNavigationController].view];
}

- (void)selectPhotoFromAlbum {
    if (![[YYAuthorizationManager getInstance] checkAuthorizationWithType:YYAuthorizationTypeAsset]) {
        return;
    }
    
    YYImagePickerController *pickerViewController = [[YYImagePickerController alloc] init];
    pickerViewController.maximumNumberOfSelection = self.uploadMaxCount;
    pickerViewController.maximumCustomAlertTitle = [NSString stringWithFormat:@"最多只能选择%ld张照片", (long)self.uploadMaxCount];
    pickerViewController.delegate = self;
    
    UINavigationController *navController = [[([UIDevice below7] ? NSClassFromString(@"UINavigationController") : NSClassFromString(@"YYNavigationController")) alloc] initWithRootViewController:pickerViewController];
    [[UINavigationController appNavigationController] presentViewController:navController animated:YES completion:nil];
}

- (void)selectPhotoFromCamera {
    if (![[YYAuthorizationManager getInstance] checkAuthorizationWithType:YYAuthorizationTypeCamera]) {
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    
    [[UINavigationController appNavigationController] presentViewController:imagePicker animated:YES completion:nil];
    
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    CGFloat width = MIN(640, ceilf(image.size.width));
    CGFloat height = ceilf(width * image.size.height  * 1.0 / image.size.width);
    
    image = [image reSize:CGSizeMake(width, height)];
    
    [picker dismissViewControllerAnimated:NO completion:^{}];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [picker dismissViewControllerAnimated:YES completion:^{}];
}

#pragma mark -
#pragma mark YYImagePickerControllerDelegate

- (void)yy_imagePickerController:(YYImagePickerController *)imagePickerController didSelectAssets:(NSArray *)assets {
    [imagePickerController dismissViewControllerAnimated:NO completion:nil];
    
    NSMutableArray *imageArray = [[NSMutableArray alloc] initWithCapacity:[assets count]];
    YYAssetHandler *handle = nil;
    for (ALAsset *asset in assets) {
        handle = [[YYAssetHandler alloc] initWithAsset:asset];
        
        UIImage *image = [handle fullScreenImage];
        CGFloat width = MIN(640, ceilf(image.size.width));
        CGFloat height = ceilf(width * image.size.height  * 1.0 / image.size.width);
        
        image = [image reSize:CGSizeMake(width, height)];
        [imageArray addSafeObject:image];
    }
    
    [self.uiImageArray addObjectsFromArray:imageArray];
    
    [self recursiveUploadImages];
    
}

- (void)yy_imagePickerControllerDidCancel:(YYImagePickerController *)imagePickerController {
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark UploadImage Button Action

- (void)recursiveUploadImages {
    self.uploadedPhotoCount = 0;
    [self uploadImages];
}

- (void)uploadImages {
    [UIAlertView postAlertWithMessage:@"正在上传，请稍候..."];
    if (self.uploadedPhotoCount < [self.uiImageArray count]) {
        self.photoUploading = YES;
        
        self.uploadPhotoRequestModel.entityId = self.entityId;
        self.uploadPhotoRequestModel.uploadPhotoType = self.uploadPhotoType;
        self.uploadPhotoRequestModel.image = self.uiImageArray[self.uploadedPhotoCount];
        self.uploadedPhotoCount ++;
        
        __weak typeof(self)weakSelf = self;
        self.uploadPhotoRequestModel.successBlock = ^(id responseObject, NSDictionary *headers, KKUploadPhotoRequestModel *requestModel){
            [weakSelf uploadImages];
        };
        self.uploadPhotoRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, KKUploadPhotoRequestModel *requestModel){
            [weakSelf uploadImages];
        };
        [self.uploadPhotoRequestModel load];
    } else {
        self.photoUploading = NO;
        [UIAlertView HUDAlertDismiss];
        [UIAlertView postAlertWithMessage:@"上传图片成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Photos_Upload_Success object:nil];
        
        if (self.uploadPhotoType == KKUploadPhotoType_avatar) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Profile_Update_BasicInfo_Success object:nil];
        }
        
    }
}
@end
