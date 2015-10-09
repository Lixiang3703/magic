//
//  UITextField+TUI.m
//  Wuya
//
//  Created by Tong on 14/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UITextField+TUI.h"

@implementation UITextField (TUI)

- (NSString *)textTrimed {
    return [self.text trim];
}

- (BOOL)hasContent {
    return [self.textTrimed hasContent];
}

@end
