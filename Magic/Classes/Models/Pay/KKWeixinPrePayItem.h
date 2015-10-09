//
//  KKWeixinPrePayItem.h
//  Magic
//
//  Created by lixiang on 15/6/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKWeixinPrePayItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *appid;
@property (nonatomic, copy) NSString *noncestr;
@property (nonatomic, copy) NSString *myPackage;
@property (nonatomic, copy) NSString *partnerid;
@property (nonatomic, copy) NSString *prepayid;
@property (nonatomic, assign) NSInteger timestamp;
@property (nonatomic, copy) NSString *sign;
@end
