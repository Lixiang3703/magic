//
//  DDSearchBar.m
//  Link
//
//  Created by Lixiang on 14/10/29.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDSearchBar.h"

@interface DDSearchBar ()

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) NSArray *mySubViews;

@end

@implementation DDSearchBar

- (NSArray *)mySubViews {
    return [UIDevice below7] ? self.subviews : [[self.subviews objectAtIndex:0] subviews];
}

- (void)setTextFieldBackgroundColor:(UIColor *)textFieldBackgroundColor {
    if (_textFieldBackgroundColor != textFieldBackgroundColor) {
        _textFieldBackgroundColor = textFieldBackgroundColor;
        self.textField.backgroundColor = textFieldBackgroundColor;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        if ([UIDevice below7]) {
            UITextField *searchField = nil;
            self.tintColor = [UIColor clearColor];
            for (UIView *subview in self.subviews) {
                if ([subview isKindOfClass:[UITextField class]]) {
                    searchField = [self.subviews objectAtIndex:[self.subviews indexOfObject:subview]];
                } else if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
                    [subview removeFromSuperview];
                }
            }
            
            if(searchField != nil) {
                searchField.textColor= [UIColor grayColor];
                searchField.background = nil;
                searchField.backgroundColor = self.textFieldBackgroundColor ? self.textFieldBackgroundColor : [UIColor lightGrayColor];
                searchField.layer.cornerRadius = 5;
                searchField.borderStyle = UITextBorderStyleNone;
                searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
            }
            
            self.textField = searchField;
            self.autocorrectionType = UITextAutocorrectionTypeNo;
            self.autocapitalizationType = UITextAutocapitalizationTypeNone;
            self.showsCancelButton = NO;
            [self setImage:[UIImage imageNamed:@"searchbar_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        } else {
            [self removeBackgroundView];
        }
        
        //  bar button
        NSDictionary *_titleTextAttributesNormal = @{NSForegroundColorAttributeName: [UIColor redColor],
                                                     NSShadowAttributeName : [UIColor clearColor],
                                                     NSFontAttributeName : [UIFont systemFontOfSize:17]};
        NSDictionary *_titleTextAttributesDisabled = @{NSForegroundColorAttributeName: [UIColor lightGrayColor],
                                                       NSShadowAttributeName : [UIColor clearColor],
                                                       NSFontAttributeName : [UIFont systemFontOfSize:17]};
        
        UIBarButtonItem *searchBarButton = [UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil];
        
        if ([UIDevice below7]) { // Save time
            [searchBarButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            [searchBarButton setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        }
        
        [searchBarButton setTitleTextAttributes:_titleTextAttributesNormal forState:UIControlStateNormal];
        [searchBarButton setTitleTextAttributes:_titleTextAttributesDisabled forState:UIControlStateDisabled];
    }
    return self;
}

/* Convenience method */
- (void)setButtonEnabled:(BOOL)enabled {
    for (UIButton *button in self.mySubViews) {
        if ([button isKindOfClass:[UIButton class]]) {
            button.enabled = enabled;
        }
    }
}

- (void)setButtonTitle:(NSString *)title {
    for (UIView *subView in self.mySubViews){
        if([subView isKindOfClass:[UIButton class]]){
            [(UIButton*)subView setTitle:title forState:UIControlStateNormal];
        }
    }
}

- (void)removeBackgroundView {
    for (UIView *subview in self.mySubViews) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
}

@end
