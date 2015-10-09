//
//  DDTabBarItem.h
//  PAPA
//
//  Created by Tong on 28/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDBadgeView.h"

@class DDTabBarButton;

@interface DDTabBarItem : NSObject

@property (nonatomic, copy) UIImage *backgroundImage;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *selectedImageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *backgroundNormalColor;
@property (nonatomic, strong) UIColor *backgroundInverseColor;
@property (nonatomic, strong) UIColor *titleNormalColor;
@property (nonatomic, strong) UIColor *titleInverseColor;
@property (nonatomic, assign) BOOL customHandle;
@property (nonatomic, assign) BOOL doubleTapHandle;
@property (nonatomic, assign) BOOL inverse;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@property (nonatomic, assign) DDBadgeViewType badgeViewtype;
@property (nonatomic, assign) BOOL showHorizontalLine;
@property (nonatomic, assign) BOOL normalButton;

- (id)initWithTitle:(NSString *)title
          imageName:(NSString *)imageName
  selectedImageName:(NSString *)selectedImageName;

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName
              backgroundImage:(UIImage *)backgroundImage
                         font:(UIFont *)titleFont;

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName
              backgroundImage:(UIImage *)backgroundImage
                         font:(UIFont *)titleFont
        backgroundNormalColor:(UIColor *)backgroundNormalColor
       backgroundInverseColor:(UIColor *)backgroundInverseColor
             titleNormalColor:(UIColor *)titleNormalColor
            titleInverseColor:(UIColor *)titleInverseColor;


@end
