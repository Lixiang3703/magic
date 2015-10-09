//
//  YYBaseRequestModel.m
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYBaseRequestModel.h"

#import "YYBaseAPIItem.h"
#import "DDItemFactory.h"

#import "YYBaseAPIItem.h"
#import "KKAccountItem.h"

@implementation YYBaseRequestModel


#pragma mark -
#pragma mark Parameters
+ (NSString *)savePath {
    return [NSString filePathOfDocumentFolderWithName:[NSString stringWithFormat:@"MyHouse%@", [[self class] description]]];
}

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark -
#pragma mark Templates
- (NSDictionary *)basicParams {
    NSMutableDictionary *basicParams = [NSMutableDictionary dictionary];
    [basicParams setObject:@"ios" forKey:@"platform"];
//    [basicParams setObject:kRequestArgumentsV forKey:@"v"];
//    [basicParams setObject:@kApp_Channel forKey:@"channel"];
    [basicParams setObject:[NSString stringWithFormat:@"%@", [UIApplication appVersion]] forKey:@"appver"];
    
    if ([KKAccountItem sharedItem].userId && [KKAccountItem sharedItem].ticket) {
        [basicParams setObject:@([KKAccountItem sharedItem].userId) forKey:@"userId"];
        [basicParams setObject:[KKAccountItem sharedItem].ticket forKey:@"ticket"];
    }
    
    return basicParams;
}

- (void)paramsSettings {
    [super paramsSettings];
    
    self.resultItems = nil;
    self.resultItem = nil;
    
    if ([self.methodName isEqualIgnoringCase:@"GET"]) {
        [self.parameters addEntriesFromDictionary:self.basicParams];
    }
    
    if (self.count > 0) {
        [self.parameters setSafeObject:@(self.count) forKey:@"count"];
    }
    
    
    if (self.isLoadingMore && [self.cursor hasContent]) {
        [self.parameters setSafeObject:self.cursor forKey:@"cursor"];
    }
}

#pragma mark -
#pragma mark Response Hander
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    NSError *error = [super responseHanlderWithDataInfo:info];
    
    //  Parse List or single object
    if (nil == error && self.resultItemsKeyword && self.resultItemsClassName) {
        NSDictionary *resultDict = [info objectForSafeKey:self.resultItemsKeyword];
        
        if (self.resultItemSingle) {
            YYBaseAPIItem *item = nil;
            
            if (self.shouldAddToObjectsPool) {
                item = [[DDItemFactory getInstance] itemWithInfo:resultDict class:NSClassFromString(self.resultItemsClassName)];
            } else {
                item = [[NSClassFromString(self.resultItemsClassName) alloc] initWithDict:resultDict];
            }
            

            if (nil == item) {
                return [NSError wsResponseDataFormatError];
            }
            self.resultItem = item;
            
            //  Copy values if need
            if (nil != self.originItem) {
                [self.originItem copyValuesFromDict:resultDict];
            }
            
        } else {
            if (![resultDict isKindOfClass:[NSDictionary class]]) {
                NSLog(@"resultDict:%@",[[resultDict class] description]);
                return [NSError wsResponseDataFormatError];
            }
            
            self.hasNext = [[resultDict objectForSafeKey:@"hasNext"] boolValue];
            self.cursor = [[resultDict objectForSafeKey:@"nextCursor"] stringValue];
            
            NSArray *itemInfos = [resultDict objectForSafeKey:@"list"];
            NSMutableArray *resultItems = [NSMutableArray arrayWithCapacity:[itemInfos count]];
            
            if (![itemInfos isKindOfClass:[NSArray class]]) {
                return [NSError wsResponseDataFormatError];
            }
            
            YYBaseAPIItem *item = nil;
            
            for (NSDictionary *dict in itemInfos) {
                
                if (self.shouldAddToObjectsPool) {
                    item = [[DDItemFactory getInstance] itemWithInfo:dict class:NSClassFromString(self.resultItemsClassName)];
//                    [[DDObjectsPool getInstance].objectsPool addSafeObject:item];
                } else {
                    item = [[NSClassFromString(self.resultItemsClassName) alloc] initWithDict:dict];
                }
                

                [resultItems addObject:item];
                item = nil;
            }
            if ([resultItems count] > 0) {
                self.resultItems = resultItems;
            }
        }
        
    }
    
    return error;
}

@end
