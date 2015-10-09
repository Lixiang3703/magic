//
//  DDEmptyCollectionCellItem.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDEmptyCollectionCellItem.h"

@implementation DDEmptyCollectionCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.tip = _(@"这里什么都没有");
    self.optional = YES;
}


@end
