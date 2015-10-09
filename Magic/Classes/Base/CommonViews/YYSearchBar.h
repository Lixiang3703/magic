//
//  YYSearchBar.h
//  Wuya
//
//  Created by Lixiang on 14-7-4.
//  copy from papa.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YYSearchBar : UISearchBar

@property (nonatomic, strong) UIColor *textFieldBackgroundColor;

/* Convenience method added by Wei */
- (void)setButtonEnabled:(BOOL)enabled;
- (void)setButtonTitle:(NSString *)title;
- (void)removeBackgroundView;

@end
