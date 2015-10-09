//
//  DDLineView.m
//  PAPA
//
//  Created by Tong on 29/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import "DDLineView.h"

@implementation DDLineView

#pragma mark -
#pragma mark Life cycle

- (id)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor lineColor:(UIColor *)lineColor {
    return [self initWithFrame:frame bgColor:bgColor lineColor:lineColor lineRect:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
}

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame bgColor:[UIColor whiteColor] lineColor:[UIColor lightGrayColor] lineRect:CGRectMake(0, frame.size.height - 0.5, frame.size.width, 0.5)];
}

- (id)initWithFrame:(CGRect)frame bgColor:(UIColor *)bgColor lineColor:(UIColor *)lineColor lineRect:(CGRect)lineRect {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
        
        self.lineColor = lineColor;
        self.lineRect = lineRect;
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    [self.lineColor setFill];
    CGContextFillRect(ctx, self.lineRect);
    
    CGContextRestoreGState(ctx);
}

@end
