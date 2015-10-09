//
//  KKPickerView.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKPickerView.h"
#import "KKPickerItem.h"

#define kPickerViewTopViewHeight   (40)
#define kPickerViewHeight   (236)

@interface KKPickerView()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIImageView *lineView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, assign) NSInteger selectedFirstComponentIndex;

@property (nonatomic, assign) CGFloat realHeight;

@end

@implementation KKPickerView

- (void)selectedObject:(NSString *)displayId animated:(BOOL)animated {
    
}

#pragma mark -
#pragma mark life cycle

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.numberOfComponents = 1;
        self.selectedFirstComponentIndex = 0;
        
        self.maskView = [[UIView alloc] initWithFrame:frame];
        self.maskView.backgroundColor = [UIColor blackColor];
        self.maskView.alpha = 0.2;
        [self.maskView addTarget:self tapAction:@selector(bgViewPressed:)];
        [self addSubview:self.maskView];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(bgViewPressed:)];
        [self.maskView addGestureRecognizer:panGesture];
        
        
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kUI_Login_Common_MarginW, self.realHeight - kPickerViewHeight - kPickerViewTopViewHeight, self.width - kUI_Login_Common_MarginW, kPickerViewTopViewHeight)];
//        [self.titleLabel setThemeUIType:kThemePersonSmallGrayLabel];
        [self addSubview:self.titleLabel];
        
        self.lineView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.titleLabel.bottom-0.5, self.width, 0.5)];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:self.lineView];
        
        self.pickerView = [[UIPickerView alloc] init];
        self.pickerView.backgroundColor = [UIColor whiteColor];
        self.pickerView.height = kPickerViewHeight;
        self.pickerView.top = self.realHeight - kPickerViewHeight;
        self.pickerView.dataSource = self;
        self.pickerView.delegate = self;
        self.pickerView.showsSelectionIndicator = YES;
        [self addSubview:self.pickerView];
    }
    return self;
}

- (instancetype)init {
    self.realHeight = [UIDevice screenHeight] + 20;
    return [self initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], [UIDevice screenHeight])];
}

- (instancetype)initWithNumberOfComponents:(NSInteger)numberOfComponents {
    self = [self init];
    if (self) {
        self.numberOfComponents = numberOfComponents;
    }
    return self;
}

#pragma mark -
#pragma mark show or hide operation.

- (void)showInView:(UIView *)view completion:(void (^)(BOOL))completion adjustBottom:(BOOL)adjustBottom {
    if ([self superview]) {
        [self removeFromSuperview];
    }
    
    if (view) {
        [view addSubview:self];
    }
    
    self.bottom = view.bottom;
    
    if (adjustBottom) {
        self.bottom = view.bottom - 64;
    }
    
    self.pickerView.top = view.bottom;
    [UIView animateWithDuration:0.25 animations:^{
        self.titleLabel.alpha = 1;
        self.lineView.alpha = 1;
        self.pickerView.top = self.realHeight - kPickerViewHeight;
        if (self.pickerShowBlock) {
            self.pickerShowBlock(nil,nil);
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion(finished);
        }
    }];
}

- (void)showInView:(UIView *)view completion:(void (^)(BOOL finished))completion {
    [self showInView:view completion:completion adjustBottom:YES];
}

- (void)dismissWithAnimated:(BOOL)animated {
    self.titleLabel.alpha = 0;
    self.lineView.alpha = 0;
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.pickerView.top = [UIDevice screenHeight];
        } completion:^(BOOL finished) {
            self.top = [UIDevice screenHeight];
        }];
    } else {
        self.top = [UIDevice screenHeight];
    }
}

- (void)reloadDataWithDataSoure:(NSArray *)dataSoure {
    self.dataSource = [dataSoure copy];
    [self.pickerView reloadAllComponents];
}

- (void)bgViewPressed:(id)sender {
    [self dismissWithAnimated:YES];
    if (self.pickerDismissBlock) {
        self.pickerDismissBlock(nil,nil);
    }
}

#pragma mark -
#pragma mark  UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.numberOfComponents;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.dataSource count];
}

#pragma mark -
#pragma mark   UIPickerViewDelegate

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.width;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 44;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component > self.numberOfComponents) {
        return @"cc";
    }
    
    if (component == 0) {
        KKPickerItem *pickerItem = self.dataSource[row];
        return pickerItem.displayString;
    }
    else if (component == 1) {
        KKPickerItem *pickerItem = self.dataSource[self.selectedFirstComponentIndex];
        if (pickerItem.childPickerItems.count < row) {
            KKPickerItem *childPickerItem = pickerItem.childPickerItems[row];
            return childPickerItem.displayString;
        }
    }
    
    return @"cc";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    KKPickerItem *pickerItem = self.dataSource[row];
    if (self.numberOfComponents == 1) {
        if (self.pickerSelectedBlock) {
            self.pickerSelectedBlock(pickerItem, pickerItem.rawObject);
        }
    }
    else if (self.numberOfComponents == 2)
    {
        if (component == 1) {
            if (self.pickerSelectedBlock) {
                self.pickerSelectedBlock(pickerItem, pickerItem.rawObject);
            }
        }
        else if (component == 0) {
            self.selectedFirstComponentIndex = row;
            [self.pickerView reloadComponent:component + 1];
        }
    }
    
    if (self.pickerSelectedBlock) {
        self.pickerSelectedBlock(pickerItem, pickerItem.rawObject);
    }
}

@end










