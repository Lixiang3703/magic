//
//  KKImageItem.h
//  Link
//
//  Created by Lixiang on 14/11/3.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKImageItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *urlOrigin;
@property (nonatomic, copy) NSString *urlMiddle;
@property (nonatomic, copy) NSString *urlSmall;

@property (nonatomic, copy) NSString *pattern;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) DDBaseItemBool gif;

/** 这个方法是在反射字段不对应的时候用的，比如 KKPersonItem 中的 imageItem 是头像 */
- (instancetype)initWithUrlOrigin:(NSString *)urlOrigin urlMiddle:(NSString *)urlMiddle urlSmall:(NSString *)urlSmall;

+ (CGSize)imageSizeWithWidth:(CGFloat)width height:(CGFloat)height maxSide:(CGFloat)maxSide;

@end
