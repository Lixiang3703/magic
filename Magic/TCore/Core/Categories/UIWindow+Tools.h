//
//  UIWindow+Tools.h
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Tools)

/**
 * Searches the view hierarchy recursively for the first responder, starting with this window.
 */
- (UIView *)findFirstResponder;

/**
 * Searches the view hierarchy recursively for the first responder, starting with topView.
 */
- (UIView *)findFirstResponderInView:(UIView *)topView;

@end
