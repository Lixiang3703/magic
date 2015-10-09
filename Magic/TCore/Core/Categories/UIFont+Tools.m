//
//  UIFont+Tools.m
//  PMP
//
//  Created by Tong on 09/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "UIFont+Tools.h"

@implementation UIFont (Tools)

- (CGFloat)ceilLineHeight {
    return ceilf(self.lineHeight);
}

@end
