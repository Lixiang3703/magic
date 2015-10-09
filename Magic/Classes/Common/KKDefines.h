//
//  KKDefines.h
//  Link
//
//  Created by Lixiang on 14/10/31.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

/* PhotoWall*/
#define kPhotoWall_MaxRow                       (2)
#define kPhotoWall_MaxCountPerRow               (4)
#define kPhotoWall_MaxNum                       (kPhotoWall_MaxRow*kPhotoWall_MaxCountPerRow)



/** Globle Notifcations */
#define kNotification_City_Choosed                                  (@"kN_City_Choosed")
#define kLinkNotification_Unread_Update                             (@"kN_Unread_Update")
#define kLinkNotification_UserInfo_Update                           (@"kN_UserInfo_Update")
#define kLinkNotification_Chat_Push_Recieved                        (@"kN_Chat_Push_Recieved")

/** Profile */
#define kNotification_Profile_Update_BasicInfo_Success              (@"kN_Profile_Update_basicInfo_Success")

/** Case */
#define kNotification_Case_Delete_Success                           (@"kN_Case_Delete_Success")
#define kNotification_Case_Pay_Success                              (@"kN_Case_Pay_Success")

/** Photo Upload */
#define kNotification_Photos_Upload_Success                        (@"kN_Photos_Upload_Success")

/***********/

/** Topic */
#define kNotification_Topic_Item_Insert_Success                     (@"kN_Topic_Item_Insert_Success")
#define kNotification_Topic_All_Complete                            (@"kN_Topic_All_Complete")

/** Post */
#define kNotification_Post_Insert_Success                           (@"kN_Post_Insert_Success")
#define kNotification_Post_All_Complete                             (@"kN_Post_All_Complete")

/** Chat */
#define kLinkNotification_ChatItem_Modified                         (@"kN_ChatItem_Modified")
#define kLinkNotification_ChatItem_Push_Recieved                    (@"kN_ChatItem_Push_Recieved")

/** Comment */
#define kLinkNotification_Comment_Modified                          (@"kN_Comment_Modified")


#define kNotification_Profile_Update_TeacherInfo_Success                         (@"kN_Profile_Update_TeacherInfo_Success")

/** Post Comment */
#define kNotification_PostComment_Insert_Success                    (@"kN_PostComment_Insert_Success")


/** Photo Upload */
#define kNotification_Photos_Upload_Complete                        (@"kN_Photos_Upload_Complete")


/** Follow */
#define kNotification_Follow_Status_Changed                         (@"kN_Follow_Status_Changed")


/** Common Block */
typedef void (^KKBlock)(id userInfo);



