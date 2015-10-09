//
//  KKTextToolBar.h
//  Link
//
//  Created by Lixiang on 14/11/24.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTextView.h"

typedef void (^KKTextToolBarOperationBlock)();

@interface KKTextToolBar : UIImageView <UITextViewDelegate>

@property (nonatomic, strong) UIImageView *textBg;
@property (nonatomic, strong) UIImageView *textViewLayerView;

@property (nonatomic, strong) DDTextView *textView;
@property (nonatomic, assign) CGFloat toolbarHeightWhenTypeText;

@property (nonatomic, copy) KKTextToolBarOperationBlock growingTextViewShouldReturnOperation;
@property (nonatomic, copy) KKTextToolBarOperationBlock keyboardWillShowOperation;
@property (nonatomic, copy) KKTextToolBarOperationBlock keyboardWillShowAnimationOperation;
@property (nonatomic, copy) KKTextToolBarOperationBlock keyboardWillShowCompletionOperation;
@property (nonatomic, copy) KKTextToolBarOperationBlock keyboardWillHideCompletionOperation;

@property (nonatomic, assign) BOOL adjustTableViewHeightForKeyboard;
@end
