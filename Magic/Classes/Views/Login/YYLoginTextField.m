//
//  DDLoginTextField.m
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYLoginTextField.h"

@implementation YYLoginTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;

        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.enablesReturnKeyAutomatically = YES;

    }
    return self;
}


- (BOOL)resignFirstResponder {
    if (self.shouldIgnoreResignFirstResponder) {
        return NO;
    } else {
        return [super resignFirstResponder];
    }
}

- (BOOL)becomeFirstResponder{
    if (self.becomeFirstResponderBlock) {
        self.becomeFirstResponderBlock();
    }
    return [super becomeFirstResponder];
}

@end
