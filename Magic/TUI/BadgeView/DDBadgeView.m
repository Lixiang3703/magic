//
//  DDBadgeView.m
//  Wuya
//
//  Created by Tong on 26/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBadgeView.h"

@interface DDBadgeView ()

@property (nonatomic, strong) UILabel *badgeLabel;

@property (nonatomic, assign) CGFloat side;

@end

@implementation DDBadgeView

- (instancetype)initWithCenterPoint:(CGPoint)centerPoint type:(DDBadgeViewType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.type = type;
        self.centerPoint = centerPoint;
        
        switch (type) {
            case DDBadgeViewTypeLarge:
                [self setThemeUIType:kLinkThemeBadgeLargeImageView];
                break;
            case DDBadgeViewTypeMiddle:
                [self setThemeUIType:kLinkThemeBadgeMiddleImageView];
                break;
            case DDBadgeViewTypeSmall:
                [self setThemeUIType:kLinkThemeBadgeSmallImageView];
                break;
            default:
                break;
        }
        
        self.side = self.width;
        
        self.middleX = self.centerPoint.x;
        self.middleY = self.centerPoint.y;
        
        self.top = ceilf(self.top);
        self.left = ceilf(self.left);
        
        self.badgeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        [self.badgeLabel fullfillPrarentView];
        self.badgeLabel.backgroundColor = [UIColor clearColor];
        self.badgeLabel.textColor = [UIColor whiteColor];
        self.badgeLabel.highlightedTextColor = [UIColor whiteColor];
        self.badgeLabel.textAlignment = NSTextAlignmentCenter;
        
        self.badgeLabel.font = [UIFont systemFontOfSize:floorf(self.width / 1.2)];
        
        [self addSubview:self.badgeLabel];
        
    }
    return self;
}

- (void)setBadgeCount:(NSUInteger)count {
    NSString *countString = nil;
    switch (self.type) {
        case DDBadgeViewTypeNone:
            
            break;
        case DDBadgeViewTypeSmall:
        case DDBadgeViewTypeMiddle:
            countString = count > 0 ? @"" : nil;
            break;
        case DDBadgeViewTypeLarge:
            countString = [NSString stringWithFormat:@"%ld", (long)count];
            if (count == 0) {
                countString = nil;
            } else if (count > 99) {
                countString = @"99";
            }
            break;
        default:
            break;
    }
    
    [self setBadgeString:countString];

}

- (void)setBadgeString:(NSString *)badgeString {
    
    self.hidden = nil == badgeString;
    
    if (!self.hidden) {
        CGFloat width = ceilf([badgeString sizeWithAttributes:@{NSFontAttributeName:self.badgeLabel.font}].width);
        self.badgeLabel.text = badgeString;
        self.width = floorf(self.side) + width - floorf(self.side / 2);
        self.width = MAX(self.side, self.width);
        self.middleX = self.centerPoint.x;
        self.middleY = self.centerPoint.y;
    }
}

@end
