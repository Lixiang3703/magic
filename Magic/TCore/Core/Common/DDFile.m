//
//  DDFile.m
//  LuckyTRCore
//
//  Created by Tong on 30/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDFile.h"
#import "NSData+Tools.h"

@implementation DDFile

+ (NSArray *)allLinesWithFileName:(NSString *)fileName type:(NSString *)type {
    return [[self class] allLinesWithFileName:fileName type:type encrypt:NO];
}

+ (NSArray *)allLinesWithFileName:(NSString *)fileName type:(NSString *)type encrypt:(BOOL)encrypt {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    
    NSString* fileContents = nil;
    if (encrypt) {
        NSData *rawData = [NSData dataWithContentsOfFile:filePath];
        fileContents = [[NSString alloc] initWithData:[rawData dataByDecrypting] encoding:NSUTF8StringEncoding];
    } else {
        fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
    return [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
}

+ (NSString *)appVersion {
    return [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
}

@end
