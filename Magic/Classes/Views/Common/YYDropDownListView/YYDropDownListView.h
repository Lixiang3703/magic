//
//  YYDropDownListView.h
//  Wuya
//
//  Created by lixiang on 15/3/24.
//  Copyright (c) 2015年 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYDropDownChooseProtocol.h"

#define SECTION_BTN_TAG_BEGIN   1000
#define SECTION_IV_TAG_BEGIN    3000

#define SECTION_Label_TAG_BEGIN   4000

@interface YYDropDownListView : UIView    

@property (nonatomic, assign) id<YYDropDownChooseDelegate> dropDownDelegate;
@property (nonatomic, assign) id<YYDropDownChooseDataSource> dropDownDataSource;

@property (nonatomic, strong) UIView *mSuperView;

@property (nonatomic, assign) NSInteger currentExtendSection;
@property (nonatomic, assign) BOOL hideBottomLine;

@property (nonatomic, assign) BOOL cannotCancel;

- (id)initWithFrame:(CGRect)frame dataSource:(id)datasource delegate:(id) delegate;
- (void)setTitle:(NSString *)title inSection:(NSInteger)section;

- (void)showChooseListTableViewInSection:(NSInteger)section choosedIndex:(NSInteger)index;
- (void)chooseIndex:(NSInteger)index inSection:(NSInteger)section;

- (BOOL)isShow;

- (void)hideExtendedTableView;

@end
