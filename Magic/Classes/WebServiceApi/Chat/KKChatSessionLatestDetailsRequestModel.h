//
//  KKChatSessionLatestDetailsRequestModel.h
//  Link
//
//  Created by Lixiang on 14/12/12.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatBaseSessionDetailsRequestModel.h"

@interface KKChatSessionLatestDetailsRequestModel : KKChatBaseSessionDetailsRequestModel

/** Params */
@property (atomic, assign) NSInteger latestMsgId;

@end
