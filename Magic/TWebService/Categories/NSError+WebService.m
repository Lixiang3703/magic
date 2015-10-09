//
//  NSError+TongWebService.m
//  TongSnippets
//
//  Created by Tong Cui on 30/03/2011.
//  Copyright 2011 Mubaloo. All rights reserved.
//

#import "NSError+WebService.h"
#import "WSDefinitions.h"


@implementation NSError(TongWebService)

#pragma mark -
#pragma mark Generate an error for web services


+ (NSError *)wsNetworkNotAvalableError {
    return [NSError errorWithCode:kWS_ErrorCode_NetworkNotReachable title:@"wsNetworkNotAvalableError" detail:_(@"当前网络不可用\n请检查网络")];
}

+ (NSError *)wsNoLocalResultError {
    return [NSError errorWithCode:kWS_ErrorCode_NoLocalResultError title:@"wsNoLocalResultError" detail:nil];
}

+ (NSError *)wsRequestTimeoutError {
    return [NSError errorWithCode:kWS_ErrorCode_RequestTimeoutError title:@"wsRequestTimeoutError" detail:_(@"网络连接超时\n请稍后重试")];
}

+ (NSError *)wsNoResponseError {
    return [NSError errorWithCode:kWS_ErrorCode_NoResponseError title:@"wsNoResponseError" detail:_(@"网络连接超时,cann't connect to server\n请稍后重试")];
}

+ (NSError *)wsRequestDidCancelledError {
    return [NSError errorWithCode:kWS_ErrorCode_RequestDidCancelledError title:@"wsRequestDidCancelledError" detail:nil];
}

+ (NSError *)wsRequestParamError {
    return [NSError errorWithCode:kWS_ErrorCode_RequestParamError title:@"wsRequestParamError" detail:nil];
}

+ (NSError *)wsJSONParserError {
    return [NSError errorWithCode:kWS_ErrorCode_JSONParserError title:@"wsJSONParserError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsMetaEmptyError {
    return [NSError errorWithCode:kWS_ErrorCode_MetaEmptyError title:@"wsMetaEmptyError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsMetaCodeError {
    return [NSError errorWithCode:kWS_ErrorCode_MetaCodeError title:@"wsMetaCodeError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsResponseDataFormatError {
    return [NSError errorWithCode:kWS_ErrorCode_ResponseDataFormatError title:@"wsResponseDataFormatError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsResponseFormatError {
    return [NSError errorWithCode:kWS_ErrorCode_ResponseFormatError title:@"wsResponseFormatError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsResponseEmptyError {
    return [NSError errorWithCode:kWS_ErrorCode_ResponseEmptyError title:@"wsResponseEmptyError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsHttpResponseStatusError {
    return [NSError errorWithCode:kWS_ErrorCode_HttpResponseStatusError title:@"wsHttpResponseStatusError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsHttpResponseAcceptContentTypeError {
    return [NSError errorWithCode:kWS_ErrorCode_HttpResponseAcceptContentTypeError title:@"wsHttpResponseAcceptContentTypeError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

+ (NSError *)wsNeedLoginError {
    return [NSError errorWithCode:kWS_ErrorCode_NeedLoginError title:@"wsNeedLoginError" detail:_(@"需要登录才能使用")];
}

+ (NSError *)wsUnknownError {
    return [NSError errorWithCode:kWS_ErrorCode_UnknownError title:@"wsUnknownError" detail:_(@"服务器出错了\n请将错误反馈给我们")];
}

- (BOOL)shouldIgnoreError {
    NSInteger code = self.code;
    return code == kWS_ErrorCode_NoLocalResultError || code == kWS_ErrorCode_RequestDidCancelledError;
}

- (BOOL)shouldRetryError {
    NSInteger code = self.code;
    return code == kWS_ErrorCode_NoLocalResultError;
}


@end
