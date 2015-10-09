//
//  YYDropDownChooseProtocol.h
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol YYDropDownChooseDelegate <NSObject>

- (void)chooseAtSection:(NSInteger)section index:(NSInteger)index;
- (BOOL)shouldChooseSection:(NSInteger)section;

@end

@protocol YYDropDownChooseDataSource <NSObject>

-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;

@optional
-(NSInteger)defaultShowSection:(NSInteger)section;
- (CGFloat)currentDropDownTableViewControllerTop;

@end
