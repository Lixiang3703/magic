//
//  YYSinglePickerView.h
//  Wuya
//
//  Created by lilingang on 14-9-20.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "DDView.h"
#import "YYPickerItem.h"

@interface YYSinglePickerView : DDView

@property (nonatomic, copy) DDBlock pickerSelectedBlock;

@property (nonatomic, strong) UILabel *titleLabel;

- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion;

- (void)dismissWithAnimated:(BOOL)animated;

- (void)reloadDataWithDataSoure:(NSArray *)dataSoure;

- (void)selectedObject:(NSString *)string animated:(BOOL)animated;

@end
