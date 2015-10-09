//
//  DDTabBarItem.m
//  PAPA
//
//  Created by Tong on 28/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import "DDTabBarItem.h"

@implementation DDTabBarItem

#pragma mark -
#pragma mark Life cycle

- (id)initWithTitle:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    return [self initWithTitle:title
                     imageName:imageName
             selectedImageName:selectedImageName
               backgroundImage:nil
                          font:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName
              backgroundImage:(UIImage *)backgroundImage
                         font:(UIFont *)titleFont{
    return [self initWithTitle:title
                     imageName:imageName
             selectedImageName:selectedImageName
               backgroundImage:backgroundImage
                          font:titleFont
         backgroundNormalColor:nil
        backgroundInverseColor:nil
              titleNormalColor:nil
             titleInverseColor:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                    imageName:(NSString *)imageName
            selectedImageName:(NSString *)selectedImageName
              backgroundImage:(UIImage *)backgroundImage
                         font:(UIFont *)titleFont
        backgroundNormalColor:(UIColor *)backgroundNormalColor
       backgroundInverseColor:(UIColor *)backgroundInverseColor
             titleNormalColor:(UIColor *)titleNormalColor
            titleInverseColor:(UIColor *)titleInverseColor{
    self = [super init];
    if (self) {
        self.title = title;
        self.imageName = imageName;
        self.selectedImageName = selectedImageName;
        //        self.backgroundImage = backgroundImage ? backgroundImage : [UIImage imageNamed:@"tabbar_button_background_h"];
        self.font = titleFont ? titleFont : [UIFont systemFontOfSize:10];
        self.backgroundNormalColor = backgroundNormalColor ? backgroundNormalColor : [UIColor clearColor];
        self.backgroundInverseColor = backgroundInverseColor ? backgroundInverseColor : [UIColor clearColor];
        self.titleNormalColor = titleNormalColor ? titleNormalColor : [UIColor lightGrayColor];
        self.titleInverseColor = titleInverseColor ? titleInverseColor : [UIColor KKMainColor];
    }
    return self;
}

@end
