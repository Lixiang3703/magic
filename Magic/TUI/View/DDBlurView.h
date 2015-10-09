//
//  DDBlurView.h
//  Wuya
//
//  Created by Tong on 08/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDBlurView : UIView

// Use the following property to set the tintColor. Set it to nil to reset.
@property (nonatomic, strong) UIColor *blurTintColor;

- (void)setBlurTintColor:(UIColor *)blurTintColor;

@end
