//
//  PBFlatButton.h
//  FlatUIlikeiOS7
//
//  Created by Piotr Bernad on 13.06.2013.
//  Copyright (c) 2013 Piotr Bernad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDFlatButton : UIButton

@property (nonatomic, assign) BOOL ignoreHighlightedEffect;
@property (nonatomic, assign) BOOL borderless;

+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               theme:(NSString *)uiTheme
       touchUpTarget:(id)target
              action:(SEL)action;

+(id)buttonWithFrame:(CGRect)frame
               title:(NSString *)title
               theme:(NSString *)uiTheme
       touchUpTarget:(id)target
              action:(SEL)action
          borderless:(BOOL)borderless;

+(id)buttonWithFrame:(CGRect)frame;

@end