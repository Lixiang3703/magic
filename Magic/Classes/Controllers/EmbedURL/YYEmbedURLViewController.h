//
//  YYEmbedURLViewController.h
//  Wuya
//
//  Created by Lixiang on 14-6-26.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "DDBaseViewController.h"
#import "YYEmbedUrlEmptyView.h"
#import "YYBaseTableViewController.h"

@interface YYEmbedURLViewController : YYBaseTableViewController

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) NSURL *embedURL;
@property (nonatomic, strong) YYEmbedUrlEmptyView *emptyView;

+ (instancetype)viewControllerWithURLString:(NSString *)urlString;
- (instancetype)initWithURLString:(NSString *)urlString;

@end
