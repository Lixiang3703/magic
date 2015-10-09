//
//  NSDate+YY.h
//  Wuya
//
//  Created by Tong on 18/06/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (YY)

- (NSString *)stringForShortDate;
- (NSString *)stringForPMDate;
- (NSString *)stringForPMSessionDate;


- (YYAstroType)astroType;

@end
