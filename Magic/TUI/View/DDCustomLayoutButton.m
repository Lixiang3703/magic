//
//  DDCustomLayoutButton.m
//  Wuya
//
//  Created by Tong on 14/01/2015.
//  Copyright (c) 2015 Longbeach. All rights reserved.
//

#import "DDCustomLayoutButton.h"

@implementation DDCustomLayoutButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.customLayoutBlock) {
        self.customLayoutBlock(self);
    }
}

@end
