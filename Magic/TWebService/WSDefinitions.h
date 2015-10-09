//
//  WSDefinitions.h
//  TongSnippets
//
//  Created by Tong Cui on 30/03/2011.
//  Copyright 2011 Mubaloo. All rights reserved.
//


//----------------------   Keywords  --------------------------//

#define kWS_Keyword_ErrorCode                           (@"ErrorCode")
#define kWS_Keyword_ErrorTitle                          (@"ErrorTitle")
#define kWS_Keyword_ErrorDescription                    (@"ErrorDescription")
#define kWS_Keyword_ErrorOtherInfo                      (@"ErrorOtherInfo")

#define kWS_Keyword_MetaItem                            (@"meta")
#define kWS_Keyword_Response                            (@"data")

#define kWS_Definition_NormalCount                         (20)



//------------   Alert view titles and messages  ----------------//

typedef NS_ENUM(NSUInteger, WBSErrorCode) {
    
	kWS_ErrorCode_NetworkNotReachable = 800,
    kWS_ErrorCode_NoLocalResultError,
    kWS_ErrorCode_RequestTimeoutError,
    kWS_ErrorCode_RequestDidCancelledError,
    kWS_ErrorCode_RequestParamError,
	kWS_ErrorCode_JSONParserError,
    kWS_ErrorCode_MetaEmptyError,
    kWS_ErrorCode_MetaCodeError,
    kWS_ErrorCode_ResponseDataFormatError,
    kWS_ErrorCode_ResponseFormatError,
    kWS_ErrorCode_ResponseEmptyError,
    kWS_ErrorCode_HttpResponseStatusError,
    kWS_ErrorCode_HttpResponseAcceptContentTypeError,
    kWS_ErrorCode_NeedLoginError,
    kWS_ErrorCode_UnknownError,
    
    kWS_ErrorCode_NoResponseError,  // added by Lixiang, for no server available
    
    kWS_ErrorCode_BatchRequstError =900,
    
};


#define kWS_ErrorTitle_OAuthTokenFormatError                (@"OAuth Response Format Error")
#define kWS_ErrorDescription_OAuthTokenFormatError          _(@"需要重新登录")

#define kWS_ErrorTitle_OAuthRefreshError                    (@"OAuth Refresh Error")
#define kWS_ErrorDescription_OAuthRefreshError              _(@"需要重新登录")

#define kWS_ErrorTitle_NetworkNotReachable                  (@"Network Error")
#define kWS_ErrorDescription_NetworkNotReachable            _(@"当前网络不可用\n请检查网络")

#define kWS_ErrorTitle_RequestTimeoutError                  (@"Connection Error")
#define kWS_ErrorDescription_RequestTimeoutError            _(@"网络连接超时\n请稍后重试")

#define kWS_ErrorTitle_RequestParamError                    (@"Request Param Error")
#define kWS_ErrorDescription_RequestParamError              _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_JSONParserError                      (@"JSON Parser Error")
#define kWS_ErrorDescription_JSONParserError                _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_MetaInfoError                        (@"Meta Info Parser Error")
#define kWS_ErrorDescription_MetaInfoError                  _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_ResponseFormatError                  (@"Response Format Error")
#define kWS_ErrorDescription_ResponseFormatError            _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_ResponseEmptyError                   (@"Response Empty Content Error")
#define kWS_ErrorDescription_ResponseEmptyError             _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_HttpResponseStatusError              (@"Response HTTP Status NOT 200 Error")
#define kWS_ErrorDescription_HttpResponseStatusError        _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_NeedLoginError                       (@"Need Login Error")
#define kWS_ErrorDescription_NeedLoginError                 _(@"需要登录才能使用")

#define kWS_ErrorTitle_DiandianRequestUnknownError          (@"Diandian Request Unkown Error")
#define kWS_ErrorDescription_DiandianRequestUnknownError    _(@"服务器出错了\n请将错误反馈给我们")

#define kWS_ErrorTitle_BatchRequestError                    (@"Batch Request Error")
#define kWS_ErrorDescription_BatchRequestError              (@"Batch Request Error")

//-----------------   TimeInterval  ---------------------//
#define kWS_ErrorMessage_Display_TimeInterval               (1.8)

//-----------------   Time   Out    ---------------------//
#define kWS_Request_TimeOut_Get_Interval                    (16)
#define kWS_Request_TimeOut_Post_Interval                   (120)

//-----------------   Empty Result Max Count    ---------------------//
#define kWS_EmptyResult_MaxCount                            (2)

//----------------------   URLS  --------------------------//

#define kWS_URLString_Host_Dev                              (@"localhost:8080/link.web")
#define kWS_URLString_Host_Dis                              (@"www.linkzhuo.com")

#ifdef NEI
    #define kWS_URLString_Host                                  (kWS_URLString_Host_Dev)
#else
    #define kWS_URLString_Host                                  (kWS_URLString_Host_Dis)
#endif


typedef NS_ENUM(NSUInteger, DDAPIListOrderType) {
    DDAPIListOrderTypeDesc,
    DDAPIListOrderTypeAsc,
};



//----------------------   END   --------------------------//

