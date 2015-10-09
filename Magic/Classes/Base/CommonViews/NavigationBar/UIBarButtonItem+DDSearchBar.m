//
//  UIBarButtonItem+DDSearchBar.m
//  Link
//
//  Created by Lixiang on 14/10/29.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "UIBarButtonItem+DDSearchBar.h"
#import "DDNavigationBarGloble.h"
#import <objc/runtime.h>

#import "DDNaviBgView.h"

#define kSearchBar_Width        kUI_Naviagtion_SearchBar_Width

@implementation UIBarButtonItem (DDSearchBar)


static const NSString *KEY_SEARCH_BAR = @"SearchBar";
static const NSString *KEY_BACK_BUTTON = @"BackButton";
static const NSString *KEY_SEARCH_BUTTON = @"SearchButton";

-(void)setSearchBar:(DDSearchBar *)searchBar {
    objc_setAssociatedObject(self, &KEY_SEARCH_BAR, searchBar, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(DDSearchBar *)searchBar {
    return objc_getAssociatedObject(self, &KEY_SEARCH_BAR);
}

- (void)setBackButton:(UIButton *)backButton {
    objc_setAssociatedObject(self, &KEY_BACK_BUTTON, backButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)backButton {
    return objc_getAssociatedObject(self, &KEY_BACK_BUTTON);
}

- (void)setSearchButton:(UIButton *)searchButton {
    objc_setAssociatedObject(self, &KEY_SEARCH_BUTTON, searchButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIButton *)searchButton {
    return objc_getAssociatedObject(self, &KEY_SEARCH_BUTTON);
}

- (id)initWithSearchPlaceholder:(NSString *)placeholder delegate:(id<UISearchBarDelegate>)delegate backButtonTitle:(NSString *)backTitle backButtonTarget:(id)backTarget backButtonAction:(SEL)backSelector searchButtonTitle:(NSString *)searchTitle searchButtonTarget:(id)searchTarget searchButtonAction:(SEL)searchSelector {
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(5, 0, 30, 30)];
    [button setThemeUIType:kThemeNavigationBarBackButton];
    [button setImage:[UIImage imageNamed:@"navi_back_red"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navi_back_red"] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:@"navi_back_red"] forState:UIControlStateSelected];

    [button addTarget:backTarget action:backSelector forControlEvents:UIControlEventTouchUpInside];
    self.backButton = button;
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake([UIDevice screenWidth], 0, 40, 32)];
    [searchButton addTarget:searchTarget action:searchSelector forControlEvents:UIControlEventTouchUpInside];
    [searchButton setTitle:searchTitle forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor KKRedColor] forState:UIControlStateNormal];
    self.searchButton = searchButton;
    
    self.searchBar = [[DDSearchBar alloc] initWithFrame:ccr(button.right, 0, kUI_Naviagtion_SearchBar_Width, kUI_Naviagtion_SearchBar_Height)];
    self.searchBar.tintColor = RGBACOLOR(34, 97, 221, 1);
    self.searchBar.placeholder = placeholder;
    self.searchBar.delegate = delegate;
    self.searchBar.textFieldBackgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];;
    if ([self.searchBar respondsToSelector:@selector(searchBarStyle)]) {/* Added by Meng.  10.24 */
        self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    }
//    self.searchButton.left = self.searchBar.right + 5;
    
    DDNaviBgView *backgroundView = [[DDNaviBgView alloc] initWithFrame:self.searchBar.frame];
    backgroundView.bounds = CGRectOffset(backgroundView.bounds, [UIDevice below7] ? 0 :kUI_Common_BarButtonItem_Margin_Left, 0);
    [backgroundView addSubview:self.searchBar];
    [backgroundView addSubview:self.backButton];
    [backgroundView addSubview:self.searchButton];
    return [self initWithCustomView:backgroundView];
}

- (void)showBackButtonAndSearchButtonAnimated:(BOOL)animted {
    [UIView animateWithDuration:0.1f animations:^{
        self.searchBar.width = kUI_Naviagtion_SearchBar_Width_Searching;
        self.searchButton.left = self.searchBar.right + 5;
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)hideBackButtonAndSearchButtonAnimated:(BOOL)animted {
    [UIView animateWithDuration:0.1f animations:^{
        self.searchButton.left = [UIDevice screenWidth];
        self.searchBar.width = kSearchBar_Width;
    } completion:^(BOOL finished) {

    }];
    
}


@end
