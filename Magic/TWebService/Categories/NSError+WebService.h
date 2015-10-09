//
//  NSError+TongWebService.h
//  TongSnippets
//
//  Created by Tong Cui on 30/03/2011.
//  Copyright 2011 Mubaloo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSError(TongWebService)


+ (NSError *)wsNetworkNotAvalableError;
+ (NSError *)wsNoLocalResultError;
+ (NSError *)wsRequestTimeoutError;

+ (NSError *)wsNoResponseError;

+ (NSError *)wsRequestDidCancelledError;
+ (NSError *)wsRequestParamError;
+ (NSError *)wsJSONParserError;
+ (NSError *)wsMetaEmptyError;
+ (NSError *)wsMetaCodeError;
+ (NSError *)wsResponseDataFormatError;
+ (NSError *)wsResponseFormatError;
+ (NSError *)wsResponseEmptyError;
+ (NSError *)wsHttpResponseStatusError;
+ (NSError *)wsHttpResponseAcceptContentTypeError;
+ (NSError *)wsNeedLoginError;
+ (NSError *)wsUnknownError;


- (BOOL)shouldIgnoreError;
- (BOOL)shouldRetryError;

@end
