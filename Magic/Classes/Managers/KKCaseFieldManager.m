//
//  KKCaseFieldManager.m
//  Magic
//
//  Created by lixiang on 15/4/22.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseFieldManager.h"
#import "KKCaseItem.h"

@implementation KKCaseFieldManager
SYNTHESIZE_SINGLETON_FOR_CLASS(KKCaseFieldManager);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)shouldShowStandardForCaseType:(KKCaseType)caseType subType:(KKCaseSubType)subType {
    switch (caseType) {
        case KKCaseTypeTrademark:
        {
            switch (subType) {
                case KKCaseSubTypeAssignment:
                    return NO;
                    break;
                case KKCaseSubTypeRenewal:
                    return NO;
                    break;
                case KKCaseSubTypeTransfer:
                    return NO;
                    break;
                case KKCaseSubTypeChange:
                    return NO;
                    break;
                case KKCaseSubTypeCase:
                    return YES;
                    break;
                    
                default:
                    break;
            }
        }
            break;
            
        default:
            break;
    }
    return YES;
}

- (BOOL)shouldShowForCaseType:(KKCaseType)caseType subType:(KKCaseSubType)subType caseFieldType:(KKCaseFieldType)fieldType{
    
    switch (fieldType) {
        case KKCaseFieldTypeTitle:
        {
            switch (subType) {
                case KKCaseSubTypeCase:
                    return YES;
                    break;
                    
                default:
                    return NO;
                    break;
            }
        }
            break;
        case KKCaseFieldTypeApplyName:
        {
            switch (subType) {
                case KKCaseSubTypeAssignment:
                    return YES;
                    break;
                default:
                    return NO;
                    break;
            }
            
        }
            break;
        case KKCaseFieldTypeProductionName:
        {
            switch (subType) {
                case KKCaseSubTypeAssignment:
                    return YES;
                    break;
                default:
                    break;
            }
        }
            break;
        case KKCaseFieldTypeApplyNumber:
        {
            switch (subType) {
                case KKCaseSubTypeChange:
                    return YES;
                    break;
                case KKCaseSubTypeRenewal:
                    return YES;
                    break;
                case KKCaseSubTypeTransfer:
                    return YES;
                    break;
                    
                default:
                    break;
            }
            
        }
            break;
        default:
            break;
    }
    
    return NO;
}


- (NSString *)titleForCaseFieldType:(KKCaseFieldType)fieldType {
    switch (fieldType) {
        case KKCaseFieldTypeTitle:
            return @"标题";
            break;
        case KKCaseFieldTypeApplyName:
            return @"注册名称";
            break;
        case KKCaseFieldTypeProductionName:
            return @"产品名称";
            break;
        case KKCaseFieldTypeApplyNumber:
            return @"商标注册号";
            break;
        default:
            break;
    }
    return @"";
}

- (NSString *)contentForCaseFiedlType:(KKCaseFieldType)fieldType caseItem:(KKCaseItem *)caseItem {
    switch (fieldType) {
        case KKCaseFieldTypeTitle:
            return caseItem.title;
            break;
        case KKCaseFieldTypeApplyName:
            return caseItem.customItem.applyName;
            break;
        case KKCaseFieldTypeProductionName:
            return caseItem.customItem.productionName;
            break;
        case KKCaseFieldTypeApplyNumber:
            return caseItem.customItem.applyNumber;
            break;
        default:
            break;
    }
    return @"";
}


- (NSString *)placeHolderForCaseFieldType:(KKCaseFieldType)caseType {
    return @"";
}

- (BOOL)validFieldForCaseFiedlType:(KKCaseFieldType)fieldType caseItem:(KKCaseItem *)caseItem {
    switch (fieldType) {
        case KKCaseFieldTypeTitle:
            return [caseItem.title hasContent] ? YES : NO;
            break;
        case KKCaseFieldTypeApplyName:
            return [caseItem.customItem.applyName hasContent] ? YES : NO;
            break;
        case KKCaseFieldTypeProductionName:
            return [caseItem.customItem.productionName hasContent] ? YES : NO;
            break;
        case KKCaseFieldTypeApplyNumber:
            return [caseItem.customItem.applyNumber hasContent] ? YES : NO;
            break;
        default:
            break;
    }
    return YES;
}

#pragma mark -
#pragma mark Case SubType

- (NSString *)titleForCaseType:(KKCaseType)type {
    switch (type) {
        case KKCaseTypeTrademark:
            return @"商标服务";
            break;
        case KKCaseTypeCopyright:
            return @"版权服务";
            break;
        case KKCaseTypeLegal:
            return @"律师服务";
            break;
        case KKCaseTypePatent:
            return @"专利服务";
            break;
            
        default:
            break;
    }
    return @"";
}

- (NSString *)titleForCaseSubType:(KKCaseSubType)subType {
    switch (subType) {
        case KKCaseSubTypeAssignment:
            return @"商标申请";
            break;
        case KKCaseSubTypeChange:
            return @"商标变更";
            break;
        case KKCaseSubTypeRenewal:
            return @"商标续展";
            break;
        case KKCaseSubTypeTransfer:
            return @"商标转让";
            break;
        case KKCaseSubTypeCase:
            return @"商标案件";
            break;
        default:
            break;
    }
    return @"";
}

#pragma mark -
#pragma mark KKProfileMenuTag

- (NSString *)titleForProfileMenuType:(KKProfileMenuTagType)type {
    switch (type) {
        case KKProfileMenuTagTypeNeedPay:
            return @"待支付";
            break;
        case KKProfileMenuTagTypeOver:
            return @"已完成";
            break;
        case KKProfileMenuTagTypeShare:
            return @"分享";
            break;
            
        default:
            break;
    }
    return @"";
}

#pragma mark -
#pragma mark KKCaseDetailMenuTag

- (NSString *)titleForCaseDetailMenuType:(KKCaseDetailMenuTagType)type {
    switch (type) {
        case KKCaseDetailMenuTagTypeChat:
            return @"私信客服";
            break;
        case KKCaseDetailMenuTagTypeCall:
            return @"拨打电话";
            break;
            
        default:
            break;
    }
    return @"";
}

- (NSString *)titleForCaseStatusType:(KKCaseStatusType)type {
    switch (type) {
        case KKCaseStatusTypeNew:
            return @"新创建";
            break;
        case KKCaseStatusTypeNeedPay:
            return @"待支付";
            break;
        case KKCaseStatusTypePayed:
            return @"已支付";
            break;
        case KKCaseStatusTypeOver:
            return @"已完成";
            break;
        default:
            break;
    }
    return @"";
}

@end
