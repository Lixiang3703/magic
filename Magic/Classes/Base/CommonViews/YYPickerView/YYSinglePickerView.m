//
//  YYSinglePickerView.m
//  Wuya
//
//  Created by lilingang on 14-9-20.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYSinglePickerView.h"

@interface YYSinglePickerView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView *pickerView;

@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation YYSinglePickerView

- (void)selectedObject:(NSString *)string animated:(BOOL)animated{
     __block NSInteger row = 0;
    [self.dataSource enumerateObjectsUsingBlock:^(YYPickerItem *obj, NSUInteger idx, BOOL *stop) {
        if ([obj.displayString isEqualToString:string]) {
            row = idx;
            *stop = YES;
        }
    }];
    [self.pickerView selectRow:row inComponent:0 animated:animated];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor YYViewBgColor];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, 0, self.width - kUI_Login_Common_MarginW, kUI_Login_Common_Margin)];
        [self.titleLabel setThemeUIType:kThemePersonSmallGrayLabel];
        [self addSubview:self.titleLabel];
        
        UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom-0.5, self.width, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lineView];
        
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.top = self.titleLabel.bottom;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        [self addSubview:self.pickerView];
    }
    return self;
}

- (instancetype)init{
   return [self initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], 236)];
}

- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion{
    [UIView animateWithDuration:0.25 animations:^{
        self.bottom = view.bottom - ([UIDevice below7] ? 0 : 64);
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)dismissWithAnimated:(BOOL)animated{
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.top = [UIDevice screenHeight];
        } completion:^(BOOL finished) {
        }];
    } else {
        self.top = [UIDevice screenHeight];
    }
}

- (void)reloadDataWithDataSoure:(NSArray *)dataSoure{
    self.dataSource = [dataSoure copy];
    [self.pickerView reloadAllComponents];
}

#pragma mark -
#pragma mark  UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [self.dataSource count];
}

#pragma mark -
#pragma mark   UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return self.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    YYPickerItem *pickerItem = self.dataSource[row];
    return pickerItem.displayString;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    YYPickerItem *pickerItem = self.dataSource[row];
    if (self.pickerSelectedBlock) {
        self.pickerSelectedBlock(pickerItem.rawObject);
    }
}
@end
