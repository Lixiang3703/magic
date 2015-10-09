//
//  DDBadgeView.h
//  Wuya
//
//  Created by Tong on 26/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, DDBadgeViewType) {
    DDBadgeViewTypeNone = 0,
    DDBadgeViewTypeSmall,
    DDBadgeViewTypeMiddle,
    DDBadgeViewTypeLarge,
};

@interface DDBadgeView : UIImageView

@property (nonatomic, assign) DDBadgeViewType type;
@property (nonatomic, assign) CGPoint centerPoint;

- (instancetype)initWithCenterPoint:(CGPoint)centerPoint type:(DDBadgeViewType)type;

- (void)setBadgeCount:(NSUInteger)count;
- (void)setBadgeString:(NSString *)badgeString;

@end
