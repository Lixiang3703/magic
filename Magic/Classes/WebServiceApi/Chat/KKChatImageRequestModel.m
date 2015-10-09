//
//  KKChatImageRequestModel.m
//  Link
//
//  Created by Lixiang on 14/12/17.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatImageRequestModel.h"

@implementation KKChatImageRequestModel

- (instancetype)init{
    self = [super init];
    if (self) {
        self.methodName = @"POST";
        self.agent = YES;
        self.postRequestMode = WSPOSTRequestModeMultiPart;
        self.resultItemSingle = YES;
        self.modelName = kLink_WS_Model_Chat_Insert_Image;
        
    }
    return self;
}

#pragma mark -
#pragma mark Templates

- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    if (error == nil && (self.image == nil) ) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

- (void)paramsSettings{
    [super paramsSettings];
    
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
