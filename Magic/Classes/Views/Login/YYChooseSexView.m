//
//  YYChooseSexView.m
//  Wuya
//
//  Created by Lixiang on 14-8-22.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYChooseSexView.h"

@interface YYChooseSexView()

@property (nonatomic, strong) UILabel *topLabel;
@property (nonatomic, strong) UIButton *boyButton;
@property (nonatomic, strong) UIButton *girlButton;

@end

@implementation YYChooseSexView

#pragma mark-
#pragma mark life cycle

- (void)dealloc {
    self.delegate = nil;
}

- (void)initSettings {
    [super initSettings];
    
    [self setBackgroundColor:[UIColor whiteColor]];
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = [UIColor blackColor].CGColor;
    self.layer.cornerRadius = 5;
    
    [self addSubview:self.topLabel];
    [self addSubview:self.boyButton];
    [self addSubview:self.girlButton];

}

#pragma mark-
#pragma mark accessor

- (UILabel *)topLabel {
    if (_topLabel == nil) {
        _topLabel = [[UILabel alloc] initWithFrame:ccr(0, 0, self.width, 53)];
        [_topLabel setTextAlignment:NSTextAlignmentCenter];
        [_topLabel setText:@"请选择你的性别"];
//        _topLabel.layer.borderColor = [UIColor blackColor].CGColor;
//        _topLabel.layer.borderWidth = 1;
        
        CALayer *bottomBorder = [CALayer layer];
        bottomBorder.frame = CGRectMake(0.0f, _topLabel.height - 1, _topLabel.width, 1.0f);
        bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f].CGColor;
        
        [_topLabel.layer addSublayer:bottomBorder];

    }
    return _topLabel;
}

- (UIButton *)boyButton {
    if (_boyButton == nil) {
        _boyButton = [[UIButton alloc] initWithFrame:ccr(0, 53, self.width/2, self.height - 53)];
        _boyButton.tag = 1;
        [_boyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_boyButton setImage:[UIImage imageNamed:@"introChooseSexBoy"] forState:UIControlStateNormal];
        [_boyButton setImageEdgeInsets:UIEdgeInsetsMake(-20, 40, 0, 0)];
        [_boyButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:ccr(40, 80, _boyButton.width - 40, 20)];
        [titleLabel setText:@"男生"];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_boyButton addSubview:titleLabel];
    }
    return _boyButton;
}

- (UIButton *)girlButton {
    if (_girlButton == nil) {
        _girlButton = [[UIButton alloc] initWithFrame:ccr(self.width/2, 53, self.width/2, self.height - 53)];
        _girlButton.tag = 0;
        [_girlButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_girlButton setImage:[UIImage imageNamed:@"introChooseSexGirl"] forState:UIControlStateNormal];
        [_girlButton setImageEdgeInsets:UIEdgeInsetsMake(-20, -40, 0, 0)];
        [_girlButton addTarget:self action:@selector(sexButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:ccr(0, 80, _girlButton.width - 40, 20)];
        [titleLabel setText:@"女生"];
        [titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_girlButton addSubview:titleLabel];
    }
    return _girlButton;
}

- (void)sexButtonClick:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sexChoosedWithSex:)]) {
        [self.delegate sexChoosedWithSex:sender.tag];
    }
}

@end
