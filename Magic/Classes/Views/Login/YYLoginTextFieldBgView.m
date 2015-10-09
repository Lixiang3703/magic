//
//  DDLoginTextFieldBgView.m
//  Wuya
//
//  Created by Tong on 21/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYLoginTextFieldBgView.h"
#import <QuartzCore/QuartzCore.h>

@implementation YYLoginTextFieldBgView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.borderWidth = 1;
        self.layer.borderColor = [[UIColor YYTextFieldBorderColor] CGColor];
        self.layer.cornerRadius = 2;
        self.userInteractionEnabled = YES;
    }
    return self;
}


@end
