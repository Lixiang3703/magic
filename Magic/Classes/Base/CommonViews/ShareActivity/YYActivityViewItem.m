//
//  YYActivityViewItem.m
//  Wuya
//
//  Created by lilingang on 14-7-14.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYActivityViewItem.h"

@implementation YYActivityViewItem


+ (YYActivityViewItem *)activityViewItemWithTheme:(NSString *)theme
                                        titleName:(NSString *)title{
    return [YYActivityViewItem activityViewItemWithTheme:theme
                                               titleName:title
                                                  enable:YES];
}

+ (YYActivityViewItem *)activityViewItemWithTheme:(NSString *)theme
                                        titleName:(NSString *)title
                                           enable:(BOOL)enable{
    return [[[self class] alloc]initWithTheme:theme
                                    titleName:title
                                       enable:enable];
}

- (instancetype)initWithTheme:(NSString *)theme
                    titleName:(NSString *)title
                       enable:(BOOL)enable{
    self = [super init];
    if (self) {
        self.titleName = title;
        self.theme = theme;
        self.enable = enable;
    }
    return self;
}

@end
