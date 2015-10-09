//
//  DDTPublishTextView.h
//  iPhone
//
//  Created by Cui Tong on 28/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DDTPublishTextView;

@interface DDTPublishTextViewDelegate : NSObject<UITextViewDelegate>

@property (nonatomic, weak) id<UITextViewDelegate> textViewDelegate;

@end


@interface DDTPublishTextView : UITextView {
    NSString *_placeholder;
    CGFloat _lastLineHeight;
    NSInteger _maxDisplayLines;
    UILabel *_placeHolderLabel;
}

@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, assign) NSInteger maxDisplayLines;
@property (nonatomic, assign) CGSize lastContentSize;
@property (nonatomic, strong) UILabel *placeHolderLabel;

- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

- (void)adjustTextWhenBeginEditing;
- (void)adjustTextWhenEndEditing;
- (void)adjustTextWhenViewDidChange;
- (void)addToSuperView:(UIView *)superView;
- (void)replaceNSRange:(NSRange)range withText:(NSString *)text;

- (void)reSizeContentSizeWithText:(NSString *)text;
- (void)reSetContentOffset;

@end
