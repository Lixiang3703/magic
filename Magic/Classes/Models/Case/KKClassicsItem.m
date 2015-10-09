//
//  KKClassicsItem.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKClassicsItem.h"

@implementation KKClassicsItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.imageItem = [KKImageItem itemWithDict:[dict objectForSafeKey:@"imageItem"]];
    }
    return self;
}

@end
