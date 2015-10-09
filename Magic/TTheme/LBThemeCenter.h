//
//  LBTheme.h
//  LBiPhone
//
//  Created by Cui Tong on 10/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LBThemeDefinitions.h"
#import "LBTheme.h"


@interface LBThemeCenter : NSObject {

    NSString *_themeName;
    LBTheme *_theme;
}

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, strong) LBTheme *theme;

+ (LBThemeCenter *)getInstance;

//  Basic attribute setting
- (UIColor *)colorOfThemeType:(NSString *)uiType;
- (UIFont *)fontOfThemeType:(NSString *)uiType;
- (CGSize)sizeOfThemeType:(NSString *)uiType;
- (UIImage *)imageOfThemeType:(NSString *)uiType;
- (NSString *)imageNameOfThemeType:(NSString *)uiType;
- (NSUInteger)lineNumberOfThemeType:(NSString *)uiType;

//  UI Elements setting
- (void)setLabel:(UILabel *)label withThemeUIType:(NSString *)uiType;
- (void)setButton:(UIButton *)button withThemeUIType:(NSString *)uiType;
- (void)setImageView:(UIImageView *)imageView withThemeUIType:(NSString *)uiType;
- (void)setUIView:(UIView *)uiView withThemeUIType:(NSString *)uiType;
//  TODO: set other ui elements, like imageview, tablecell

@end
