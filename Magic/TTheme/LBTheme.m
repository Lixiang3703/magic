//
//  LBTheme.m
//  LBiPhone
//
//  Created by Cui Tong on 10/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import "LBTheme.h"
#import "LBThemeDefinitions.h"


@interface LBTheme (Private)

- (NSArray *)pathesInPlistFileWithUIType:(NSString *)type;
- (NSString *)fileNameOfTheme;

@end

@implementation LBTheme
#pragma mark -
#pragma mark Properties
@synthesize themeName = _themeName;
@synthesize settingsDict = _settingsDict;


#pragma mark -
#pragma mark Properties
- (NSDictionary *)settingsDict {
    if (_settingsDict == nil) {
        //  Change the code here if you want to use JSON instead.
        _settingsDict = [[NSDictionary alloc] initWithContentsOfURL:
                         [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[self fileNameOfTheme] 
                                                                                ofType:@"plist"]
                                    isDirectory:NO]];
        
    } 
    return _settingsDict;
}

#pragma mark -
#pragma mark Life cycle

- (id)initWithThemeName:(NSString *)themeName {
    self = [super init];
    if (self) {
        self.themeName = themeName;
        NSLog(@"ThemeName is %@", themeName);
    }
    return self;
}

#pragma mark -
#pragma mark UI setting methods
- (NSDictionary *)dictionaryOfSettingsWithUIType:(NSString *)type {
    NSDictionary *dict = [NSDictionary dictionaryWithDictionary:self.settingsDict];
    
    NSArray *pathes = [self pathesInPlistFileWithUIType:type];
    
    if ([pathes count] == 0) {    //  Empty pathes
        return nil;
    }
    
    for (NSString *pathKeyword in pathes) {
        if ([pathKeyword isEqualToString:@""]) {
            continue;
        }
        dict = [dict objectForKey:pathKeyword];
    }
    
    NSString *superTheme = [dict objectForKey:kThemeKeywordAttrSuper];
    if (nil != superTheme) {
        NSDictionary *additionDict = [self dictionaryOfSettingsWithUIType:superTheme];
        NSMutableDictionary *totalDict = [NSMutableDictionary dictionaryWithDictionary:additionDict];
       
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (![key isEqualToString:kThemeKeywordAttrSuper]) {
                [totalDict setValue:obj forKey:key];
            }
        }];
        return totalDict;
    }
    
    return dict;
}

- (NSArray *)pathesInPlistFileWithUIType:(NSString *)type {
    
    return [type componentsSeparatedByString:@"|"];  
}

#pragma mark -
#pragma mark Factory method - Get Plist file name from type
- (NSString *)fileNameOfTheme {
    return [NSString stringWithFormat:@"%@Theme", self.themeName];
}


@end
