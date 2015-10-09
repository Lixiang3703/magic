//
//  DDSearchBar.h
//  Link
//
//  Created by Lixiang on 14/10/29.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDSearchBar : UISearchBar
@property (nonatomic, strong) UIColor *textFieldBackgroundColor;

/* Convenience method */
- (void)setButtonEnabled:(BOOL)enabled;
- (void)setButtonTitle:(NSString *)title;
- (void)removeBackgroundView;
@end
