//
//  KKTypeManager.m
//  Magic
//
//  Created by lixiang on 15/4/28.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKTypeManager.h"

@implementation KKTypeManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKTypeManager);

- (UIImage *)imageForMessageType:(KKMessageType)type {
    switch (type) {
        case KKMessageTypeCaseStatus:
            return [UIImage imageNamed:@"icon_gray_notification3"];
            break;
        case KKMessageTypeCaseMessage:
            return [UIImage imageNamed:@"icon_gray_message3"];
            break;
        default:
            break;
    }
    return [UIImage imageNamed:@"icon_gray_notification"];
}
@end
