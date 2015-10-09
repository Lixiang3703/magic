//
//  DDLineView.h
//  PAPA
//
//  Created by Tong on 29/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLineView : UIView

@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic, assign) CGRect lineRect;

- (id)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor lineColor:(UIColor *)lineColor lineRect:(CGRect)lineRect;
- (id)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor lineColor:(UIColor *)lineColor;
                                           
@end
