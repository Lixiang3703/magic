//
//  KKDynamicItem.h
//  Magic
//
//  Created by lixiang on 15/5/13.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"

@interface KKDynamicItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subTitle;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *url;

// News 真正的发生时间，因为可能之前发生的新闻，最近插入。
@property (nonatomic, assign) NSTimeInterval newsTimestamp;

@end
