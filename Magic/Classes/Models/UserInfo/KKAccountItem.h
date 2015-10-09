//
//  KKAccountItem.h
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKAccountItem : YYBaseAPIItem

+ (KKAccountItem *)sharedItem;

@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *ticket;

@property (nonatomic, assign) BOOL hasShowWelcomePage;

@end
