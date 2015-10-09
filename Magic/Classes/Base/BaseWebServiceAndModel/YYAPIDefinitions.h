//
//  YYAPIDefinitions.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//


//----------------------   URLS  --------------------------//


/** Count */
#define kWS_Default_Count                               (20)

/** Test */
#define kWS_URLString_Hello                             (@"/hello")

/** Debug Error */
#define kWS_URLString_Hello_Wrong                       (@"/hello/wrong3")

/** App */
#define kWS_Model_Constants                             (@"/constant")
#define kWS_Model_UserInfo                              (@"/user/info")
#define kWS_Model_UserInfo_Profile                      (@"/user/info/profile")
#define kWS_Model_GatherLog                             (@"/gather/gzip/rsa/ios")
//  Deprecated
#define kWS_Model_GatherLog_Normal                      (@"/gather/gzip")
//  End
#define kWS_Model_Logout                                (@"/logout")
#define kWS_Model_UnreadInfo                            (@"/unread/info")
#define kWS_Model_UnreadInfo_v2                         (@"/unread/info/v2")
#define kWS_Model_Purge                                 (@"/purge")
#define kWS_Model_APNSBind                              (kApp_Enterprise ? @"/push/apns/enterprise" : @"/push/apns")
#define kWS_Model_APNSUnBind                            (kApp_Enterprise ? @"/push/apns/enterprise/unbind" :@"/push/apns/unbind")


/** Group */
#define kWS_Model_Group                                 (@"/group")
#define kWS_Model_Group_Hot                             (@"/group/hot")
#define kWS_Model_Group_Search                          (@"/group/search")
#define kWS_Model_Group_Change                          (@"/group/change")
#define kWS_Model_Group_Change_Corp                     (@"/group/change/corp")
#define kWS_Model_Group_Change_Check                    (@"/group/change/check")

/** Config */
#define kWS_Model_Config                                (@"/config")
#define kWS_Model_Config_Boolean                        (@"/config/boolean")


/** Contacts */
#define kWS_Model_Upload_Contacts                       (@"/upload/contacts/gzip/rsa/ios")

/** Login */
#define kWS_Model_Login                                 (@"/login/v2")
#define kWS_Model_Mobile_Verify                         (@"/mobile/verify")
#define kWS_Model_Mobile_Verify_Code                    (@"/mobile/verify/code")
#define kWS_Model_Register                              (@"/register/v3")
#define kWS_Model_Login_Update_UserInfo                 (@"/user/info/updateInfo")
#define kWS_Model_Register_Corp                         (@"/register/corp")
#define kWS_Model_Password_Mobile_Code                  (@"/password/mobile/code")
#define kWS_Model_Password_Mobile_Reset                 (@"/password/mobile/reset")
#define kWS_Model_Password_Mobile_Update                (@"/password/mobile/update")

/** Publish */
#define kWS_Model_Post_Publish                          (@"/post/v4")
#define kWS_Model_Upload_Image                          (@"/upload/image")
#define kWS_Model_Upload_Image_V2                       (@"/upload/image/v2")
#define kWS_Model_Template                              (@"/publish/template")

/** RSS */
#define kWS_Model_RSS                                   (@"/rss")
#define kWS_Model_Discovery                             (@"/discovery")


/** Feed */
#define kWS_Model_Feed                                  (@"/feed")
#define kWS_Model_Feed_Postlists                        (@"/feed/postlist")
#define kWS_Model_My_Post                               (@"/post/my")

/** Post */
#define kWS_Model_Post                                  (@"/post")
#define kWS_Model_PostFav                               (@"/fav")
#define kWS_Model_PostUnFav                             (@"/unfav")
#define kWS_Model_PostDelete                            (@"/post/delete")
#define kWS_Model_PostReport                            (@"/report/post")

/** Comment */
#define kWS_Model_Comment                               (@"/comment")
#define kWS_Model_Comment_Delete                        (@"/comment/delete")
#define kWS_Model_Comment_Report                        (@"/report/comment")

/** Message */
#define kWS_Model_Message                               (@"/message")
#define kWS_Model_Message_Clear                         (@"/message/clear")

/** Daily Spank */
#define kWS_Model_DailySpank                            (@"/spank")

/** PM */
#define kWS_Model_PM_Sessions                           (@"/pm/sessions")
#define kWS_Model_PM_Session                            (@"/pm/session")
#define kWS_Model_PM_Session_Delete                     (@"/pm/session/delete")
#define kWS_Model_PM_Session_Latest                     (@"/pm/session/latest")
#define kWS_Model_PM_Text                               (@"/pm/text")
#define kWS_Model_PM_Image                              (@"/pm/image")
#define kWS_Model_PM_Emotion                            (@"/pm/emotion")
#define kWS_Model_PM_Delete                             (@"/pm/delete")
#define kWS_Model_PM_Ban                                (@"/pm/ban")
#define kWS_Model_PM_UnBan                              (@"/pm/unban")
#define kWS_Model_PM_Read                               (@"/pm/read")

/** Chat */
#define kWS_Model_Chat_Sessions_Normal                  (@"/chat/sessions/normal")
#define kWS_Model_Chat_Sessions_Aloha                   (@"/chat/sessions/aloha")
#define kWS_Model_Chat_Session                          (@"/chat/session")
#define kWS_Model_Chat_Session_Delete_Normal            (@"/chat/session/delete/normal")
#define kWS_Model_Chat_Session_Delete_Aloha             (@"/chat/session/delete/aloha")
#define kWS_Model_Chat_Delete                           (@"/chat/delete")
#define kWS_Model_Chat_Session_Latest                   (@"/chat/session/latest")
#define kWS_Model_Chat_Read_Normal                      (@"/chat/read/normal")
#define kWS_Model_Chat_Read_Aloha                       (@"/chat/read/aloha")
#define kWS_Model_Chat_Text                             (@"/chat/text")
#define kWS_Model_Chat_Image                            (@"/chat/image")
#define kWS_Model_Chat_Emotion                          (@"/chat/emotion")


/** Friend Impression */
#define kWS_Model_FI_Templates                          (@"/friendimpression/templates")
#define kWS_Model_FI_Friends                            (@"/friendimpression/friends")
#define kWS_Model_FI_Impressions                        (@"/friendimpression/impressions")
#define kWS_Model_FI_Post                               (@"/friendimpression")
#define kWS_Model_FI_Delete                             (@"/friendimpression/delete")
#define kWS_Model_FI_Report                             (@"/friendimpression/report")
#define kWS_Model_FI_InviteWechat                       (@"/friendimpression/shared")


/** Emotion */
#define kWS_Model_Emotion                               (@"/emotion")


/** Gender */
#define kWS_Model_User_Info_Update                      (@"/user/info/update")

// Add By 2.1
#define kWS_Model_RegisterV3                            (@"/registerV3")

#define kWS_Model_Nearby_User                           (@"/nearby/user")

#define kWS_Model_User_Info_Profile                     (@"/user/info/profile")
#define kWS_Model_User_Info_UpdateInfo                  (@"/user/info/updateInfo")
#define kWS_Model_User_Info_UpdateSchool                (@"/user/info/updateSchool")
#define kWS_Model_User_Info_UpdateCareer                (@"/user/info/updateCareer")
#define kWS_Model_User_Info_UpdateAvatar                (@"/user/info/updateAvatar")

//黑名单
#define kWS_Model_User_Info_Block                       (@"/user/info/block")
#define kWS_Model_User_Info_UnBlock                     (@"/user/info/unblock")
#define kWS_Model_User_Info_BlockList                   (@"/user/info/blockList")
#define kWS_Model_User_Info_IsUserBlock                 (@"/user/info/isUserBlock")

//相册
#define kWS_Model_User_Album                            (@"/user/album")
#define kWS_Model_User_Album_Upload                     (@"/user/album/upload")
#define kWS_Model_User_Album_Delete                     (@"/user/album/delete")

//学校
#define kWS_Model_School_Search                         (@"/school/search")
#define kWS_Model_School_Academy                        (@"/school/academy")

//点赞
#define kWS_Model_Fav                                   (@"/fav/v3")
#define kWS_Model_UnFav                                 (@"/unfav/v3")

//举报
#define kWS_Model_Report_User                           (@"/report/user")



//----------------------   END   --------------------------//