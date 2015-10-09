//
//  DDTActionSheetItem.m
//  iPhone
//
//  Created by Cui Tong on 15/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "DDTActionSheetItem.h"

@implementation DDTActionSheetItem
#pragma mark -
#pragma mark Properties
@synthesize buttonTitle = _buttonTitle;
@synthesize selector = _selector;
@synthesize userInfo = _userInfo;
@synthesize destructive = _destructive;

- (void)dealloc {
    self.selector = nil;
    
}


+ (DDTActionSheetItem *)cancelActionSheetItem {
    DDTActionSheetItem *item = [[DDTActionSheetItem alloc] init];
    item.buttonTitle = _(@"取消");
    return item;
}

@end
