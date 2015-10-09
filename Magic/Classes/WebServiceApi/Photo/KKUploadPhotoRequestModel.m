//
//  KKUploadPhotoRequestModel.m
//  Magic
//
//  Created by lixiang on 15/5/10.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKUploadPhotoRequestModel.h"

@implementation KKUploadPhotoRequestModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        self.agent = YES;
        self.postRequestMode = WSPOSTRequestModeMultiPart;
        self.resultItemSingle = YES;
        self.modelName = kLink_WS_Model_Photo_Upload_avatar;
        
        self.resultItemsKeyword = @"entity";
        self.resultItemsClassName = [[KKImageItem class] description];
        self.resultItemSingle = YES;
        
        self.entityId = 7;
    }
    return self;
}

- (void)setUploadPhotoType:(KKUploadPhotoType)uploadPhotoType {
    _uploadPhotoType = uploadPhotoType;
    switch (uploadPhotoType) {
        case KKUploadPhotoType_avatar:
            self.modelName = kLink_WS_Model_Photo_Upload_avatar;
            break;
        case KKUploadPhotoType_partner:
            self.modelName = kLink_WS_Model_Photo_Upload_partner;
            break;
        case KKUploadPhotoType_caseUserImage:
            self.modelName = kLink_WS_Model_Photo_Upload_userCaseImage;
            break;
        case KKUploadPhotoType_trademark:
            self.modelName = kLink_WS_Model_Photo_Upload_trademark;
            break;
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark Templates

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    if (error == nil && (self.image == nil || self.entityId <= 0)) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings{
    [super paramsSettings];
    
    [self.parameters setSafeObject:@(self.entityId) forKey:@"entityId"];
}



#pragma mark -
#pragma mark Post Settings

- (NSData *)postBodyData{
    NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
    return imageData;
}

- (void)postMultiPartHanlderWith:(id<AFMultipartFormData>)formData {
    
    NSData *imageData = UIImageJPEGRepresentation(self.image, 1);
    [formData appendPartWithFileData:imageData name:@"image" fileName:@"photoOne" mimeType:@"image/jpeg"];
}

- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    self.imageItem = self.resultItem;
    
    return error;
}

@end
