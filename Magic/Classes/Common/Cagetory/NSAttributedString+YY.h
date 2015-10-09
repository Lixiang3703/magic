//
//  NSAttributedString+YY.h
//  Wuya
//
//  Created by lilingang on 14-6-26.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (YY)
//
//浮点数格式必须是%.xf,只能精确到小数点后9位
//
+ (NSAttributedString *)attributedStringWithFormatString:(NSString *)format,...;

+ (NSAttributedString *)attributedStringForEditWithFormatString:(NSString *)format;

@end
