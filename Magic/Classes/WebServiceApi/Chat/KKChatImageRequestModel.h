//
//  KKChatImageRequestModel.h
//  Link
//
//  Created by Lixiang on 14/12/17.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKBaseChatPostRequestModel.h"
#import "KKImageItem.h"

@interface KKChatImageRequestModel : KKBaseChatPostRequestModel

@property (atomic, strong) UIImage *image;


@property (nonatomic, strong) KKImageItem *imageItem;

@end
