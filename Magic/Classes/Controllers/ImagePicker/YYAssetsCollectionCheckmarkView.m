//
//  YYAssetsCollectionCheckmarkView.m
//  Wuya
//
//  Created by lixiang on 15/2/12.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import "YYAssetsCollectionCheckmarkView.h"

@implementation YYAssetsCollectionCheckmarkView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        // View settings
        self.backgroundColor = [UIColor clearColor];
        self.choose = YES;
    }
    
    return self;
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(24.0, 24.0);
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Border
    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextFillEllipseInRect(context, self.bounds);
    
    // Body
    if (self.choose) {
//        CGContextSetRGBFillColor(context, 20.0/255.0, 111.0/255.0, 223.0/255.0, 1.0);
        CGContextSetRGBFillColor(context, 255.0/255.0, 192.0/255.0, 19.0/255.0, 1.0);
    }
    else {
        CGContextSetRGBFillColor(context, 120.0/255.0, 120.0/255.0, 120.0/255.0, 1.0);
    }
    
    CGContextFillEllipseInRect(context, CGRectInset(self.bounds, 1.0, 1.0));
    
    // Checkmark
    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);
    CGContextSetLineWidth(context, 1.2);
    
    CGContextMoveToPoint(context, 6.0, 12.0);
    CGContextAddLineToPoint(context, 10.0, 16.0);
    CGContextAddLineToPoint(context, 18.0, 8.0);
    
    CGContextStrokePath(context);
}

- (void)setChoose:(BOOL)choose {
    _choose = choose;
    [self setNeedsDisplay];
}


@end
