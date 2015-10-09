//
//  UIButton+Tools.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UIButton+Tools.h"
#import <objc/runtime.h>

static const NSString *KEY_HIT_TEST_EDGE_INSETS = @"HitTestEdgeInsets";

@implementation UIButton (Tools)

- (void)setImageEdgeInsetsType:(UIButtonImageEdgeInsetType)edgeInsetType
                    textOffSet:(CGFloat)textOffSet
                   imageOffSet:(CGFloat)imageOffSet{
    
    switch (edgeInsetType) {
        case UIButtonImageEdgeInsetTypeNone:{
            self.imageEdgeInsets = UIEdgeInsetsZero;
            self.titleEdgeInsets = UIEdgeInsetsZero;
        }
            break;
        case UIButtonImageEdgeInsetTypeTop:
        case UIButtonImageEdgeInsetTypeBottom:{
            NSAssert(nil, @"must use setImageEdgeInsetsType:textHorizontalOffSet... method ");
        }
            break;
        case UIButtonImageEdgeInsetTypeLeft:{
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, -textOffSet, 0.0, textOffSet);
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, imageOffSet, 0.0, -imageOffSet);
        }
            break;
        case UIButtonImageEdgeInsetTypeRight:{
            self.imageEdgeInsets = UIEdgeInsetsMake(0.0, textOffSet, 0.0, -textOffSet);
            self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageOffSet, 0.0, imageOffSet);
        }
            break;
        default:
            break;
    }
}

- (void)setImageEdgeInsetsType:(UIButtonImageEdgeInsetType)edgeInsetType
          textHorizontalOffSet:(CGFloat)textHorizontalOffSet
            textVerticalOffSet:(CGFloat)textVerticalOffSet
         imageHorizontalOffSet:(CGFloat)imageHorizontalOffSet
           imageVerticalOffSet:(CGFloat)imageVerticalOffSet{
    
    switch (edgeInsetType) {
        case UIButtonImageEdgeInsetTypeNone:{
            self.imageEdgeInsets = UIEdgeInsetsZero;
            self.titleEdgeInsets = UIEdgeInsetsZero;
        }
            break;
        case UIButtonImageEdgeInsetTypeTop:{
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageVerticalOffSet, 0.0, imageVerticalOffSet, 0.0);
            self.titleEdgeInsets = UIEdgeInsetsMake(textVerticalOffSet, -textHorizontalOffSet, -textVerticalOffSet, 0.0);
        }
            break;
        case UIButtonImageEdgeInsetTypeBottom:{
            //TODO:用到的时候再改
            //self.imageEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -titleSize.height, - titleSize.width);
            //self.titleEdgeInsets = UIEdgeInsetsMake(-(imageSize.height + spacing), -imageSize.width, 0.0, 0.0);
        }
            break;
        case UIButtonImageEdgeInsetTypeLeft:
        case UIButtonImageEdgeInsetTypeRight:{
            NSAssert(nil, @"must use setImageEdgeInsetsType:textOffSet... method ");
        }
            break;
        default:
            break;
    }
}
@end



@implementation UIButton (HitTestEdgeInsets)

@dynamic hitTestEdgeInsets;


-(void)setHitTestEdgeInsets:(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = [NSValue value:&hitTestEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIEdgeInsets)hitTestEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, &KEY_HIT_TEST_EDGE_INSETS);
    if(value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    }else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if(UIEdgeInsetsEqualToEdgeInsets(self.hitTestEdgeInsets, UIEdgeInsetsZero) || !self.enabled || self.hidden) {
        return [super pointInside:point withEvent:event];
    }
    
    CGRect relativeFrame = self.bounds;
    CGRect hitFrame = UIEdgeInsetsInsetRect(relativeFrame, self.hitTestEdgeInsets);
    
    return CGRectContainsPoint(hitFrame, point);
}

@end
