//
//  NSString+Tools.h
//  PMP
//
//  Created by Tong on 05/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import <Foundation/Foundation.h>




/** Macros */
#ifndef _
#define _(s) NSLocalizedString(s, nil)
#endif

#define SF(FORMAT...) [NSString stringWithFormat:FORMAT]

@interface NSString (Tools)

- (NSString *)firstLetterCapitalizedString;
- (NSString *)substringByRemovingLastIndex:(NSUInteger)count;

- (const char *)cString;

- (BOOL)hasContent;
- (BOOL)isEmoji;
- (BOOL)isEqualIgnoringCase:(NSString *)string;
- (NSString *)trim;
- (NSString *)trimAllSpace;

- (BOOL)moreThan:(NSString *)string;
- (BOOL)noMoreThan:(NSString *)string;
- (BOOL)lessThan:(NSString *)string;
- (BOOL)noLessThan:(NSString *)string;

+ (NSUInteger)numberOfOccurrencesOfString:(NSString *)needle inString:(NSString *)haystack;

+ (NSString *)stringForCurrentNetworkStatus;

/**
 * Pinyin
 */
- (NSString *)stringInPinyin;
- (NSString *)stringInPinyinCapital;

// encode url
- (NSString *)encodeString:(NSString *)unencodedString;
- (NSString *)decodeString:(NSString *)encodedString;

@end

@interface NSString (Version)

- (BOOL)versionMoreThan:(NSString *)string;
- (BOOL)versionNoMoreThan:(NSString *)string;
- (BOOL)versionLessThan:(NSString *)string;
- (BOOL)versionNoLessThan:(NSString *)string;

@end

@interface NSString (TPath)

#define DOCUMENTS_FOLDER    ([NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0])
#define CACHES_FOLDER       ([NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0])

+ (NSString *)filePathOfDocumentFolderWithName:(NSString *)fileName;
+ (NSString *)filePathOfDocumentFolderWithFolder:(NSString *)folderName fileName:(NSString *)fileName;
+ (NSString *)filePathOfCachesFolderWithName:(NSString *)fileName;
+ (NSString *)filePathOfCachesFolderWithFolder:(NSString *)folderName fileName:(NSString *)fileName;

@end

@interface NSString (TLabelHeight)

- (CGFloat)heightWithFont:(UIFont *)font constrainedWidth:(CGFloat)width;// Uses NSLineBreakByTruncatingTail
- (CGFloat)heightWithFont:(UIFont *)font constrainedWidth:(CGFloat)width numberOfLines:(NSUInteger)numberOfLines;
- (CGFloat)heightWithFont:(UIFont *)font constrainedWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (NSUInteger)lineNumbersWithFont:(UIFont *)font constrainedWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@interface NSString (TNetwork)

- (NSURL *)networkURL;
- (NSString *)md5String;
- (NSString *)stringByPercentEscaping;
- (NSString *)stringByPercentEscapingWithLeaveUnescapedString:(NSString *)leaveUnescaped;

@end

@interface NSString (AttributeStringHeight)

- (CGFloat)heightWithFont:(UIFont *)textFont forWidth:(CGFloat)width forColor:(UIColor *)color;

@end




