//
//  DDTextView.m
//  Wuya
//
//  Created by Tong on 15/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTextView.h"
#import "HPTextViewInternal.h"

@implementation DDTextView


#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.enablesReturnKeyAutomatically = YES;
        self.returnKeyType = UIReturnKeyDefault;
        self.isScrollable = NO;
        self.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
        self.internalTextView.scrollIndicatorInsets = UIEdgeInsetsMake(5, 0, 5, 0);
        
    }
    return self;
}

- (void)textViewDidChange:(UITextView *)textView{
    [super textViewDidChange:textView];
    if ([UIDevice below7]) {
        [self resetScrollPosition];
    }
}

- (void)resetScrollPosition{
    CGRect r = [internalTextView caretRectForPosition:internalTextView.selectedTextRange.end];
    CGFloat caretY =  MAX(r.origin.y - internalTextView.frame.size.height + r.size.height + 8, 0);
    if (internalTextView.contentOffset.y < caretY && r.origin.y != INFINITY)
        internalTextView.contentOffset = CGPointMake(0, caretY);
}


@end
