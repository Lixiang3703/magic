//
//  KKTypeManager.h
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"

@interface KKTypeManager : DDSingletonObject

/** Initialization */
+ (KKTypeManager *)getInstance;

- (UIImage *)imageForMessageType:(KKMessageType)type;

@end
