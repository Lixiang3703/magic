//
//  UIDevice+Tools.h
//  PMP
//
//  Created by Tong on 12/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDevice_iOS7_DefaultTopHeight       (64)
#define isRetina() (([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2.0))

@interface UIDevice (Tools)

+ (CGFloat)screenScale;
+ (BOOL)is4InchesScreen;
+ (BOOL)isRetina;
+ (CGFloat)screenHeight;
+ (CGFloat)screenWidth;
+ (BOOL)isInCallStatusBar;


+ (BOOL)isJailBreak;

+ (BOOL)below5;
+ (BOOL)below6;
+ (BOOL)below7;
+ (BOOL)below8;


/** Platform */
+ (NSString *)platform;
+ (NSString *)stringForPlatform;

//+ (NSString *)deviceIdentifier;


/** Push Enabled */
+ (BOOL)pushEnabled;

@end
