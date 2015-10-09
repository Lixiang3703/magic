//
//  DDTActionSheet.m
//  iPhone
//
//  Created by Cui Tong on 15/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "DDTActionSheet.h"

@interface DDTActionSheet () <UIActionSheetDelegate>

@end


@implementation DDTActionSheet

#pragma mark -
#pragma mark Properties
@synthesize lbDelegate = _lbDelegate;

@synthesize actionSheetItems = _actionSheetItems;

- (void)dealloc {
    
    [self removeObservers];
    
    self.delegate = nil;
    self.lbDelegate = nil;
    
}

#pragma mark -
#pragma mark Observers

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleApplicationDidEnteredBackground)
                                                 name:UIApplicationDidEnterBackgroundNotification
                                               object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIApplicationDidEnterBackgroundNotification
                                                  object:nil];
}

#pragma mark -
#pragma mark Life cycle

- (id)initWithTitle:(NSString *)title ActionSheetItems:(NSArray *)actionSheetItems{
    self = [super init];
    if (self) {
        
        [self addObservers];
        
        self.actionSheetItems = actionSheetItems;
        
        //  Settings
        self.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
        self.delegate = self;
        self.title = title;
        for (DDTActionSheetItem *actionSheetItem in actionSheetItems) {
            [self addButtonWithTitle:actionSheetItem.buttonTitle];

        }
        
        self.cancelButtonIndex = self.numberOfButtons - 1;
        
    }
    return self;
}

#pragma mark -
#pragma mark Action Logic

- (BOOL)canBecomeFirstResponder {
    return NO;
}


#pragma mark -
#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([self.actionSheetItems count] <= buttonIndex) {
        return;
    }

    DDTActionSheetItem *actionSheetItem = [self.actionSheetItems objectAtIndex:buttonIndex];
    
    if ([self.lbDelegate respondsToSelector:actionSheetItem.selector]) {
        SuppressPerformSelectorLeakWarning([self.lbDelegate performSelector:actionSheetItem.selector withObject:actionSheetItem.userInfo]);
    }
}

#pragma mark -
#pragma mark Notification Handler

- (void)handleApplicationDidEnteredBackground {
    [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:NO];
}

@end
