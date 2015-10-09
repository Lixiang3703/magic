//
//  UIBarButtonItem+DDSearchBar.h
//  Link
//
//  Created by Lixiang on 14/10/29.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DDSearchBar.h"

@interface UIBarButtonItem (DDSearchBar)

@property (nonatomic, strong) DDSearchBar *searchBar;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *searchButton;

- (id)initWithSearchPlaceholder:(NSString *)placeholder delegate:(id<UISearchBarDelegate>)delegate backButtonTitle:(NSString *)backTitle backButtonTarget:(id)backTarget backButtonAction:(SEL)backSelector searchButtonTitle:(NSString *)searchTitle searchButtonTarget:(id)searchTarget searchButtonAction:(SEL)searchSelector;

- (void)showBackButtonAndSearchButtonAnimated:(BOOL)animted;
- (void)hideBackButtonAndSearchButtonAnimated:(BOOL)animted;

@end
