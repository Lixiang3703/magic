//
//  UIWindow+Tools.m
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIWindow+Tools.h"

@implementation UIWindow (Tools)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)findFirstResponder {
    return [self findFirstResponderInView:self];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView *)findFirstResponderInView:(UIView *)topView {
    if ([topView isFirstResponder]) {
        return topView;
    }
    
    for (UIView* subView in topView.subviews) {
        if ([subView isFirstResponder]) {
            return subView;
        }
        
        UIView* firstResponderCheck = [self findFirstResponderInView:subView];
        if (nil != firstResponderCheck) {
            return firstResponderCheck;
        }
    }
    return nil;
}


@end
