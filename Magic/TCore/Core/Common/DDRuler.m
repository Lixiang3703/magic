//
//  DDRuler.m
//  Wuya
//
//  Created by Tong on 14/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDRuler.h"

@implementation DDRuler

+ (CGFloat)topZero {
    return [UIDevice below7] ? 0 : 64;
}

+ (CGFloat)screenWidth {
    return [UIDevice screenWidth];
}

+ (CGFloat)navigationBarHeight {
    return 44;
}

+ (CGFloat)viewTopZeroWithNavigationBar {
    return 64;
}

@end
