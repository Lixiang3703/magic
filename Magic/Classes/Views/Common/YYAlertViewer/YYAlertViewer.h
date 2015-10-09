//
//  YYAlertViewer.h
//  Wuya
//
//  Created by lixiang on 15/3/25.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface YYAlertViewer : DDSingletonObject

@property (nonatomic, copy) DDBlock okButtonPressBlock;
@property (nonatomic, copy) DDBlock cancelButtonPressBlock;

@property (nonatomic, assign) BOOL ignoreTapAction;

+ (YYAlertViewer *)getInstance;

- (void)showAlertViewWithIconImage:(UIImage *)iconImage title:(NSString *)title content:(NSString *)content cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle animated:(BOOL)animated;

@end
