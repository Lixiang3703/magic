//
//  KKPickerView.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDView.h"
#import "KKPickerItem.h"

/** Common Block */
typedef void (^KKPickerViewBlock)(KKPickerItem *pickerItem, id userInfo);

@interface KKPickerView : DDView

@property (nonatomic, assign) NSInteger numberOfComponents;

@property (nonatomic, copy) KKPickerViewBlock pickerSelectedBlock;

@property (nonatomic, copy) KKPickerViewBlock pickerShowBlock;
@property (nonatomic, copy) KKPickerViewBlock pickerDismissBlock;

@property (nonatomic, strong) UILabel *titleLabel;

- (instancetype)initWithNumberOfComponents:(NSInteger)numberOfComponents;

- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion;
- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion adjustBottom:(BOOL)adjustBottom;


- (void)dismissWithAnimated:(BOOL)animated;

- (void)reloadDataWithDataSoure:(NSArray *)dataSoure;

- (void)selectedObject:(NSString *)displayId animated:(BOOL)animated;

@end
