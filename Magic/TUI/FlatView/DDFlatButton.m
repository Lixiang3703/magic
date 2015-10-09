//
//  PBFlatButton.m
//  FlatUIlikeiOS7
//
//  Created by Piotr Bernad on 11.06.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import "DDFlatButton.h"
#import <QuartzCore/QuartzCore.h>

@interface DDFlatButton ()
@property (strong, nonatomic) UIColor *mainColor;
@end

@implementation DDFlatButton {
    UIColor *_backgroundColor;

}

- (void)setThemeUIType:(NSString *)type{
    [[LBThemeCenter getInstance] setButton:self withThemeUIType:type];
	[self appearanceButtonWithColor:[self titleColorForState:UIControlStateNormal]];
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

    }
    return self;
}

+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               theme:(NSString *)uiTheme
       touchUpTarget:(id)target
              action:(SEL)action {

    return [DDFlatButton buttonWithFrame:frame title:title theme:uiTheme touchUpTarget:target action:action borderless:NO];
}

+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               theme:(NSString *)uiTheme
       touchUpTarget:(id)target
              action:(SEL)action
          borderless:(BOOL)borderless {
    DDFlatButton *button = [[DDFlatButton alloc] initWithFrame:frame];
    button.borderless = borderless;
    [button setTitle:title forState:UIControlStateNormal];
    [button setThemeUIType:uiTheme];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return button;
}

+(id)buttonWithFrame:(CGRect)frame{
	DDFlatButton * button  = [[DDFlatButton alloc] initWithFrame:frame];
	return button;
}

- (void)appearanceButtonWithColor:(UIColor *)color {
	_backgroundColor = self.themeType ? self.backgroundColor : (self.borderless ? [UIColor clearColor] : color);
	_mainColor = color;
    [self.layer setMasksToBounds:YES];
    [self.layer setCornerRadius:2.0];
	self.layer.borderWidth = self.borderless ? 0 : 1;
	self.layer.borderColor = _mainColor.CGColor;
    if (!self.themeType) {
        //  Set Normal Title Color
        [self setTitleColor:color forState:UIControlStateNormal];
        //  Set Highlighted Title Color
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        if (self.borderless) {
            [self setTitleColor:[UIColor colorWithRed:CGColorGetComponents(self.mainColor.CGColor)[0] green:CGColorGetComponents(self.mainColor.CGColor)[1] blue:CGColorGetComponents(self.mainColor.CGColor)[2] alpha:0.8] forState:UIControlStateHighlighted];
        }
        self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 15);
        self.titleEdgeInsets = UIEdgeInsetsMake(1, 1, 0, 0);
    }

}

- (void)setEnabled:(BOOL)enabled{
	
	if (self.enabled != enabled && enabled) {
		[self appearanceButtonWithColor:[self titleColorForState:UIControlStateNormal]];
	}
	[super setEnabled:enabled];
	if (!enabled) {
		[self appearanceButtonWithColor:[self titleColorForState:UIControlStateDisabled]];
	}
}

- (void)setHighlighted:(BOOL)highlighted {
	if (!self.ignoreHighlightedEffect && self.highlighted != highlighted) {
        [super setHighlighted:highlighted];
        UIColor *temp = _mainColor;
        _mainColor = _backgroundColor;
        _backgroundColor = temp;
		self.layer.borderColor = _mainColor.CGColor;
		[self setBackgroundColor:self.borderless ? [UIColor clearColor]  : _backgroundColor];
    }
}

@end
