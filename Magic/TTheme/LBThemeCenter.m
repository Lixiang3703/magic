//
//  LBTheme.m
//  LBiPhone
//
//  Created by Cui Tong on 10/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "LBThemeCenter.h"
#import "SynthesizeSingleton.h"
#import "NSString+Theme.h"
#import "UIView+Theme.h"


@interface LBThemeCenter (Private)

- (UIColor *)colorWithDict:(NSDictionary *)settings;
- (UIFont *)fontWithDict:(NSDictionary *)settings;
- (CGSize)sizeWithDict:(NSDictionary *)settings;
- (UIImage *)imageWithDict:(NSDictionary *)settings;
- (NSString *)imageNameWithDict:(NSDictionary *)settings;
- (NSUInteger)lineNumberWithDict:(NSDictionary *)settings;
- (UIEdgeInsets)edgeInsetsWithDict:(NSDictionary *)settings;

@end

@implementation LBThemeCenter

#pragma mark -
#pragma mark Properties
SYNTHESIZE_SINGLETON_FOR_CLASS(LBThemeCenter);
@synthesize themeName = _themeName;
@synthesize theme = _theme;

#pragma mark -
#pragma mark Accessors
- (LBTheme *)theme {
    if (nil == _theme) {
        _theme = [[LBTheme alloc] initWithThemeName:self.themeName];
    }
    return _theme;
}

- (void)setThemeName:(NSString *)themeName {
    if (themeName == _themeName) {
        return;
    }

    _themeName = [themeName copy];
    
    //  Clear the theme object, then it will regenerate a new theme object for the new themename
    self.theme = nil;
}

#pragma mark -
#pragma mark Life cycle

- (id)init
{
    self = [super init];
    if (self) {

        self.themeName = @"KK";
    }
    
    return self;
}


#pragma mark -
#pragma mark Attribute Convertion methods (Private)
- (UIColor *)colorWithDict:(NSDictionary *)settings {
    
    if (nil == settings) {  //  Default color is "clear color"
        return [UIColor clearColor];
    }
    
    NSString *selectorName = [settings objectForKey:kThemeKeywordAttrSelector];
    
    if (nil != selectorName) {  //  如果定义了Selector属性，则直接返回selector结果 
        SEL selector = NSSelectorFromString(selectorName);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
       return   [[UIColor class] performSelector:selector];
        
#pragma clang diagnostic pop
        
    }
    
    NSUInteger r = [[settings objectForKey:kThemeKeywordAttrR] intValue];
    NSUInteger g = [[settings objectForKey:kThemeKeywordAttrG] intValue];
    NSUInteger b = [[settings objectForKey:kThemeKeywordAttrB] intValue];
    float_t    a = [[settings objectForKey:kThemeKeywordAttrA] floatValue];
    
    return RGBACOLOR(r, g, b, a);
}

- (UIFont *)fontWithDict:(NSDictionary *)settings {
    
    if (nil == settings) {  //  Default font is 12 font, unbold
        return [UIFont systemFontOfSize:12];
    }
    
    NSString *selectorName = [settings objectForKey:kThemeKeywordAttrSelector];
    
    if (nil != selectorName) {  //  如果定义了Selector属性，则直接返回selector结果
        SEL selector = NSSelectorFromString(selectorName);
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        
        return   [[UIFont class] performSelector:selector];
        
#pragma clang diagnostic pop
        
    }
    
    BOOL bold = [[settings objectForKey:kThemeKeywordAttrBold] boolValue];
    
    NSUInteger fontSize = [[settings objectForKey:kThemeKeywordAttrSize] intValue];
    
    return bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
}

- (CGSize)sizeWithDict:(NSDictionary *)settings {

    if (nil == settings) {  //  Default size is 0
        return CGSizeZero;
    }
    
    NSInteger width = [[settings objectForKey:kThemeKeywordAttrWidth] intValue];
    NSInteger height = [[settings objectForKey:kThemeKeywordAttrHeight] intValue];
    
    return CGSizeMake(width, height);
}

- (UIImage *)imageWithDict:(NSDictionary *)settings {
        
    if (nil == settings) {  //  Default image is nil
        return nil;
    }
    
    if (nil != [settings objectForKey:kThemeKeywordPathNormalImage]) {
        settings = [settings objectForKey:kThemeKeywordPathNormalImage];
    }
    
    UIImage *resImage = nil;
    
    NSString *imageName = [settings objectForKey:kThemeKeywordAttrImageName];
    
    if (nil != [settings objectForKey:kThemeKeywordAttrLeftCapWidth]) {
        NSUInteger leftCapWidth = [[settings objectForKey:kThemeKeywordAttrLeftCapWidth] intValue];
        NSUInteger topCapHeight = [[settings objectForKey:kThemeKeywordAttrTopCapHeight] intValue];
        
        resImage = [[UIImage imageNamed:imageName] stretchableImageWithLeftCapWidth:leftCapWidth
                                                                       topCapHeight:topCapHeight];
    } else if (nil != [settings objectForKey:kThemeKeywordPathTitleEdgeInsets]) {
        UIEdgeInsets edgeInsets = [self edgeInsetsWithDict:[settings objectForKey:kThemeKeywordPathTitleEdgeInsets]];
        resImage = [[UIImage imageNamed:imageName] resizableImageWithCapInsets:edgeInsets];
    } else {
        resImage = [UIImage imageNamed:imageName];

    }
    
    return resImage;
    
}

- (NSString *)imageNameWithDict:(NSDictionary *)settings {
    if (nil == settings) {
        return nil;
    }
    
    return [[settings objectForKey:kThemeKeywordPathNormalImage] objectForKey:kThemeKeywordAttrImageName];
}

- (NSUInteger)lineNumberWithDict:(NSDictionary *)settings {

    if (nil == settings) {
        return 0;
    }
    
    return [[settings objectForKey:kThemeKeywordAttrTextLineNumber] intValue];
}

- (UIEdgeInsets)edgeInsetsWithDict:(NSDictionary *)settings {
    
    if (nil == settings) {
        return UIEdgeInsetsZero;
    }
    
    NSUInteger top = [[settings objectForKey:kThemeKeywordAttrTop] intValue];
    NSUInteger left = [[settings objectForKey:kThemeKeywordAttrLeft] intValue];
    NSUInteger bottom = [[settings objectForKey:kThemeKeywordAttrBottom] intValue];
    NSUInteger right = [[settings objectForKey:kThemeKeywordAttrRight] intValue];
    
    return UIEdgeInsetsMake(top, left, bottom, right);
}


#pragma mark -
#pragma mark Basic Theme setting methods

- (UIColor *)colorOfThemeType:(NSString *)uiType {
    
    NSDictionary *settings = [[self.theme dictionaryOfSettingsWithUIType:uiType] objectForKey:kThemeKeywordPathNormalTextColor];
    
    return [self colorWithDict:settings];
}

- (UIFont *)fontOfThemeType:(NSString *)uiType {
    
    NSDictionary *settings = [[self.theme dictionaryOfSettingsWithUIType:uiType] objectForKey:kThemeKeywordPathTextFont];
    
    return [self fontWithDict:settings];
}

- (CGSize)sizeOfThemeType:(NSString *)uiType {
    
    return [self sizeWithDict:[self.theme dictionaryOfSettingsWithUIType:uiType]];
}

- (UIImage *)imageOfThemeType:(NSString *)uiType {
    
    return [self imageWithDict:[self.theme dictionaryOfSettingsWithUIType:uiType]];
}

- (NSString *)imageNameOfThemeType:(NSString *)uiType {
    return [self imageNameWithDict:[self.theme dictionaryOfSettingsWithUIType:uiType]];
}

- (NSUInteger)lineNumberOfThemeType:(NSString *)uiType {
    
    return [self lineNumberWithDict:[self.theme dictionaryOfSettingsWithUIType:uiType]];
}

#pragma mark -
#pragma mark UI element setting methods
- (void)setLabel:(UILabel *)label withThemeUIType:(NSString *)uiType {
    if ([label.themeType isEqualToString:uiType]) {
        return;
    }
    label.themeType = uiType;

    NSDictionary *settings = [self.theme dictionaryOfSettingsWithUIType:uiType];
    

    //  Set BackgroundColor
    label.backgroundColor = [self colorWithDict:[settings objectForKey:kThemeKeywordPathBackgroundColor]];
    
    //  Set TextColor
    label.textColor = [self colorWithDict:[settings objectForKey:kThemeKeywordPathNormalTextColor]];
    
    //  Set TextHightlightedColor
    label.highlightedTextColor = [self colorWithDict:[settings objectForKey:kThemeKeywordPathHighlightedTextColor]];

    //  Set TextShadowColor
    label.shadowColor = [self colorWithDict:[settings objectForKey:kThemeKeywordPathTextShadowColor]];
    
    //  Set TextShadowOffset
    label.shadowOffset = [self sizeWithDict:[settings objectForKey:kThemeKeywordPathTextShadowOffset]];
    
    //  Set TextFont
    label.font = [self fontWithDict:[settings objectForKey:kThemeKeywordPathTextFont]];
    
    //  Set TextAlignment
    label.textAlignment = [[settings objectForKey:kThemeKeywordAttrTextAlignment] textAlignment];
    
    //  Set
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    
    //  Set TextLineNumber
    label.numberOfLines = [[settings objectForKey:kThemeKeywordAttrTextLineNumber] intValue];
    
    if ([[settings objectForKey:kThemeKeywordAttrSizeToFit] boolValue]) {
        [label sizeToFit];
    }
}

- (void)setButton:(UIButton *)button withThemeUIType:(NSString *)uiType {
    if ([button.themeType isEqualToString:uiType]) {
        return;
    }
    button.themeType = uiType;
    NSDictionary *settings = [self.theme dictionaryOfSettingsWithUIType:uiType];
    
    //  Set BackgroundColor
    button.backgroundColor = [self colorWithDict:[settings objectForKey:kThemeKeywordPathBackgroundColor]];
    
    //  Set Normal Title Color
    [button setTitleColor:[self colorWithDict:[settings objectForKey:kThemeKeywordPathNormalTextColor]] 
                 forState:UIControlStateNormal];

    //  Set Highlighted Title Color
    [button setTitleColor:[self colorWithDict:[settings objectForKey:kThemeKeywordPathHighlightedTextColor]] 
                 forState:UIControlStateHighlighted];
    
    //  Set Disabled Title Color
    [button setTitleColor:[self colorWithDict:[settings objectForKey:kThemeKeywordPathDisabledTextColor]] 
                 forState:UIControlStateDisabled];

    //  Set Disabled Title Shadow Color
    [button setTitleShadowColor:[self colorWithDict:[settings objectForKey:kThemeKeywordPathDisabledTextShadowColor]]
                 forState:UIControlStateDisabled];
    
    //  Set Selected Title Color
    [button setTitleColor:[self colorWithDict:[settings objectForKey:kThemeKeywordPathSelectedTextColor]] 
                 forState:UIControlStateSelected];
    
    //  Set Title ShadowColor
    [button setTitleShadowColor:[self colorWithDict:[settings objectForKey:kThemeKeywordPathTextShadowColor]] 
                       forState:UIControlStateNormal];
    
    //  Set Title ShadowOffset
    button.titleLabel.shadowOffset = [self sizeWithDict:[settings objectForKey:kThemeKeywordPathTextShadowOffset]];
    
    //  Set Title Textfont
    button.titleLabel.font = [self fontWithDict:[settings objectForKey:kThemeKeywordPathTextFont]];
    
    //  Set Title Edge Insets if any
    UIEdgeInsets titleInsets = [self edgeInsetsWithDict:[settings objectForKey:kThemeKeywordPathTitleEdgeInsets]];
    if (!UIEdgeInsetsEqualToEdgeInsets(titleInsets, UIEdgeInsetsZero)) {
        button.titleEdgeInsets = titleInsets;
    }
    
    if ([[settings objectForKey:kThemeKeywordPathShowsTouch] boolValue]) {
        [button setShowsTouchWhenHighlighted:YES];
    }
    


    //  Set Normal BackgroundImage
    [button setImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathNormalImage]]
            forState:UIControlStateNormal];
    
    //  Set Highlighted BackgroundImage
    [button setImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathHighlightedImage]]
            forState:UIControlStateHighlighted];
    
    //  Set Disabled BackgroundImage
    [button setImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathDisabledImage]]
            forState:UIControlStateDisabled];
    
    //  Set Selected BackgroundImage
    [button setImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathSelectedImage]]
            forState:UIControlStateSelected];
    
    // Set ImageEdgeInsets if any
    UIEdgeInsets imageInsets = [self edgeInsetsWithDict:[settings objectForKey:kThemeKeywordPathImageEdgeInsets]];
    if (!UIEdgeInsetsEqualToEdgeInsets(imageInsets, UIEdgeInsetsZero)) {
        button.imageEdgeInsets = imageInsets;
    }
        

    //  Set Normal BackgroundImage
    [button setBackgroundImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathBgNormalImage]]
                      forState:UIControlStateNormal];
    
    //  Set Highlighted BackgroundImage
    [button setBackgroundImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathBgHighlightedImage]]
                      forState:UIControlStateHighlighted];
    
    //  Set Disabled BackgroundImage
    [button setBackgroundImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathBgDisabledImage]]
                      forState:UIControlStateDisabled];
    
    //  Set Selected BackgroundImage
    [button setBackgroundImage:[self imageWithDict:[settings objectForKey:kThemeKeywordPathBgSelectedImage]]
                      forState:UIControlStateSelected];

    
    if ([[settings objectForKey:kThemeKeywordAttrSizeToFit] boolValue]) {
        [button sizeToFit];
    }
}

- (void)setImageView:(UIImageView *)imageView withThemeUIType:(NSString *)uiType {
    if ([imageView.themeType isEqualToString:uiType]) {
        return;
    }
    imageView.themeType = uiType;
    NSDictionary *settings = [self.theme dictionaryOfSettingsWithUIType:uiType];
    
    //  Set BackgroundColor
    imageView.backgroundColor = [self colorWithDict:[settings objectForKey:kThemeKeywordPathBackgroundColor]];
    
    //  Set Image
    imageView.image = [self imageWithDict:[settings objectForKey:kThemeKeywordPathNormalImage]];
    
    //  Set Highlighted Image
    imageView.highlightedImage = [self imageWithDict:[settings objectForKey:kThemeKeywordPathHighlightedImage]];

    //  Set ContentMode
    imageView.contentMode = [[settings objectForKey:kThemeKeywordAttrContentMode] viewContentMode];
    
    if ([[settings objectForKey:kThemeKeywordAttrSizeToFit] boolValue]) {
        [imageView sizeToFit];
    }
}

- (void)setUIView:(UIView *)uiView withThemeUIType:(NSString *)uiType {
    if ([uiView.themeType isEqualToString:uiType]) {
        return;
    }
    uiView.themeType = uiType;
    
    NSDictionary *settings = [self.theme dictionaryOfSettingsWithUIType:uiType];
    
    UIImage *backgroundImage = [self imageWithDict:[settings objectForKey:kThemeKeywordPathNormalImage]];
    
    UIGraphicsBeginImageContextWithOptions(uiView.frame.size, NO, [UIDevice screenScale]);
    [backgroundImage drawInRect:uiView.bounds];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    uiView.backgroundColor = [UIColor colorWithPatternImage:image];
}



@end
