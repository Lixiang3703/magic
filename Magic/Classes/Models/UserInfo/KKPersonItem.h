//
//  KKPersonItem.h
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKImageItem.h"
#import "KKAreaItem.h"

@interface KKPersonItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *company;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, assign) NSInteger parentId;
@property (nonatomic, assign) KKPersonRoleType role;
@property (nonatomic, copy) NSString *code;

@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) NSTimeInterval lastLoginTimestamp;

@property (nonatomic, strong) KKImageItem *imageItem;
@property (nonatomic, strong) KKImageItem *authImageItem;
@property (nonatomic, strong) KKPersonItem *parentItem;


- (void)copyFromPersonItem:(KKPersonItem *)personItem;
- (BOOL)isMineWithPersonItem:(KKPersonItem *)personItem;
- (BOOL)isMineWithPersonId:(NSInteger)personId;

- (BOOL)hasAvatar;

@end
