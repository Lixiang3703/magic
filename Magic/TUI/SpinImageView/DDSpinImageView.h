//
//  DDSpinView.h
//  TongTest
//
//  Created by Tong on 30/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DDSpinImageView : UIView

@property (nonatomic, assign, getter = isAnimating) BOOL animating;

/** Animation */
- (void)startSpinAnimation;
- (void)stopSpinAnimation;

@end
