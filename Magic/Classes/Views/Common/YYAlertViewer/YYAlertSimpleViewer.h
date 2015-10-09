//
//  YYAlertSimpleViewer.h
//  Wuya
//
//  Created by lixiang on 15/3/27.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "DDSingletonObject.h"

@interface YYAlertSimpleViewer : DDSingletonObject

@property (nonatomic, copy) DDBlock okButtonPressBlock;
@property (nonatomic, assign) BOOL ignoreTapAction;


+ (YYAlertSimpleViewer *)getInstance;

- (void)showAlertViewWithContent:(NSString *)content okButtonTitle:(NSString *)okButtonTitle animated:(BOOL)animated;

@end
