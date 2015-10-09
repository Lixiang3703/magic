//
//  KKChatTextRequestModel.h
//  Link
//
//  Created by Lixiang on 14/12/15.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKBaseChatPostRequestModel.h"

@interface KKChatTextRequestModel : KKBaseChatPostRequestModel

/** Params */
@property (atomic, copy) NSString *content;

@end
