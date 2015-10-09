//
//  NSString+Tools.m
//  PMP
//
//  Created by Tong on 05/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "NSString+Tools.h"
#import "AFNetworkReachabilityManager.h"
#import "pinyin.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

#define kNSString_Pinyin_Loop_Max_Times            (50)

@implementation NSString (Tools)

- (NSString *)firstLetterCapitalizedString {
    return [NSString stringWithFormat:@"%@%@",[[self substringToIndex:1] uppercaseString],[self substringFromIndex:1]];
}

- (NSString *)substringByRemovingLastIndex:(NSUInteger)count {
    return [self substringToIndex:[self length] - count];
}

- (const char *)cString {
    return [self cStringUsingEncoding:NSASCIIStringEncoding];
}

- (BOOL)hasContent {
    
    //该方法用来防止语音输入时未解析完点击发布出现的特殊字符，有更好的解决方法可删除
    //限制范围参见http://www.utf8-chartable.de/unicode-utf8-table.pl?start=65408&utf8=char
    unichar firstChar = 0;
    if ([self length]) {
        firstChar =[self characterAtIndex:0];
    }
    BOOL hasLimitChar = firstChar < 0xFFFD && firstChar > 0xFFF8;
    
    return self.length > 0 && !hasLimitChar;
}

- (BOOL)isEmoji {
    static  NSString *emojiStr = @"😄😃😀😊☺😉😍😘😚😗😙😜😝😛😳😁😔😌😒😞😣😢😂😭😪😥😰😅😓😩😫😨😱😠😡😤😖😆😋😷😎😴😵😲😟😦😧😈👿😮😬😐😕😯😶😇😏😑👲👳👮👷💂👶👦👧👨👩👴👵👱👼👸😺😸😻😽😼🙀😿😹😾👹👺🙈🙉🙊💀👽💩🔥✨🌟💫💥💢💦💧💤💨👂👀👃👅👄👍👎👌👊✊✌👋✋👐👆👇👉👈🙌🙏☝👏💪🚶🏃💃👫👪👬👭💏💑👯🙆🙅💁🙋💆💇💅👰🙎🙍🙇🎩👑👒👟👞👡👠👢👕👔👚👗🎽👖👘👙💼👜👝👛👓🎀🌂💄💛💙💜💚❤💔💗💓💕💖💞💘💌💋💍💎👤👥💬👣💭🐶🐺🐱🐭🐹🐰🐸🐯🐨🐻🐷🐽🐮🐗🐵🐒🐴🐑🐘🐼🐧🐦🐤🐥🐣🐔🐍🐢🐛🐝🐜🐞🐌🐙🐚🐠🐟🐬🐳🐋🐄🐏🐀🐃🐅🐇🐉🐎🐐🐓🐕🐖🐁🐂🐲🐡🐊🐫🐪🐆🐈🐩🐾💐🌸🌷🍀🌹🌻🌺🍁🍃🍂🌿🌾🍄🌵🌴🌲🌳🌰🌱🌼🌐🌞🌝🌚🌑🌒🌓🌔🌕🌖🌗🌘🌜🌛🌙🌍🌎🌏🌋🌌🌠⭐☀⛅☁⚡☔❄⛄🌀🌁🌈🌊🎍💝🎎🎒🎓🎏🎆🎇🎐🎑🎃👻🎅🎄🎁🎋🎉🎊🎈🎌🔮🎥📷📹📼💿📀💽💾💻📱☎📞📟📠📡📺📻🔊🔉🔈🔇🔔🔕📢📣⏳⌛⏰⌚🔓🔒🔏🔐🔑🔎💡🔦🔆🔅🔌🔋🔍🛁🛀🚿🚽🔧🔩🔨🚪🚬💣🔫🔪💊💉💰💴💵💷💶💳💸📲📧📥📤✉📩📨📯📫📪📬📭📮📦📝📄📃📑📊📈📉📜📋📅📆📇📁📂✂📌📎✒✏📏📐📕📗📘📙📓📔📒📚📖🔖📛🔬🔭📰🎨🎬🎤🎧🎼🎵🎶🎹🎻🎺🎷🎸👾🎮🃏🎴🀄🎲🎯🏈🏀⚽⚾🎾🎱🏉🎳⛳🚵🚴🏁🏇🏆🎿🏂🏊🏄🎣☕🍵🍶🍼🍺🍻🍸🍹🍷🍴🍕🍔🍟🍗🍖🍝🍛🍤🍱🍣🍥🍙🍘🍚🍜🍲🍢🍡🍳🍞🍩🍮🍦🍨🍧🎂🍰🍪🍫🍬🍭🍯🍎🍏🍊🍋🍒🍇🍉🍓🍑🍈🍌🍐🍍🍠🍆🍅🌽🏠🏡🏫🏢🏣🏥🏦🏪🏩🏨💒⛪🏬🏤🌇🌆🏯🏰⛺🏭🗼🗾🗻🌄🌅🌃🗽🌉🎠🎡⛲🎢🚢⛵🚤🚣⚓🚀✈💺🚁🚂🚊🚉🚞🚆🚄🚅🚈🚇🚝🚋🚃🚎🚌🚍🚙🚘🚗🚕🚖🚛🚚🚨🚓🚔🚒🚑🚐🚲🚡🚟🚠🚜💈🚏🎫🚦🚥⚠🚧🔰⛽🏮🎰♨🗿🎪🎭📍🚩🇯🇵🇰🇷🇩🇪🇨🇳🇺🇸🇫🇷🇪🇸🇮🇹🇷🇺🇬🇧1⃣2⃣3⃣4⃣5⃣6⃣7⃣8⃣9⃣0⃣🔟🔢#⃣🔣⬆⬇⬅➡🔠🔡🔤↗↖↘↙↔↕🔄◀▶🔼🔽↩↪ℹ⏪⏩⏫⏬⤵⤴🆗🔀🔁🔂🆕🆙🆒🆓🆖📶🎦🈁🈯🈳🈵🈴🈲🉐🈹🈺🈶🈚🚻🚹🚺🚼🚾🚰🚮🅿♿🚭🈷🈸🈂Ⓜ🛂🛄🛅🛃🉑㊙㊗🆑🆘🆔🚫🔞📵🚯🚱🚳🚷🚸⛔✳❇❎✅✴💟🆚📳📴🅰🅱🆎🅾💠➿♻♈♉♊♋♌♍♎♏♐♑♒♓⛎🔯🏧💹💲💱©™〽〰🔝🔚🔙🔛🔜❌⭕❗❓❕❔🔃🕛🕧🕐🕜🕑🕝🕒🕞🕓🕟🕔🕠🕕🕖🕗🕘🕙🕚🕡🕢🕣🕤🕥🕦✖➕➖➗♠♥♣♦💮💯✔☑🔘🔗➰🔱🔲🔳◼◻◾◽▪▫🔺⬜⬛⚫⚪🔴🔵🔻🔶🔷🔸🔹";
    return [emojiStr rangeOfString:self].location != NSNotFound;
}

- (BOOL)isEqualIgnoringCase:(NSString *)string {
    return [self caseInsensitiveCompare:string] == NSOrderedSame;
}

- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimAllSpace {
    return  [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""];
}

- (BOOL)moreThan:(NSString *)string {
    return [self compare:string] == NSOrderedDescending;
}

- (BOOL)noMoreThan:(NSString *)string {
    return ![self moreThan:string];
}

- (BOOL)lessThan:(NSString *)string {
    return [self compare:string] == NSOrderedAscending;
}

- (BOOL)noLessThan:(NSString *)string {
    return ![self lessThan:string];
}

+ (NSUInteger)numberOfOccurrencesOfString:(NSString *)needle inString:(NSString *)haystack {
    const char * rawNeedle = [needle UTF8String];
    NSUInteger needleLength = strlen(rawNeedle);
    
    const char * rawHaystack = [haystack UTF8String];
    NSUInteger haystackLength = strlen(rawHaystack);
    
    NSUInteger needleCount = 0;
    NSUInteger needleIndex = 0;
    for (NSUInteger index = 0; index < haystackLength; ++index) {
        const char thisCharacter = rawHaystack[index];
        if (thisCharacter != rawNeedle[needleIndex]) {
            needleIndex = 0; //they don't match; reset the needle index
        }
        
        //resetting the needle might be the beginning of another match
        if (thisCharacter == rawNeedle[needleIndex]) {
            needleIndex++; //char match
            if (needleIndex >= needleLength) {
                needleCount++; //we completed finding the needle
                needleIndex = 0;
            }
        }
    }
    
    return needleCount;
}

+ (NSString *)stringForCurrentNetworkStatus {
    
    switch ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus) {
        case AFNetworkReachabilityStatusNotReachable:
            return @"网络不通";
        case AFNetworkReachabilityStatusReachableViaWiFi:
            return @"Wi-Fi";
        case AFNetworkReachabilityStatusReachableViaWWAN:
            return @"2G/3G";
        case AFNetworkReachabilityStatusUnknown:
        default:
            return @"状态未知";
    }
}

- (NSString *)stringInPinyin {
    const char **pinyins = NULL;
    NSMutableArray *mutableArrays = [NSMutableArray arrayWithObject:@""];
    NSMutableSet *tempSet = [NSMutableSet set];
    NSUInteger count = [self length];
    for (int i = 0; i < count; i++) {
        //  Remove all temp character strings
        [tempSet removeAllObjects];
        //  Add new temp character strings
        NSString *pinyin = nil;
        
        int count = pinyin_get_pinyins_by_unicode([self characterAtIndex:i], &pinyins);
        if (count > 0) {
            for (int j = 0; j < count; j++) {
                pinyin = [NSString  stringWithFormat:@"%s",pinyins[j]];
                [tempSet addObject:pinyin];
            }
        } else {
            [tempSet addObject:[NSString stringWithFormat:@"%C", [self characterAtIndex:i]]];
        }
        //  Increase array size if need, tempArray count is at least 1
        if ([tempSet count] >= 1) {
            NSMutableArray *stringsToAdd = [NSMutableArray arrayWithCapacity:([tempSet count] -1) * [mutableArrays count]];
            for (NSMutableString *tempString in mutableArrays) {
                for (NSString *appendString in tempSet) {
                    [stringsToAdd addObject:[NSString stringWithFormat:@"%@%@", tempString, appendString]];
                    if (mutableArrays.count + stringsToAdd.count > kNSString_Pinyin_Loop_Max_Times) {
                        break;
                    }
                }
            }
            [mutableArrays removeAllObjects];
            [mutableArrays addObjectsFromArray:stringsToAdd];
        }
        free(pinyins);
    }
    
    return [mutableArrays componentsJoinedByString:@"|"];
}

- (NSString *)stringInPinyinCapital {
    const char **pinyins = NULL;
    NSMutableArray *mutableArrays = [NSMutableArray arrayWithObject:@""];
    NSMutableSet *tempSet = [NSMutableSet set];
    NSUInteger count = [self length];
    for (int i = 0; i < count; i++) {
        [tempSet removeAllObjects];
        NSString *pinyin = nil;
        int count = pinyin_get_pinyins_by_unicode([self characterAtIndex:i], &pinyins);
        if (count > 0) {
            for (int j = 0; j < count; j++) {
                pinyin = [NSString stringWithFormat:@"%s",pinyins[j]];
                [tempSet addObject:[pinyin substringToIndex:1]];
            }
        } else {
            [tempSet addObject:[NSString stringWithFormat:@"%C", [self characterAtIndex:i]]];
        }
        
        if ([tempSet count] >= 1) {
            NSMutableArray *stringsToAdd = [NSMutableArray arrayWithCapacity:([tempSet count] -1) * [mutableArrays count]];
            for (NSMutableString *tempString in mutableArrays) {
                for (NSString *appendString in tempSet) {
                    [stringsToAdd addObject:[NSString stringWithFormat:@"%@%@", tempString, appendString]];
                    if (mutableArrays.count + stringsToAdd.count > kNSString_Pinyin_Loop_Max_Times) {
                        break;
                    }
                }
            }
            [mutableArrays removeAllObjects];
            [mutableArrays addObjectsFromArray:stringsToAdd];
        }
        free(pinyins);
    }
    return [mutableArrays componentsJoinedByString:@"|"];
}

// Encode & decode

- (NSString *)encodeString:(NSString *)unencodedString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}

- (NSString *)decodeString:(NSString*)encodedString {
    NSString *decodedString  = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)encodedString,
                                                                                                                     CFSTR(""),
                                                                                                                     CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    return decodedString;
}

@end

@implementation NSString (Version)

- (BOOL)versionCompareWithLarge:(BOOL)large anotherString:(NSString *)string {
    NSArray *selfVersionStrings = [self componentsSeparatedByString:@"."];
    NSArray *anotherVersionStrings = [self componentsSeparatedByString:@"."];
    
    __block BOOL res = NO;
    
    [selfVersionStrings enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
        NSInteger selfVersionNumber = [obj integerValue];
        NSInteger anotherVersionNumber = [[anotherVersionStrings objectAtSafeIndex:idx] integerValue];
        
        if (selfVersionNumber != anotherVersionNumber) {
            res = large ? (selfVersionNumber > anotherVersionNumber) : (selfVersionNumber < anotherVersionNumber);
            *stop = YES;
        }
    }];
    
    return res;
}

- (BOOL)versionMoreThan:(NSString *)string {
    return [self compare:string options:NSNumericSearch] == NSOrderedDescending;
}

- (BOOL)versionNoMoreThan:(NSString *)string {
    return ![self versionMoreThan:string];
}

- (BOOL)versionLessThan:(NSString *)string {
    return [self compare:string options:NSNumericSearch] == NSOrderedAscending;
}

- (BOOL)versionNoLessThan:(NSString *)string {
    return ![self versionLessThan:string];
}

@end

@implementation NSString (TPath)

+ (NSString *)filePathOfDocumentFolderWithName:(NSString *)fileName {
    return [DOCUMENTS_FOLDER stringByAppendingPathComponent:fileName];
}
+ (NSString *)filePathOfDocumentFolderWithFolder:(NSString *)folderName fileName:(NSString *)fileName {
    return [[self filePathOfDocumentFolderWithName:folderName] stringByAppendingPathComponent:fileName];
}
+ (NSString *)filePathOfCachesFolderWithName:(NSString *)fileName {
    return [CACHES_FOLDER stringByAppendingPathComponent:fileName];
}
+ (NSString *)filePathOfCachesFolderWithFolder:(NSString *)folderName fileName:(NSString *)fileName {
    return [[self filePathOfCachesFolderWithName:folderName] stringByAppendingPathComponent:fileName];
}

@end


@implementation NSString (TLabelHeight)

- (CGFloat)heightWithFont:(UIFont *)font constrainedWidth:(CGFloat)width {
    return ceilf([self heightWithFont:font constrainedWidth:width lineBreakMode:NSLineBreakByTruncatingTail]);
}

- (CGFloat)heightWithFont:(UIFont *)font constrainedWidth:(CGFloat)width numberOfLines:(NSUInteger)numberOfLines{
    CGFloat lineHeight = font.lineHeight * numberOfLines;
    CGFloat realHeight = [self heightWithFont:font constrainedWidth:width lineBreakMode:NSLineBreakByTruncatingTail];
    
    return ceilf(MIN(lineHeight, realHeight));
}

- (CGFloat)heightWithFont:(UIFont *)font constrainedWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode {
    return ceilf([self boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil].size.height);
}

- (NSUInteger)lineNumbersWithFont:(UIFont *)font constrainedWidth:(CGFloat)width lineBreakMode:(NSLineBreakMode)lineBreakMode {
    CGFloat totalHeight = [self heightWithFont:font constrainedWidth:width lineBreakMode:lineBreakMode];
    
    return totalHeight / font.lineHeight;
}

@end

@implementation NSString (TNetwork)

- (NSURL *)networkURL {
    return [NSURL URLWithString:self];
}

- (NSString *)md5String {
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
	return [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7],result[8], result[9], result[10], result[11],result[12], result[13], result[14], result[15]];
}

- (NSString *)stringByPercentEscaping {
    return [self stringByPercentEscapingWithLeaveUnescapedString:nil];
}

- (NSString *)stringByPercentEscapingWithLeaveUnescapedString:(NSString *)leaveUnescaped {
    return  (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)leaveUnescaped, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8);
}

@end


@implementation NSString (AttributeStringHeight)

- (NSDictionary *)attributedStringDictionaryWithFont:(UIFont *)textFont color:(UIColor *)textColor{
    //for details In  "TTTAttributedLabel.h"
    //static inline NSDictionary * NSAttributedStringAttributesFromLabel(TTTAttributedLabel *label)
    
    NSMutableDictionary *mutableAttributes = [NSMutableDictionary dictionary];
    NSTextAlignment alignment = NSTextAlignmentLeft;
    
    if ([NSMutableParagraphStyle class]) {
        [mutableAttributes setObject:textFont forKey:(NSString *)kCTFontAttributeName];
        [mutableAttributes setObject:textColor forKey:(NSString *)kCTForegroundColorAttributeName];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = alignment;
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        [mutableAttributes setObject:paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
    } else {
        CTFontRef font = CTFontCreateWithName((__bridge CFStringRef)textFont.fontName, textFont.pointSize, NULL);
        [mutableAttributes setObject:(__bridge id)font forKey:(NSString *)kCTFontAttributeName];
        CFRelease(font);
        [mutableAttributes setObject:(id)[textColor CGColor] forKey:(NSString *)kCTForegroundColorAttributeName];
        CTTextAlignment ctAlignment = [self ctTextAlignmentFromAlignment:alignment];
        CTLineBreakMode lineBreakMode = kCTLineBreakByWordWrapping;
        
        CTParagraphStyleSetting paragraphStyles[10] = {
            {.spec = kCTParagraphStyleSpecifierAlignment, .valueSize = sizeof(CTTextAlignment), .value = (const void *)&ctAlignment},
            {.spec = kCTParagraphStyleSpecifierLineBreakMode, .valueSize = sizeof(CTLineBreakMode), .value = (const void *)&lineBreakMode},
        };
        CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(paragraphStyles, 10);
        [mutableAttributes setObject:(__bridge id)paragraphStyle forKey:(NSString *)kCTParagraphStyleAttributeName];
        CFRelease(paragraphStyle);
    }
    
    return [NSDictionary dictionaryWithDictionary:mutableAttributes];
}

- (CTTextAlignment)ctTextAlignmentFromAlignment:(NSTextAlignment)alignment {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 60000
    switch (alignment) {
		case NSTextAlignmentLeft: return kCTLeftTextAlignment;
		case NSTextAlignmentCenter: return kCTCenterTextAlignment;
		case NSTextAlignmentRight: return kCTRightTextAlignment;
		default: return kCTNaturalTextAlignment;
	}
#else
    switch (alignment) {
		case UITextAlignmentLeft: return kCTLeftTextAlignment;
		case UITextAlignmentCenter: return kCTCenterTextAlignment;
		case UITextAlignmentRight: return kCTRightTextAlignment;
		default: return kCTNaturalTextAlignment;
	}
#endif
}

- (CGFloat)heightWithFont:(UIFont *)textFont
                 forWidth:(CGFloat)width
                 forColor:(UIColor *)color{
    NSAttributedString *captionAttributeString = [[NSAttributedString alloc] initWithString:self attributes:[self attributedStringDictionaryWithFont:textFont color:color]];
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef) captionAttributeString);
    CGSize suggestedSize= CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0),NULL, CGSizeMake(width, CGFLOAT_MAX), NULL);
    CFRelease(framesetter);
    return suggestedSize.height;
}

@end
