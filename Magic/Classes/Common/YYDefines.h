//
//  YYDefines.h
//  Wuya
//
//  Created by Tong on 17/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

/** InHouse or not */
#ifdef INC
    #define kApp_Enterprise                 (1)
#else
    #define kApp_Enterprise                 (0)
#endif


/** DailySpank */
//seconds
#define kDailySpank_TTL                     (0)   //by 1.4
#define kDailySpank_FeedCountBefore         (2)

/** FeedUnlock */
#define kFeeds_UnlockCellItem_IndexPath_Row (4)

/** Distribute */
#define kApp_Channel                        (0)

/** Default API Count */
#define kWS_Default_Count                   (20)

/** Publish */
#define kWS_Publish_Max_Lines               (10)

/** AddressBook */
#define kWS_AddressBook_Upload_MaxCount     (20)

/** Intro */
#define kIntro_Feed_Following_MinCount      (3)
#define kIntro_Friend_Unlock_MinCount       (3)


/** App */
#define kApp_Update_Url                     (@"http://itunes.apple.com/cn/app/id995980258?mt=8")

/** SSO */
#define kApp_SSO_Scheme                     (@"wywy")

/** PM */
#define kPM_Update_Interval                 (6)

/** Friend Impression */
#define kFI_MobileCount_Min                 (2)
#define kFI_MobileCount_Other_Min           (3)
#define kFI_FI_FoldCount                    ([UIDevice is4InchesScreen] ? 5 : 3)
#define kFI_Templates_Count                 (10)


/** Emotion */
#define kEmotion_TTL                        (1200)

/** Global Tag */
#define kTag_Global_ImageViewer             (152)

/** Globle Notifcations */
#define kNotification_Follow_Success                    (@"kN_Follow_Success")
#define kNotification_Publish_Success                   (@"kN_Publish_Success")
#define kNotification_Publish_Fail                      (@"kN_Publish_Fail")
#define kNotification_Post_Delete_Success               (@"kN_Post_Delete_Success")
#define kNotification_Unread_Update                     (@"kN_Unread_Update")
#define kNotification_UserInfo_Update                   (@"kN_UserInfo_Update")
#define kNotification_Group_Update                      (@"kN_Group_Update")
#define kNotification_Session_Delete_Success            (@"kN_Session_Delete_Success")
#define kNotification_PM_Modified                       (@"kN_PM_Modified")
#define kNotification_App_Purge_Success                 (@"kN_App_Purge_Success")
#define kNotification_FI_Lock_NeedUpdate                (@"kN_FI_Lock_NeedUpdate")
#define kNotification_Location_Fetched                  (@"kN_Location_Fetched")
#define kNotification_PM_Push_Recieved                  (@"kN_PM_Push_Recieved")

#define kNotification_Black_Success                     (@"kN_Profie_Black_Success")
#define kNotification_UnBlack_Success                   (@"kN_Profie_UnBlack_Success")

/* add since 2.1, for beforeStartLocationCell */
#define kNotification_RemoveStartLocationIntro          (@"kN_RemoveStartLocationIntro")

/** Globel request arguments */
#define kRequestArgumentsV                      (@"wuya")

/* add from 1.3 for report*/
#define kReportType                             (@"YYReportType")

/** Common Block */
typedef void (^DDBlock)(id userInfo);

/** Keyboard */
#define kUIKeyboardWithCustomVC                 (@"kUIKeyboardWithCustomVC")


/* add by 2.1 profile*/
#define kProfile_Min_Year                       (1900)
#define kProfile_Max_Signature_Count            (40)

/** Added since V2.1 */
#define kAppleTest_Mobile                       (@"13800000000")
