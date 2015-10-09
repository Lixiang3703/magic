//
//  DDNaviIconRightTitleView.m
//  Mood
//
//  Created by Tong on 25/08/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDNaviIconRightTitleView.h"

@implementation DDNaviIconRightTitleView

- (id)initWithImage:(UIImage *)image title:(NSString *)title {
    CGFloat width = ceilf([title sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithThemeUIType:kThemeNavigationBarTitleButton]}].width) + 24;
    self = [super initWithFrame:CGRectMake(0, 0, MIN(width, 180), 44)];
    if (self) {
        
        
        [self setThemeUIType:kThemeNavigationBarTitleButton];
        
        [self setImage:image forState:UIControlStateNormal];
        [self setImage:image forState:UIControlStateHighlighted];
        [self setTitle:title forState:UIControlStateNormal];
        
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.titleLabel.frame = self.bounds;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.imageView.frame = CGRectMake(self.width - 24, 1, 24, self.height);
    self.imageView.contentMode = UIViewContentModeCenter;
    
}


@end
