//
//  KKTypes.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//


typedef NS_ENUM(NSUInteger, KKPayType) {
    KKPayTypeUnKnown = 0,
    KKPayTypeWeixin = 1,
    KKPayTypeAli = 2,
    KKPayTypeCount
};


typedef NS_ENUM(NSUInteger, KKPersonRoleType) {
    KKPersonRoleTypeUnKnown = 0,
    KKPersonRoleTypeNormal = 1,
    KKPersonRoleTypeAgent = 2,
    KKPersonRoleTypeCount
};

typedef NS_ENUM(NSUInteger, KKCaseStatusType) {
    KKCaseStatusTypeUnKnown = 0,
    KKCaseStatusTypeNew = 1,
    KKCaseStatusTypeNeedPay = 2,
    KKCaseStatusTypePayed = 3,
    KKCaseStatusTypeOver = 4,
    KKCaseStatusTypeCount
};

// Case field

typedef NS_ENUM(NSUInteger, KKCaseFieldType) {
    KKCaseFieldTypeUnKnown = 0,
    KKCaseFieldTypeTitle,
    KKCaseFieldTypeApplyName,
    KKCaseFieldTypeProductionName,
    KKCaseFieldTypeApplyNumber,
    
    KKCaseFieldTypeCount
};

typedef NS_ENUM(NSUInteger, KKCaseType) {
    KKCaseTypeUnKnown = 0,
    KKCaseTypeTrademark = 1,
    KKCaseTypeCopyright = 2,
    KKCaseTypePatent = 3,
    KKCaseTypeLegal = 4,
    
    KKCaseTypeCount
};

typedef NS_ENUM(NSUInteger, KKCaseSubType) {
    KKCaseSubTypeUnKnown = 0,
    KKCaseSubTypeAssignment = 5,
    KKCaseSubTypeTransfer = 6,
    KKCaseSubTypeRenewal = 7,
    KKCaseSubTypeChange = 8,
    KKCaseSubTypeCase = 9,
    
    KKCaseSubTypeCount
};

typedef NS_ENUM(NSUInteger, KKProfileTagType) {
    KKProfileTagTypeUnknown = 0,
    KKProfileTagTypeName,               //名字
    KKProfileTagTypeCompanyName,
    KKProfileTagTypeParentName,
    KKProfileTagTypeCode,
    KKProfileTagTypeCount
};

typedef NS_ENUM(NSUInteger, KKMessageType) {
    KKMessageTypeUnKnown = 0,
    KKMessageTypeCaseStatus = 1,
    KKMessageTypeCaseMessage = 2,
    KKMessageTypePage = 10,
    KKMessageTypeCount
};

typedef NS_ENUM(NSUInteger, KKProfileMenuTagType) {
    KKProfileMenuTagTypeUnknown = 0,
    KKProfileMenuTagTypeNeedPay,               //名字
    KKProfileMenuTagTypeOver,
    KKProfileMenuTagTypeShare,
    
    KKProfileMenuTagTypeCount
};

typedef NS_ENUM(NSUInteger, KKCaseDetailMenuTagType) {
    KKCaseDetailMenuTagTypeUnknown = 0,
    KKCaseDetailMenuTagTypeChat,
    KKCaseDetailMenuTagTypeCall,
    KKCaseDetailMenuTagTypeCount
};

typedef NS_ENUM(NSUInteger, KKCaseIndexTagType) {
    KKCaseIndexTagTypeUnknown = 0,
    KKCaseIndexTagTypeTrademarkSearch,
    KKCaseIndexTagTypeInsert,
    KKCaseIndexTagTypeCompanySearch,
    KKCaseIndexTagTypeInfo,
    KKCaseIndexTagTypeNews,
    KKCaseIndexTagTypeLaw,
    
    KKCaseIndexTagTypeCount
};

typedef NS_ENUM(NSUInteger, KKUploadPhotoType) {
    KKUploadPhotoTypeUnknown = 0,
    KKUploadPhotoType_avatar = 1,
    KKUploadPhotoType_partner = 2,
    KKUploadPhotoType_caseUserImage = 5,
    KKUploadPhotoType_trademark = 40,
    KKUploadPhotoTypeCount
};

// Common

typedef NS_ENUM(NSUInteger, KKMainTabIndex) {
    KKMainTabIndexIndex,
    KKMainTabIndexMessage,
    KKMainTabIndexCall,
    KKMainTabIndexMine,
};

typedef NS_ENUM(NSUInteger, KKShowTagCellLayoutType) {
    KKShowTagCellLayoutTypeFloatLeft,
    KKShowTagCellLayoutTypeFloatTop
};

// Chat
typedef NS_ENUM(NSUInteger, KKChatType) {
    KKChatTypeUnknown,
    KKChatTypeText,           // 文字类型私聊
    KKChatTypeImage,          // 图片类型私聊
    KKChatTypeAudio,          // 声音
    KKChatTypeCount
};

