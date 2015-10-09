//
//  YYChooseSexView.h
//  Wuya
//
//  Created by Lixiang on 14-8-22.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "DDView.h"

@protocol ChooseSexViewDelegate <NSObject>

@optional

- (void)sexChoosedWithSex:(NSInteger)sex;

@end

@interface YYChooseSexView : DDView

@property (assign, nonatomic) id <ChooseSexViewDelegate> delegate;

@end
