//
//  DDNaviBgView.m
//  PAPA
//
//  Created by Tong on 23/01/2014.
//  Copyright (c) 2014 diandian. All rights reserved.
//

#import "DDNaviBgView.h"

@implementation DDNaviBgView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    /* Prevent other buttons do not respond. */
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) {
        return nil;
    } else {
        return hitView;
    }
    /* Edited by Meng 10.23 */
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    return YES;
}

@end
