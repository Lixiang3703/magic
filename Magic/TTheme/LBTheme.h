//
//  LBTheme.h
//  LBiPhone
//
//  Created by Cui Tong on 10/08/2011.
//  Copyright 2011 diandian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LBTheme : NSObject {

    NSString *_themeName;
    NSDictionary *_settingsDict;
}

@property (nonatomic, copy) NSString *themeName;
@property (nonatomic, strong) NSDictionary *settingsDict;

- (id)initWithThemeName:(NSString *)themeName;
- (NSDictionary *)dictionaryOfSettingsWithUIType:(NSString *)type;

@end
