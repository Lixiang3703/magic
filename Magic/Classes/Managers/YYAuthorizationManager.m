//
//  YYAuthorizationManager.m
//  Wuya
//
//  Created by lixiang on 15/3/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAuthorizationManager.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation YYAuthorizationManager
SYNTHESIZE_SINGLETON_FOR_CLASS(YYAuthorizationManager);

- (BOOL)checkAuthorizationWithType:(YYAuthorizationType)type {
    switch (type) {
        case YYAuthorizationTypeCamera:
        {
            AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            
            if(status == ALAuthorizationStatusRestricted || status == ALAuthorizationStatusDenied) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是酱紫的" message:@"请在iPhone的“设置-隐私-相机”选项中，允许小乌鸦访问你的相机。" delegate:nil cancelButtonTitle:@"造啦" otherButtonTitles:nil, nil];
                [alert show];
                return NO;
            }
        }
            break;
        case YYAuthorizationTypeAsset:
        {
            ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
            
            if (status == ALAuthorizationStatusDenied) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是酱紫的" message:@"请在iPhone的“设置-隐私-照片”选项中，允许小乌鸦访问你的照片。" delegate:nil cancelButtonTitle:@"造啦" otherButtonTitles:nil, nil];
                [alert show];
                return NO;
            }
        }
        default:
            break;
    }
    return YES;
}

@end
