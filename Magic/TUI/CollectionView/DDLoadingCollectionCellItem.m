//
//  DDLoadingCollectionCellItem.m
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDLoadingCollectionCellItem.h"

@implementation DDLoadingCollectionCellItem

#pragma mark -
#pragma mark Life cycle
- (void)initSettings {
    [super initSettings];
    
    self.optional = YES;
    self.selectable = NO;
}


@end
