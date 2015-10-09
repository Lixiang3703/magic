//
//  DDGIFImageView.h
//  Wuya
//
//  Created by lilingang on 14-8-6.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YFGIFImageView.h"
#import "UIImageView+PlayGIF.h"
/*
 NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"car.gif" ofType:nil]];
 DDGIFImageView* gifView = [[DDGIFImageView alloc] initWithFrame:];
 gifView.gifData = gifData;
 [self.view addSubview:gifView];
 // notice: before start, content is nil. You can set image for yourself
 [gifView startGIF];
 */

@interface DDGIFImageView : YFGIFImageView

- (void)playWithImageUrl:(NSString *)imageUrl;

- (void)playWithImageUrl:(NSString *)imageUrl local:(BOOL)local;

@end
