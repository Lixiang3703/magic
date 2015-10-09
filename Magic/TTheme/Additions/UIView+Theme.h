//
//  UIView+Theme.h
//  PAPA
//
//  Created by Tong on 27/12/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Theme)

@property (nonatomic, copy) NSString *themeType;

- (void)setThemeUIType:(NSString *)type;

@end

@interface UIView (ThemeAdditions)

@property (nonatomic, readonly, getter = isVisible) BOOL visible;

@end
