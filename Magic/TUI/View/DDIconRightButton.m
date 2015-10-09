//
//  DDIconRightButton.m
//  PAPA
//
//  Created by Tong on 29/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import "DDIconRightButton.h"

#define kDDIconRightButton_IconWidth    (20)

@implementation DDIconRightButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.imageView.contentMode = UIViewContentModeCenter;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect frame = CGRectZero;
    
    if (self.compact) {
        CGFloat textWidth = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}].width;
        
        CGFloat x = (self.width - textWidth - kDDIconRightButton_IconWidth) / 2 + self.leftOffset;
        self.titleLabel.left = x;
        x += textWidth;
        self.imageView.left = x + 3;
    } else {
        frame = CGRectMake(self.width - kDDIconRightButton_IconWidth - 3, 0.0f, kDDIconRightButton_IconWidth, self.height);
        self.imageView.frame = frame;
        
        frame = CGRectMake(0.0f, 0, self.width - kDDIconRightButton_IconWidth, self.height);
        self.titleLabel.frame = frame;
    }

}

@end
