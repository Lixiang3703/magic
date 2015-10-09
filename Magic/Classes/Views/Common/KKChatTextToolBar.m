//
//  KKChatTextToolBar.m
//  Link
//
//  Created by Lixiang on 14/12/16.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKChatTextToolBar.h"


#define kImageButtonWidth       (30)

@interface KKChatTextToolBar() <HPGrowingTextViewDelegate>

@property (nonatomic, readonly) DDBaseTableViewController *tableViewController;

@end

@implementation KKChatTextToolBar

- (void)dealloc {
    self.textView.delegate = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Accessors

- (DDBaseTableViewController *)tableViewController {
    return (DDBaseTableViewController *)self.viewController;
}


#pragma mark -
#pragma mark Life cycle

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        //  Notifications
        [self addNotifications];
        
        //  UI
        self.backgroundColor = [UIColor YYCustomKeyboardBgColor];
        self.userInteractionEnabled = YES;
        
        // lineView
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
        [lineImageView setThemeUIType:kLinkThemeCustomKeyboardGrayLineImageView];
        
        CGFloat textBgWidth = self.width - 3*kUI_TableView_Common_Margin - kImageButtonWidth;
        
        self.textBg = [[UIImageView alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_TableView_Common_MarginS, textBgWidth, self.height - 2 * kUI_TableView_Common_MarginS)];
        self.textBg.userInteractionEnabled = YES;
        self.textBg.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
        self.textView = [[DDTextView alloc] initWithFrame:self.textBg.bounds];
        self.textView.backgroundColor = [UIColor whiteColor];
        self.textView.font = [UIFont YYFontLarge];
        self.textView.delegate = self;
        self.textView.returnKeyType = UIReturnKeySend;
        self.textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        
        //textView的蒙层解决显示越界的BUG
        self.textViewLayerView = [[UIImageView alloc] initWithFrame:CGRectMake(self.textBg.left, 0, self.textBg.width, self.height)];
        self.textViewLayerView.userInteractionEnabled = NO;
        self.textViewLayerView.image = [[UIImage imageNamed:@"kb_toolbar_textview_back"] stretchableImageWithLeftCapWidth:15 topCapHeight:self.height/2];
        self.textViewLayerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
        
        [self addSubview:self.textBg];
        [self.textBg addSubview:self.textView];
        [self addSubview:self.textViewLayerView];
        [self addSubview:lineImageView];
        
        self.toolbarHeightWhenTypeText = self.height;
        
        [self addTarget:self tapAction:@selector(toolbarPressed:)];
        
        //  Image Button
        self.imageButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width - kImageButtonWidth - kUI_TableView_Common_Margin, (self.height - kImageButtonWidth)/2, kImageButtonWidth, kImageButtonWidth)];
        [self.imageButton setThemeUIType:kThemePMImageIconButton];
        
        [self addSubview:self.imageButton];
    }
    return self;
}

#pragma mark -
#pragma mark HPGrowingTextViewDelegate
- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height {
    float diff = (growingTextView.frame.size.height - height);
    
    CGRect r = self.frame;
    r.size.height -= diff;
    r.origin.y += diff;
    
    CGRect s = self.textBg.frame;
    s.size.height -= diff;
    s.origin.y += diff;
    
    CGRect t = self.textViewLayerView.frame;
    t.size.height -= diff;
    t.origin.y += diff;
    
    self.textBg.frame = s;
    self.textViewLayerView.frame = t;
    
    self.frame = r;
    
    if (self.adjustTableViewHeightForKeyboard) {
        self.tableViewController.tableView.height = self.top - self.tableViewController.tableView.top;
    } else {
        self.tableViewController.tableView.bottom = self.top;
    }
    
    self.toolbarHeightWhenTypeText = self.height;
    
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![[growingTextView.text trim] hasContent] && [text isEqualToString:@" "]) {
        return NO;
    }
    if ([text isEqualToString:@"\n"]) {
        if (self.growingTextViewShouldReturnOperation) {
            self.growingTextViewShouldReturnOperation();
        }
        return NO;
    }
    return YES;
}

- (void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView {
    
}

- (BOOL)growingTextViewShouldBeginEditing:(HPGrowingTextView *)growingTextView {
    return YES;
}


#pragma mark -
#pragma mark UIWindow Keyboard Notifications

- (void)keyboardWillShow:(NSNotification *)notification {
    if (!self.visible ) {
        return;
    }
    
    UIViewAnimationOptions animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endFrame = [[[notification userInfo] valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGRect newFrame = self.frame;
    newFrame.size.height = self.toolbarHeightWhenTypeText;
    newFrame.origin.y = self.tableViewController.view.height - newFrame.size.height - endFrame.size.height;
    
    
    if (self.keyboardWillShowOperation) {
        self.keyboardWillShowOperation();
    }
    [UIView animateWithDuration:animationDuration delay:0 options:(animationCurve << 16) animations:^{
        self.frame = newFrame;
        
        if (self.adjustTableViewHeightForKeyboard) {
            self.tableViewController.tableView.height = self.top - self.tableViewController.tableView.top;
        } else {
            self.tableViewController.tableView.bottom = self.top;
        }
        
        if (self.keyboardWillShowAnimationOperation) {
            self.keyboardWillShowAnimationOperation();
        }
    } completion:^(BOOL finished) {
        if (self.keyboardWillShowCompletionOperation) {
            self.keyboardWillShowCompletionOperation();
        }
    }];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    if (!self.visible ) {
        return;
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    if (!self.visible ) {
        return;
    }
    
    UIViewAnimationOptions animationCurve	= [[[notification userInfo] valueForKey:UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval animationDuration = [[[notification userInfo] valueForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    
    BOOL hasCustomVC = [[[notification userInfo] objectForSafeKey:kUIKeyboardWithCustomVC] boolValue];
    
    CGRect newFrame = self.frame;
    
    if (!hasCustomVC) {
        newFrame.size.height = self.height;
        newFrame.origin.y = self.tableViewController.view.height - newFrame.size.height;
    }
    
    if (self.adjustTableViewHeightForKeyboard) {
        self.tableViewController.tableView.height = newFrame.origin.y - self.tableViewController.tableView.top;
    } else {
        self.tableViewController.tableView.bottom = newFrame.origin.y;
    }
    
    [UIView animateWithDuration:animationDuration delay:0 options:(animationCurve << 16) animations:^{
        self.frame = newFrame;
    } completion:^(BOOL finished) {
        
        if (self.keyboardWillHideCompletionOperation) {
            self.keyboardWillHideCompletionOperation();
        }
    }];
}


- (void)toolbarPressed:(id)sender {
    
}

@end
