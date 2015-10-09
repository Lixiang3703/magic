//
//  YYEmbedUrlEmptyView.m
//
//
//  Created by Lixiang on 14-8-18.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYEmbedUrlEmptyView.h"

@implementation YYEmbedUrlEmptyView

- (UILabel *)tipLabel {
    if (_tipLabel == nil) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.width, 50)];
        [self addSubview:_tipLabel];
    }
    return _tipLabel;
}

- (void)initSettings {
    [self setBackgroundColor:[UIColor clearColor]];
    self.tipLabel.autoresizingMask = UIViewAutoresizingNone;
    self.tipLabel.backgroundColor = [UIColor clearColor];
    self.tipLabel.numberOfLines = 0;
    self.tipLabel.textAlignment = NSTextAlignmentCenter;
    self.tipLabel.text = @"加载失败，轻触屏幕重新加载";
    
    self.tipLabel.top = (self.height - 50) / 2;
    
    self.userInteractionEnabled = YES;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self addGestureRecognizer:gesture];

}

- (void)viewTapped:(UIGestureRecognizer *)sender {
    if (self.viewPressedBlock) {
        self.viewPressedBlock(nil);
    }
}

@end
