//
//  DDTPublishTextView.m
//  iPhone
//
//  Created by Cui Tong on 28/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "DDTPublishTextView.h"

@interface DDTPublishTextView () <UITextViewDelegate>

@property (nonatomic, strong) DDTPublishTextViewDelegate *ddTtextViewDelegate;

@end

@implementation DDTPublishTextView

#pragma mark -
#pragma mark Properties
@synthesize placeholder = _placeholder;
@synthesize maxDisplayLines = _maxDisplayLines;
@synthesize lastContentSize = _lastContentSize;
@synthesize placeHolderLabel = _placeHolderLabel;


#pragma mark -
#pragma mark Accessors
- (void)setText:(NSString *)text {
    [super setText:text];
    if (text && text.length) {
        self.placeHolderLabel.hidden = YES;
        if (![UIDevice below7] && self.frame.size.width) {
            [self reSizeContentSizeWithText:text];
        }
    }
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.placeHolderLabel.font = self.font;
}

- (void)layoutSubviews {
    _placeHolderLabel.frame = CGRectMake(self.left + 2, self.top, self.width, self.font.lineHeight);
}

- (UILabel *)placeHolderLabel {
    if (nil == _placeHolderLabel) {
        _placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.left + 2, self.top , self.width, self.font.lineHeight)];
        _placeHolderLabel.backgroundColor = [UIColor clearColor];
        _placeHolderLabel.font = self.font;
		_placeHolderLabel.textColor = [UIColor lightGrayColor];
        _placeHolderLabel.text = self.placeholder;
    }
    return _placeHolderLabel;
}

- (void)setPlaceholder:(NSString *)placeholder {
    if (_placeholder != placeholder) {
        _placeholder = [placeholder copy];
        self.placeHolderLabel.text = placeholder;
        self.placeHolderLabel.font = self.font;
        [self.placeHolderLabel setNeedsDisplay];
    }
}

#pragma mark -
#pragma mark Lifecycle

- (id)init
{
    self = [super init];
    if (self) {

        self.backgroundColor = [UIColor blueColor];
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor textFiledTextColor];
		self.placeHolderLabel.textColor = [UIColor lightGrayColor];
        self.contentInset = [UIDevice below7] ? UIEdgeInsetsMake(-8, -8, 0, 0) : UIEdgeInsetsMake(-8, -2, 0, 0);
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = YES;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder{
    self = [super init];
    if (self) {
        self.frame = frame;
        self.placeholder = placeholder;
        
        self.backgroundColor = [UIColor blueColor];
        self.font = [UIFont systemFontOfSize:15];
        self.textColor = [UIColor textFiledTextColor];
		self.placeHolderLabel.textColor = [UIColor lightGrayColor];
        self.contentInset = [UIDevice below7] ? UIEdgeInsetsMake(-8, -8, 0, 0) : UIEdgeInsetsMake(-8, -2, 0, 0);
        self.scrollEnabled = YES;
        self.showsVerticalScrollIndicator = YES;
        self.autocorrectionType = UITextAutocorrectionTypeNo;
    }
    return self;
}

#pragma mark -
#pragma mark Logic

- (void)adjustTextWhenBeginEditing {
    
}

- (void)adjustTextWhenEndEditing {

}

- (void)adjustTextWhenViewDidChange {
    self.placeHolderLabel.hidden = ([self.text length] > 0);
}

- (void)addToSuperView:(UIView *)superView
{
    [superView addSubview:self.placeHolderLabel];
    [superView addSubview:self];
}


- (void)replaceNSRange:(NSRange)range withText:(NSString *)text
{
    if ([self.delegate textView:self shouldChangeTextInRange:range replacementText:text]) {
        self.text = [self.text stringByReplacingCharactersInRange:range withString:text];
        [self.delegate textViewDidChange:self];
    }
}

- (void)setDelegate:(id<UITextViewDelegate>)delegate
{
    self.ddTtextViewDelegate.textViewDelegate = delegate;
    [super setDelegate:self.ddTtextViewDelegate];
}

- (DDTPublishTextViewDelegate *)ddTtextViewDelegate
{
    if (_ddTtextViewDelegate == nil) {
        _ddTtextViewDelegate = [[DDTPublishTextViewDelegate alloc] init];
    }
    return _ddTtextViewDelegate;
}

- (void)reSizeContentSizeWithText:(NSString *)text {
    CGSize textViewSize = [text boundingRectWithSize:CGSizeMake(self.frame.size.width-10, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    self.contentSize = CGSizeMake(self.frame.size.width, textViewSize.height + 10);
}

- (void)reSetContentOffset {
    
    CGFloat cursorTop = [self caretRectForPosition:self.selectedTextRange.start].origin.y;
    if (isnan(cursorTop) || isinf(cursorTop)) {
        cursorTop = 0;
    }
    if (cursorTop + 20 > self.height) {
        self.contentOffset = CGPointMake(self.contentOffset.x, cursorTop-self.height+20);
    } else if (cursorTop < self.contentOffset.y) {
        self.contentOffset = CGPointMake(self.contentOffset.x, cursorTop);
    }
}

@end


@implementation DDTPublishTextViewDelegate

- (void)dealloc
{
    self.textViewDelegate = nil;
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.textViewDelegate textViewShouldBeginEditing:textView];
    }
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.textViewDelegate respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.textViewDelegate textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [((DDTPublishTextView *)textView) adjustTextWhenBeginEditing];
    if ([self.textViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.textViewDelegate textViewDidBeginEditing:textView];
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [((DDTPublishTextView *)textView) adjustTextWhenEndEditing];
    if ([self.textViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.textViewDelegate textViewDidEndEditing:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([self.textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]) {
        return [self.textViewDelegate textView:textView shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)textViewDidChange:(UITextView *)textView
{
    [((DDTPublishTextView *)textView) adjustTextWhenViewDidChange];
    if ([self.textViewDelegate respondsToSelector:@selector(textViewDidChange:)]) {
        [self.textViewDelegate textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if ([self.textViewDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.textViewDelegate textViewDidChangeSelection:textView];
    }
}


@end