//
//  NSAttributedString+YY.m
//  Wuya
//
//  Created by lilingang on 14-6-26.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "NSAttributedString+YY.h"

@implementation NSAttributedString (YY)

+ (NSAttributedString *)attributedStringWithFormatString:(NSString *)format,...{
    
    va_list argList;
    va_start(argList, format);
    
    NSString *convertString = [[NSString alloc] initWithFormat:format arguments:argList];
    /*临时存储要替换的字符串*/
    NSMutableArray *replaceStrings = [NSMutableArray arrayWithCapacity:0];
    
    int charIndex = 0;
    while (charIndex < [format length] - 1){
        NSString *replaceString = @"";
        unichar aChar = [format characterAtIndex:++charIndex];
        /* 如果不是控制字符退出本次循环 */
        if (aChar!='%') continue;
        
        aChar = [format characterAtIndex:++charIndex];
        NSString *placeString = @"";
        switch (aChar){
            case 'd':{
                /* 下一个参数是int */
                int intValue = va_arg(argList,int);
                replaceString = [NSString stringWithFormat:@"%d",intValue];
            }
                break;
            case '.':{
                  /* 下一个参数有可能是有位数限制的float(va_arg把float转位double) */
                /*获取保留字*/
               unichar tmpChar = [format characterAtIndex:++charIndex];
                placeString = [[NSString alloc] initWithCharactersNoCopy:&tmpChar length:1 freeWhenDone:NO];
                aChar = [format characterAtIndex:++charIndex];
                if (aChar != 'f') break;
            }
            case 'f':{
                /* 下一个参数是double */
                float floatValue = (float)va_arg(argList,double);
                char buf[50];
                NSMutableString *string = [NSMutableString stringWithString:@"%.f"];
                [string insertString:placeString atIndex:2];
                placeString = nil;
                sprintf(buf, [string UTF8String], floatValue);
                replaceString = [NSString stringWithUTF8String:buf];
            }
                break;
            default:
                break;
        }
        [replaceStrings addObject:replaceString];
    }
    
    va_end(argList);
    
    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithString:convertString];
    for (NSString *string in replaceStrings) {
        NSRange range = [convertString rangeOfString:string];
        [mutableAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor YYYellowColor] range:range];
        [mutableAttributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:28] range:range];
    }
    return [mutableAttributeString copy];
}

+ (NSAttributedString *)attributedStringForEditWithFormatString:(NSString *)format {
    NSInteger charIndex = [format length] - 1;
    NSString *replaceStr = @"";
    while (charIndex > 0) {
        unichar aChar = [format characterAtIndex:charIndex];
        if (aChar == '+') {
            replaceStr = [format substringFromIndex:charIndex];
            break;
        }
        charIndex --;
    }
    
    NSMutableAttributedString *mutableAttributeString = [[NSMutableAttributedString alloc] initWithString:format];
    
    if (replaceStr.length > 0) {
        NSRange range = [format rangeOfString:replaceStr];
        [mutableAttributeString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:range];
        [mutableAttributeString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:range];
    }
    return [mutableAttributeString copy];
}

@end
