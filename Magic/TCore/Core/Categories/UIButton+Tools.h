//
//  UIButton+Tools.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UIButtonImageEdgeInsetType) {
    UIButtonImageEdgeInsetTypeNone = 0,                 //默认
    UIButtonImageEdgeInsetTypeTop,                      //图片在文字上面
    UIButtonImageEdgeInsetTypeBottom,                   //图片在文字下面
    UIButtonImageEdgeInsetTypeLeft,                     //图片在文字左面
    UIButtonImageEdgeInsetTypeRight,                    //图片在文字右面
};


@interface UIButton (Tools)

- (void)setImageEdgeInsetsType:(UIButtonImageEdgeInsetType)edgeInsetType
                    textOffSet:(CGFloat)textOffSet
                   imageOffSet:(CGFloat)imageOffSet;

/*
 --edgeInsetType   设置类型
 --textHorizontalOffSet   设置text的水平偏移
 --textVerticalOffSet     设置text的垂直偏移,Left和Right时设为0即可
 --imageHorizontalOffSet  设置image的水平偏移
 --imageVerticalOffSet    设置image的垂直偏移,Left和Right时设为0即可
 */

- (void)setImageEdgeInsetsType:(UIButtonImageEdgeInsetType)edgeInsetType
          textHorizontalOffSet:(CGFloat)textHorizontalOffSet
            textVerticalOffSet:(CGFloat)textVerticalOffSet
         imageHorizontalOffSet:(CGFloat)imageHorizontalOffSet
           imageVerticalOffSet:(CGFloat)imageVerticalOffSet;

@end


@interface UIButton (HitTestEdgeInsets)

@property(nonatomic, assign) UIEdgeInsets hitTestEdgeInsets;

@end
