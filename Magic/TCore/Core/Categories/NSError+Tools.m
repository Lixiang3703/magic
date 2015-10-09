//
//  NSError+Tools.m
//  Wuya
//
//  Created by Tong on 13/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSError+Tools.h"
#import "WSDefinitions.h"

@implementation NSError (Tools)

+ (NSError *)errorWithCode:(NSInteger)code title:(NSString *)title detail:(NSString *)detail {
    return [[self class] errorWithCode:code title:title detail:detail userInfo:nil];
}

+ (NSError *)errorWithCode:(NSInteger)code title:(NSString *)title detail:(NSString *)detail userInfo:(id)userInfo {
    NSMutableDictionary *info = [NSMutableDictionary dictionary];
    [info setSafeObject:@(code) forKey:kTError_Key_Code];
    [info setSafeObject:title forKey:kTError_Key_Title];
    [info setSafeObject:detail forKey:kTError_Key_Detail];
    [info setSafeObject:userInfo forKey:kTError_Key_UserInfo];
    [info setSafeObject:@(YES) forKey:kTError_Key_Identifier];
    
	return [NSError errorWithDomain:NSStringFromClass([self class]) code:code userInfo:info];
}

- (BOOL)isTError {
    return [[self.userInfo objectForKey:kTError_Key_Identifier] boolValue];
}

- (BOOL)isFatalError {
    //  服务器错误，比如评论的时候，遇到这个错误，就不应该缓存
    return self.code >= kWS_ErrorCode_MetaEmptyError && self.code <= kWS_ErrorCode_HttpResponseAcceptContentTypeError;
}

- (NSInteger)wsCode {
    return self.code;
}

- (NSString *)wsTitle {
    return [self.userInfo objectForSafeKey:kTError_Key_Title];
}

- (NSString *)wsDetail {
    return [self.userInfo objectForSafeKey:kTError_Key_Detail];
}

@end
