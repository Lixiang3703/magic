//
//  DDIntroItem.m
//  Wuya
//
//  Created by Tong on 25/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDIntroItem.h"
#import "DDIntroManager.h"

@implementation DDIntroItem

#pragma mark -
#pragma mark Life cycle

+ (DDIntroItem *)sharedItem {
    return [DDIntroManager getInstance].introItem;
}

- (BOOL)chatDetailKeyboardIntroFlag
{
    return YES;
}

- (BOOL)chatDetailOneItemIntroFlag
{
    return YES;
}

@end
