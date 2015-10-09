//
//  NSURL+Tools.h
//  Wuya
//
//  Created by Tong on 11/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (Tools)

- (NSString *)baseStringWithoutQuery;

- (NSDictionary *)queryInfo;

@end
