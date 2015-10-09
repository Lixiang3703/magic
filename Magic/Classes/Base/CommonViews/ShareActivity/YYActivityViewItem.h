//
//  YYActivityViewItem.h
//  Wuya
//
//  Created by lilingang on 14-7-14.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYActivityViewItem;

typedef void (^activityViewPressedBlock)();

@interface YYActivityViewItem : NSObject

@property (nonatomic, copy) activityViewPressedBlock actionBlock;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, copy) NSString *theme;

@property (nonatomic, assign) BOOL enable;

+ (YYActivityViewItem *)activityViewItemWithTheme:(NSString *)theme
                                        titleName:(NSString *)title;

+ (YYActivityViewItem *)activityViewItemWithTheme:(NSString *)theme
                                        titleName:(NSString *)title
                                           enable:(BOOL)enable;

- (instancetype)initWithTheme:(NSString *)theme
                    titleName:(NSString *)title
                       enable:(BOOL)enable;
@end
