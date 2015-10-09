//
//  NSDate+YY.m
//  Wuya
//
//  Created by Tong on 18/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSDate+YY.h"
#import "NSDateFormatter+YY.h"
#import "NSDate+Calendar.h"

@implementation NSDate (YY)

- (NSString *)stringForShortDate {
    NSDateFormatter *formatter = [NSDateFormatter pmSessionFormater];
    NSString *selfDateString = [formatter stringFromDate:self];
    
    return selfDateString;
}
- (NSString *)stringForPMDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter pmSessionFormater];
    NSString *todayString = [formatter stringFromDate:today];
    
    NSString *selfDateString = [formatter stringFromDate:self];
    
    NSString *resDateString = nil;
    if ([todayString isEqualToString:selfDateString]) {
        resDateString = [[NSDateFormatter pmSessionShortFormater] stringFromDate:self];
    } else {
        resDateString = [[NSDateFormatter pmFormater] stringFromDate:self];
    }
    
    return resDateString;
}

- (NSString *)stringForPMSessionDate {
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [NSDateFormatter pmSessionFormater];
    NSString *todayString = [formatter stringFromDate:today];
    
    NSString *selfDateString = [formatter stringFromDate:self];
    
    NSString *resDateString = nil;
    if ([todayString isEqualToString:selfDateString]) {
        resDateString = [[NSDateFormatter pmSessionShortFormater] stringFromDate:self];
    } else {
        resDateString = selfDateString;
    }
    
    return resDateString;
}


/*
 YYAstroTypeAries,      //白羊座 03月21日─04月20日
 YYAstroTypeTaurus,     //金牛座 04月21日─05月20日
 YYAstroTypeGemini,     //双子座 05月21日─06月21日
 YYAstroTypeCancer,     //巨蟹座 06月22日─07月22日
 YYAstroTypeLeo,        //狮子座 07月23日─08月22日
 YYAstroTypeVirgo,      //处女座 08月23日─09月22日
 YYAstroTypeLibra,      //天秤座 09月23日─10月22日
 YYAstroTypeScorpio,    //天蝎座 10月23日─11月21日
 YYAstroTypeSagittarius,//射手座 11月22日─12月21日
 YYAstroTypeCapricornus,//摩羯座 12月22日─01月19日
 YYAstroTypeAquarius,   //水瓶座 01月20日─02月18日
 YYAstroTypePisces,     //双鱼座 02月19日─03月20日
 */
- (YYAstroType)astroType {
    NSInteger month = self.month;
    NSInteger day = self.day;
    YYAstroType resType = YYAstroTypeUnknown;
    switch (month) {
        case 3:
            resType = (day < 21 ? YYAstroTypePisces : YYAstroTypeAries);
            break;
        case 4:
            resType = (day < 21 ? YYAstroTypeAries : YYAstroTypeTaurus);
            break;
        case 5:
            resType = (day < 21 ? YYAstroTypeTaurus : YYAstroTypeGemini);
            break;
        case 6:
            resType = (day < 22 ? YYAstroTypeGemini : YYAstroTypeCancer);
            break;
        case 7:
            resType = (day < 23 ? YYAstroTypeCancer : YYAstroTypeLeo);
            break;
        case 8:
            resType = (day < 23 ? YYAstroTypeLeo : YYAstroTypeVirgo);
            break;
        case 9:
            resType = (day < 23 ? YYAstroTypeVirgo : YYAstroTypeLibra);
            break;
        case 10:
            resType = (day < 23 ? YYAstroTypeLibra : YYAstroTypeScorpio);
            break;
        case 11:
            resType = (day < 22 ? YYAstroTypeScorpio : YYAstroTypeSagittarius);
            break;
        case 12:
            resType = (day < 22 ? YYAstroTypeSagittarius : YYAstroTypeCapricornus);
            break;
        case 1:
            resType = (day < 20 ? YYAstroTypeCapricornus : YYAstroTypeAquarius);
            break;
        case 2:
            resType = (day < 19 ? YYAstroTypeAquarius : YYAstroTypePisces);
            break;
        default:
            break;
    }
    return resType;
}

@end
