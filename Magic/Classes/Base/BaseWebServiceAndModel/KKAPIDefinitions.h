//
//  KKAPIDefinitions.h
//  Link
//
//  Created by Lixiang on 14/11/8.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

/** Count */
#define kLink_WS_Default_Count                                  (20)

/** Case */
#define kLink_WS_Model_Case_List                                            (@"/case/list")
#define kLink_WS_Model_Case_Insert                                          (@"/case/insert")
#define kLink_WS_Model_Case_Delete                                          (@"/case/delete")
#define kLink_WS_Model_CaseMessage_List                                     (@"/caseMessage/list")

#define kLink_WS_Model_Case_One                                             (@"/case/one")
#define kLink_WS_Model_CaseMessage_One                                      (@"/caseMessage/one")
#define kLink_WS_Model_Case_UserImageList                                   (@"/case/userImageList")
#define kLink_WS_Model_Case_trademarkList                                   (@"/case/trademarkList")

/** CaseType */
#define kLink_WS_Model_CaseType_List                                        (@"/caseType/list")
#define kLink_WS_Model_Industry_List                                        (@"/industry/list")
#define kLink_WS_Model_Classics_List                                        (@"/classics/list")

/** News */
#define kLink_WS_Model_News_List                                            (@"/news/list")
#define kLink_WS_Model_Law_List                                             (@"/law/list")
#define kLink_WS_Model_Broadcast_List                                       (@"/broadcast/list")

/** Bonus */
#define kLink_WS_Model_Bonus_List                                           (@"/bonus/list")

/** Pay */
#define kLink_WS_Model_Pay_Pre                                              (@"/pay/pre")
#define kLink_WS_Model_Pay_Pre_Ali                                          (@"/pay/pre/ali")

/** Login */
#define kLink_WS_Model_Login                                                (@"/login")
#define kLink_WS_Model_Logout                                               (@"/login/logout")

#define kLink_WS_Model_Register_Code                                        (@"/login/register/code")
#define kLink_WS_Model_Register_Submit                                      (@"/login/register/mobile/submit")

#define kLink_WS_Model_changePsd                                            (@"/login/changePsd")

#define kLink_WS_Model_Password_Mobile_Code                                 (@"/login/password/code")
#define kLink_WS_Model_Password_Mobile_Reset                                (@"/login/password/reset")

#define kLink_WS_Model_Mobile_Verify                                        (@"/mobile/verify")
#define kLink_WS_Model_Mobile_Verify_Code                                   (@"/mobile/verify/code")

/** Token */
#define kLinkWS_Model_APNSBind                                              (@"/login/token/bind")
#define kLinkWS_Model_APNSUnBind                                            (@"/login/token/unbind")

/** Unread info */
#define kLinkWS_Model_Unread                                                (@"/unread/info")

/** User */
#define kLink_WS_Model_User_one                                             (@"/user/one")
#define kLink_WS_Model_User_childrenList                                    (@"/user/childrenList")
#define kLink_WS_Model_User_mineBasicInfo                                   (@"/user/mineBasicInfo")

/** User update */
#define kLink_WS_Model_User_Update_basicInfo                    (@"/user/update/basicInfo")
#define kLink_WS_Model_User_Update_inviteCode                   (@"/user/update/inviteCode")
#define kLink_WS_Model_User_Update_loc                          (@"/user/update/loc")
#define kLink_WS_Model_User_Update_passoword                    (@"/user/update/password")

/** Message */
#define kLink_WS_Model_Message_List                                         (@"/message/list")
#define kLink_WS_Model_Message_Delete                                       (@"/message/delete")
#define kLink_WS_Model_Message_Clear                                        (@"/message/clear")

/** Chat */
#define kLink_WS_Model_Chat_Session_Check                                   (@"/chat/session/check")
#define kLink_WS_Model_Chat_Session_List                                    (@"/chat/session/list")
#define kLink_WS_Model_Chat_Session_Delete                                  (@"/chat/session/delete")

#define kLink_WS_Model_Chat_Delete                                          (@"/chat/delete")
#define kLink_WS_Model_Chat_List                                            (@"/chat/list")
#define kLink_WS_Model_Chat_List_Latest                                     (@"/chat/list/latest")

#define kLink_WS_Model_Chat_Insert_Text                                     (@"/chat/insert/text")
#define kLink_WS_Model_Chat_Insert_Image                                    (@"/chat/insert/image")

/** Photo */
#define kLink_WS_Model_Photo_Upload_avatar                                  (@"/photo/upload/avatar")
#define kLink_WS_Model_Photo_Upload_partner                                 (@"/photo/upload/partner")
#define kLink_WS_Model_Photo_Upload_userCaseImage                           (@"/photo/upload/userCaseImage")
#define kLink_WS_Model_Photo_Upload_trademark                               (@"/photo/upload/trademark")
#define kLink_WS_Model_Photo_Delete                                         (@"/photo/action_delete")


/**************************/

/** Follow */
#define kLink_WS_Model_Follow_List_Insitution                        (@"/follow/list/institution")
#define kLink_WS_Model_Follow_List_Course                            (@"/follow/list/course")
#define kLink_WS_Model_Follow_List_User                              (@"/follow/list/user")
#define kLink_WS_Model_Follow_List_Fans                              (@"/follow/list/fans")

#define kLink_WS_Model_Follow_Update_add                              (@"/follow/update/add")
#define kLink_WS_Model_Follow_Update_cancel                           (@"/follow/update/cancel")

/** Common */

#define kLink_WS_Model_Common_AreaList                                  (@"/common/areaList")
#define kLink_WS_Model_Common_CategoryList                              (@"/common/categoryList")

/** relation */
#define kLink_WS_Model_Relation_List_Course                                    (@"/relation/list/course")
#define kLink_WS_Model_Relation_oneCourse_RelationList                         (@"/relation/oneCourse/relationList")
#define kLink_WS_Model_Relation_Insert                                         (@"/relation/insert")

#define kLink_WS_Model_Relation_listForOneCourse                         (@"/relation/liseForOneCourse")


/** Topic */
#define kLink_WS_Model_Topic_List                                   (@"/topic/list")
#define kLink_WS_Model_Topic_One                                    (@"/topic/one")
#define kLink_WS_Model_Topic_Insert                                 (@"/topic/insert")
#define kLink_WS_Model_Topic_Delete                                 (@"/topic/delete")
#define kLink_WS_Model_Topic_List_Create                            (@"/topic/create")
#define kLink_WS_Model_Topic_List_Join                              (@"/topic/join")

/** Post */
#define kLink_WS_Model_Post_List                                   (@"/post/list")
#define kLink_WS_Model_Post_List_Create                            (@"/post/create")
#define kLink_WS_Model_Post_List_Feed                            (@"/post/feed")
#define kLink_WS_Model_Post_One                                    (@"/post/one")
#define kLink_WS_Model_Post_Insert                                 (@"/post/insert")
#define kLink_WS_Model_Post_Delete                                 (@"/post/delete")


/** Post Comment */
#define kLink_WS_Model_Topic_Comment_Insert                         (@"/topic/comment/insert")
#define kLink_WS_Model_Topic_Comment_Insert_get                         (@"/topic/comment/insert/get")

#define kLink_WS_Model_Topic_Comment_Delete                         (@"/topic/comment/delete")
#define kLink_WS_Model_Topic_Comment_List                           (@"/topic/comment/list")


/** Entity Comment */
#define kLink_WS_Model_EntityComment_List                             (@"/entity/comment/list")
#define kLink_WS_Model_EntityComment_Insert                           (@"/entity/comment/insert")
#define kLink_WS_Model_EntityComment_Delete                           (@"/entity/comment/delete")


/** Entity One; Teacher one 没有requestModel, 用 kLink_WS_Model_User_TeacherInfo */
#define kLink_WS_Model_Insitution_One                           (@"/institution/one")
#define kLink_WS_Model_Course_One                               (@"/course/one")

/** Entity Insert */
#define kLink_WS_Model_Insitution_Insert                        (@"/institution/insert")
#define kLink_WS_Model_Insitution_Update                        (@"/institution/update")
#define kLink_WS_Model_Course_Insert                            (@"/course/insert")
#define kLink_WS_Model_Insitution_Join                            (@"/institution/join")

/** Insititution */
#define kLink_WS_Model_Insitution_Filter                        (@"/institution/filter")
#define kLink_WS_Model_Insitution_Search                        (@"/institution/search")
#define kLink_WS_Model_Insitution_Teachers                      (@"/institution/teachers")

/** Course */
#define kLink_WS_Model_Course_Filter                        (@"/course/filter")
#define kLink_WS_Model_Course_Search                        (@"/course/search")
#define kLink_WS_Model_Course_Mine                          (@"/course/mine")

/** Teacher */
#define kLink_WS_Model_Teacher_Filter                        (@"/teacher/filter")
#define kLink_WS_Model_Teacher_Search                        (@"/teacher/search")
#define kLink_WS_Model_Teacher_Follow                        (@"/teacher/follow")







/** Nearby */
#define kLink_WS_Model_User_Nearby                               (@"/user/nearby")
#define kLink_WS_Model_User_Search                               (@"/user/search")












