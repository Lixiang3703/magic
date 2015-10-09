//
//  DDPushItem.m
//  Link
//
//  Created by Lixiang on 15/1/18.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "DDPushItem.h"

@implementation DDPushItem

#pragma mark -
#pragma mark Initialzation
- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        
        if (self.t >= DDPushTypeCount ) {
            self.t = DDPushTypeUnknown;
        }
    }
    return self;
}

- (void)customSettingsBeforeAutoParse {
    [super customSettingsBeforeAutoParse];
}

@end
