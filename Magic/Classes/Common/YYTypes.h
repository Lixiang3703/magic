//
//  YYTypes.h
//  Wuya
//
//  Created by Tong on 16/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

typedef NS_ENUM(NSUInteger, YYMessageType) {
    YYMessageTypeUnKnown,
    YYMessageTypeLikePost,
    YYMessageTypeCommentPost,
    YYMessageTypePlainText,
    YYMessageTypeCount,
};

typedef NS_ENUM(NSUInteger, YYPostViewType) {
    YYPostViewTypeUnKnown,
    YYPostViewTypeLargeFriend,
    YYPostViewTypeLargeGroup,
    YYPostViewTypeLargeNearby,
    YYPostViewTypeLargeUnknown,
    YYPostViewTypeMiddle,
    YYPostViewTypeMiddlePM,
    YYPostViewTypeSmall,
    YYPostViewTypeCount,
};

typedef NS_ENUM(NSUInteger, YYPersonViewType) {
    YYPersonViewTypeUnKnown,
    YYPersonViewTypeFeed,
    YYPersonViewTypeProfile,
    YYPersonViewTypeCount,
};

typedef NS_ENUM(NSUInteger, YYPersonOperationViewType) {
    YYPersonOperationViewTypeUnKnown,
    YYPersonOperationViewTypeWhite,
    YYPersonOperationViewTypeBlack,
    YYPersonOperationViewTypeCount,
};

typedef NS_ENUM(NSUInteger, YYPersonChooseSchoolViewType) {
    YYPersonChooseSchoolViewTypeUnKnown,
    YYPersonChooseSchoolViewTypeOne,
    YYPersonChooseSchoolViewTypeAll,
    YYPersonChooseSchoolViewTypeCount,
};

typedef NS_ENUM(NSUInteger, YYPostIntroType) {
    YYPostIntroTypeNone,
    YYPostIntroTypeSufficientFriend,
    YYPostIntroTypeSufficientFriendsFriend,
    YYPostIntroTypeCount,
};

typedef NS_ENUM(NSUInteger, YYMainTabIndex) {
    YYMainTabIndexSchool,
    YYMainTabIndexChat,
    YYMainTabIndexDiscovery,
    YYMainTabIndexMine,
};


typedef NS_ENUM(NSUInteger, YYGroupType) {
    YYGroupTypeUnknown,
    YYGroupTypeStudent,
    YYGroupTypeWork,
    YYGroupTypeCount,
};

//  Added v1.1
typedef NS_ENUM(NSUInteger, YYPMType) {
    YYPMTypeUnknown,
    YYPMTypeText,           // 文字类型私聊
    YYPMTypeImage,          // 图片类型私聊
    YYPMTypeEmotion,        // 表情类型私信 added since v1.4 老版本退化为文字类型
    YYPMTypeCount,
};

//  Added v1.2
typedef NS_ENUM(NSUInteger, YYFITabIndex) {
    YYFITabIndexMine,
    YYFITabIndexPersons,
};


//  Added v1.3
typedef NS_ENUM(NSUInteger, YYReportType) {
    YYReportTypeUnknown,
    YYReportTypeAd,
    YYReportTypeAnnoy,
    YYReportTypePrivacy,
    YYReportTypeSex,
    YYReportTypePolitics,
    YYReportTypeCount,
};


//  Added v1.4
typedef NS_ENUM(NSUInteger, YYComposeInputType) {
    YYComposeInputTypeUnKnown,
    YYComposeInputTypeText,
    YYComposeInputTypeStiker,
    YYComposeInputTypeCount,
};

//  Added v1.4
typedef NS_OPTIONS(NSUInteger, YYCustomKeyboardToolBarType) {
    YYCustomKeyboardToolBarTypeNone                 = 0,
    YYCustomKeyboardToolBarTypeEmoji                = 1 << 0,
    YYCustomKeyboardToolBarTypeWuya                 = 1 << 1,
};

//  Added v1.4
typedef NS_ENUM(NSUInteger, YYGenderType) {
    YYGenderTypeUnKnown,
    YYGenderTypeMale,
    YYGenderTypeFemale,
    YYGenderTypeCount,
};


// Add v2.1
typedef NS_ENUM(NSUInteger, YYProfileTagType) {
    YYProfileTagTypeUnknown = 0,
    YYProfileTagTypeName,            //名字
    YYProfileTagTypeAge,             //年龄
    YYProfileTagTypeAstro,           //星座
    YYProfileTagTypeHobbies,         //兴趣爱好
    YYProfileTagTypeSignature,       //个人签名
    
    YYProfileTagTypeSchool,          //学校   必须按照顺序且连续
    YYProfileTagTypeAcademy,         //院系
    YYProfileTagTypeGrade,           //年级
    
    YYProfileTagTypeCareer,          //职业
    YYProfileTagTypeCount
};

typedef NS_ENUM(NSUInteger, YYAstroType) {
    YYAstroTypeUnknown = 0,
    YYAstroTypeAries,      //白羊座 03月21日─04月20日
    YYAstroTypeTaurus,     //金牛座 04月21日─05月20日
    YYAstroTypeGemini,     //双子座 05月21日─06月21日
    YYAstroTypeCancer,     //巨蟹座 06月22日─07月22日
    YYAstroTypeLeo,        //狮子座 07月23日─08月22日
    YYAstroTypeVirgo,      //处女座 08月23日─09月22日
    YYAstroTypeLibra,      //天秤座 09月23日─10月22日
    YYAstroTypeScorpio,    //天蝎座 10月23日─11月21日
    YYAstroTypeSagittarius,//射手座 11月22日─12月21日
    YYAstroTypeCapricornus,//摩羯座 12月22日─01月19日
    YYAstroTypeAquarius,   //水瓶座 01月20日─02月18日
    YYAstroTypePisces,     //双鱼座 02月19日─03月20日
    YYAstroTypeCount
};

/*所属行业*/
typedef NS_ENUM(NSUInteger, YYCareerType) {
    YYCareerTypeUnknown = -1,
    YYCareerTypeIT = 0,           //计算机/互联网/通信
    YYCareerTypeProduce,          //生产/工艺/制造
    YYCareerTypeBusiness,         //商业/服务业/个体经营
    YYCareerTypeFinance,          //金融/银行/投资/保险
    YYCareerTypeArchitecture,     //房地产/建筑
    YYCareerTypeTraffic,          //交通/运输/物流
    YYCareerTypeMns,              //能源/矿业/环保
    YYCareerTypeAd,               //文化/广告/传媒
    YYCareerTypeActing,           //娱乐/艺术/表演
    YYCareerTypeSports,           //体育
    YYCareerTypeMedical,          //医疗/护理/制药
    YYCareerTypeLawyer,           //律师/法务
    YYCareerTypeEducation,        //教育/培训
    YYCareerTypeCivil,            //公务员/事业单位
    YYCareerTypeNonprofit,        //非盈利机构
    YYCareerTypeNone,             //无
    YYCareerTypeCount,
};

/* sessionType */
typedef NS_ENUM(NSUInteger, YYChatSessionType) {
    YYChatSessionTypeUnknown = -1,
    YYChatSessionTypeNormal = 0,
    YYChatSessionTypeAloha,
    YYChatSessionTypeCount,
};


