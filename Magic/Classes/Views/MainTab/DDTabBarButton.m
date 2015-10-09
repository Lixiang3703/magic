//
//  DDTabBarButton.m
//  PAPA
//
//  Created by Tong on 28/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import "DDTabBarGlobal.h"
#import "DDBadgeView.h"

@interface DDTabBarButton ()

@end

@implementation DDTabBarButton

#pragma mark -
#pragma mark Life Cycle

- (id)initWithFrame:(CGRect)frame tabBarItem:(DDTabBarItem *)tabBarItem {
    self = [super initWithFrame:frame];
    if (self) {
        self.tabBarItem = tabBarItem;
        [self uiSettings];
    }
    return self;
}

#pragma mark -
#pragma mark UI
- (void)uiSettings {
    
    [self setTitle:self.tabBarItem.title forState:UIControlStateNormal];
    self.titleLabel.font = self.tabBarItem.font;
    self.titleLabel.height = self.titleLabel.font.lineHeight;
    [self setTabHighLighted:NO];

    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.contentMode = UIViewContentModeCenter;
    
    self.backgroundColor = self.tabBarItem.inverse ? self.tabBarItem.backgroundInverseColor : self.tabBarItem.backgroundNormalColor;
    
    if (DDBadgeViewTypeNone != self.tabBarItem.badgeViewtype) {
        self.badgeView = [[DDBadgeView alloc] initWithCenterPoint:CGPointMake(self.width - 22, 10) type:self.tabBarItem.badgeViewtype];
        self.badgeView.hidden = YES;
        
        [self addSubview:self.badgeView];
    }
    
    if (self.tabBarItem.showHorizontalLine) {
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(self.width - 0.5, 0, 0.5, self.height)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.tabBarItem.normalButton) {
        self.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        return;
    }
    
    CGFloat topEdge = self.tabBarItem.edgeInsets.top;
    CGFloat bottomEdge = self.tabBarItem.edgeInsets.bottom;
    CGFloat leftEdge = self.tabBarItem.edgeInsets.left;
    CGFloat rightEdge = self.tabBarItem.edgeInsets.right;
    
    if (self.tabBarItem.title && self.tabBarItem.imageName) {
        
        CGRect frame = CGRectMake(0.0f + leftEdge, 5.0f + topEdge, self.width - leftEdge - rightEdge, self.height - kDDTabBarButtonLabelHeight - topEdge - bottomEdge);
        self.imageView.frame = frame;
        
        frame = CGRectMake(0.0f + leftEdge, 3.0f + self.height - kDDTabBarButtonLabelHeight + topEdge, self.width - leftEdge - rightEdge, kDDTabBarButtonLabelHeight - topEdge - bottomEdge);
        self.titleLabel.frame = frame;
        
    } else if(self.tabBarItem.title){
        
        self.imageView.hidden = YES;
        CGRect frame = CGRectMake(leftEdge, topEdge, self.width, self.height);
        self.titleLabel.frame = frame;
  
    } else {
        
        self.titleLabel.hidden = YES;
        CGRect frame = CGRectMake(leftEdge, topEdge, self.width, self.height);
        self.imageView.frame = frame;
    }
}

- (void)setTabHighLighted:(BOOL)highLighted {
    if (highLighted) {
        
        [self setTitleColor:self.tabBarItem.inverse ? self.tabBarItem.titleInverseColor : self.tabBarItem.titleInverseColor forState:UIControlStateHighlighted];
        [self setTitleColor:self.tabBarItem.inverse ? self.tabBarItem.titleInverseColor : self.tabBarItem.titleInverseColor forState:UIControlStateNormal];
        
        [self setImage:[UIImage imageNamed:self.tabBarItem.selectedImageName] forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:self.tabBarItem.selectedImageName] forState:UIControlStateNormal];
        
        [self setBackgroundImage:self.tabBarItem.backgroundImage forState:UIControlStateNormal];
        [self setBackgroundImage:self.tabBarItem.backgroundImage forState:UIControlStateHighlighted];
        
    } else {
        [self setTitleColor:self.tabBarItem.inverse ? self.tabBarItem.titleInverseColor : self.tabBarItem.titleNormalColor forState:UIControlStateNormal];
        [self setTitleColor:self.tabBarItem.inverse ? self.tabBarItem.titleInverseColor : self.tabBarItem.titleNormalColor forState:UIControlStateHighlighted];
        [self setImage:[UIImage imageNamed:self.tabBarItem.imageName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:self.tabBarItem.selectedImageName] forState:UIControlStateHighlighted];
        
        [self setBackgroundImage:nil forState:UIControlStateNormal];
        [self setBackgroundImage:nil forState:UIControlStateHighlighted];
    }
}

@end
