//
//  DDLoginTextField.h
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YYTextFieldBecomeFirstResponderBlock)();

@interface YYLoginTextField : UITextField

@property (nonatomic, assign) BOOL shouldIgnoreResignFirstResponder;

@property (nonatomic,copy) YYTextFieldBecomeFirstResponderBlock  becomeFirstResponderBlock;

@end
