//
//  UITableViewCell+DDTableView.m
//  Wuya
//
//  Created by Tong on 17/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "UITableViewCell+DDTableView.h"

@implementation UITableViewCell (DDTableView)

//  Sometimes, it might be nil
- (DDTableView *)ddTableView {
    id view = [self superview];
    
    while (view && ![view isKindOfClass:[DDTableView class]]) {
        view = [view superview];
    }
    
    return (DDTableView *)view;
}


@end
