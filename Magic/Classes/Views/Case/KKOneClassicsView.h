//
//  KKOneClassicsView.h
//  Magic
//
//  Created by lixiang on 15/4/24.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDTImageView.h"

@interface KKOneClassicsView : UIView

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DDTImageView *imageView;

- (void)injectDataWithImageUrl:(NSString *)imageUrl local:(BOOL)local title:(NSString *)title;

@end
