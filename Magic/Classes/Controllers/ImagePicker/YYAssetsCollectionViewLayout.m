//
//  YYAssetsCollectionViewLayout.m
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetsCollectionViewLayout.h"

@implementation YYAssetsCollectionViewLayout

+ (instancetype)layout
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.minimumLineSpacing = 3.0;
        self.minimumInteritemSpacing = 3.0;
    }
    
    return self;
}

@end
