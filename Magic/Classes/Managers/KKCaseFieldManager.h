//
//  KKCaseFieldManager.h
//  Magic
//
//  Created by lixiang on 15/4/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKCaseItem.h"

@interface KKCaseFieldManager : DDSingletonObject


/** Initialization */
+ (KKCaseFieldManager *)getInstance;

- (BOOL)shouldShowForCaseType:(KKCaseType)caseType subType:(KKCaseSubType)subType caseFieldType:(KKCaseFieldType)fieldType;

- (NSString *)titleForCaseType:(KKCaseType)type;

- (NSString *)titleForCaseSubType:(KKCaseSubType)subType;

- (NSString *)titleForCaseFieldType:(KKCaseFieldType)fieldType;

- (NSString *)contentForCaseFiedlType:(KKCaseFieldType)fieldType caseItem:(KKCaseItem *)caseItem;

- (BOOL)validFieldForCaseFiedlType:(KKCaseFieldType)fieldType caseItem:(KKCaseItem *)caseItem;

- (NSString *)titleForProfileMenuType:(KKProfileMenuTagType)type;
- (NSString *)titleForCaseDetailMenuType:(KKCaseDetailMenuTagType)type;

- (NSString *)titleForCaseStatusType:(KKCaseStatusType)type;

@end
