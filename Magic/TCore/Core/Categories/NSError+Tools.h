//
//  NSError+Tools.h
//  Wuya
//
//  Created by Tong on 13/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kTError_Key_Code            (@"code")
#define kTError_Key_Title           (@"title")
#define kTError_Key_Detail          (@"detail")
#define kTError_Key_UserInfo        (@"userInfo")
#define kTError_Key_Identifier      (@"tIdentifier")

@interface NSError (Tools)

+ (NSError *)errorWithCode:(NSInteger)code title:(NSString *)title detail:(NSString *)detail;
+ (NSError *)errorWithCode:(NSInteger)code title:(NSString *)title detail:(NSString *)detail userInfo:(id)userInfo;

- (BOOL)isTError;
- (BOOL)isFatalError;
- (NSInteger)wsCode;
- (NSString *)wsTitle;
- (NSString *)wsDetail;

@end
