//
//  NSURL+Tools.m
//  Wuya
//
//  Created by Tong on 11/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "NSURL+Tools.h"

@implementation NSURL (Tools)

- (NSString *)baseStringWithoutQuery {
    NSString *query = self.query;
    if (nil == query) {
        return self.absoluteString;
    } else {
        return [self.absoluteString stringByReplacingOccurrencesOfString:[@"?" stringByAppendingString:self.query] withString:@""];
    }
    
}

- (NSDictionary *)queryInfo {
    NSString *queryString = self.query;
    NSArray *queryArray = [queryString componentsSeparatedByString:@"&"];

    __block NSMutableDictionary *resDict = [NSMutableDictionary dictionaryWithCapacity:[queryArray count]];
    [queryArray enumerateObjectsUsingBlock:^(NSString *divString, NSUInteger idx, BOOL *stop) {
        NSArray* array = [divString componentsSeparatedByString:@"="];
		if (2 == [array count]) {
            [resDict setObject:[[array lastObject] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:[array firstObject]];
        }
    }];

	return resDict;
}

@end
