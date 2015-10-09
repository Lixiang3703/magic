//
//  KKCaseItem.h
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "YYBaseAPIItem.h"
#import "KKCaseCustomItem.h"
#import "KKCaseTypeItem.h"
#import "KKImageItem.h"

@interface KKCaseItem : YYBaseAPIItem

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) KKCaseType type;
@property (nonatomic, assign) KKCaseSubType subType;
@property (nonatomic, assign) NSInteger industryId;
@property (nonatomic, copy) NSString *caseId;

@property (nonatomic, copy) NSString *custom;
@property (nonatomic, assign) KKCaseStatusType status;
@property (nonatomic, assign) DDBaseItemBool pay;
@property (nonatomic, assign) double price;

@property (nonatomic, strong) KKCaseCustomItem *customItem;
@property (nonatomic, strong) KKCaseTypeItem *typeItem;
@property (nonatomic, strong) KKImageItem *trademarkItem;

- (void)createCustom;
- (void)createTitle;


@end
