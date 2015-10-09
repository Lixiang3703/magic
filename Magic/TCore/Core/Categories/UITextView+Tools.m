//
//  UITextView+Tools.m
//  Wuya
//
//  Created by Tong on 04/05/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UITextView+Tools.h"

@implementation UITextView (Tools)

- (CGFloat)inputTextHeight {
    // Calcualte the number of lines with new text in temporary UITextView
    CGRect endRectWithNewText = [self caretRectForPosition:self.endOfDocument];
    CGRect beginRectWithNewText = [self caretRectForPosition:self.beginningOfDocument];
    CGFloat beginOriginY = beginRectWithNewText.origin.y;
    CGFloat endOriginY = endRectWithNewText.origin.y;
    return endOriginY - beginOriginY;
}

- (NSUInteger)lineNumbers {
    NSUInteger numberOfLines = ceilf((self.inputTextHeight + self.font.lineHeight/ 2) / self.font.lineHeight);
    return numberOfLines;
}

@end
