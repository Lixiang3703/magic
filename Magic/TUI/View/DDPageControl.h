//
//  DDPageControl.h
//  PAPA
//
//  Created by Tong on 14/08/2013.
//  Copyright (c) 2013 diandian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMPageControl.h"

typedef enum _DDPageControlType {
    DDPageControlTypeBlack,
    DDPageControlTypeRed,
    DDPageControlTypeLight,
} DDPageControlType;

@interface DDPageControl : SMPageControl

- (id)initWithFrame:(CGRect)frame type:(DDPageControlType)type;

@end
