//
//  KKBaseLoginRequestModel.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKBaseLoginRequestModel.h"

@implementation KKBaseLoginRequestModel

#pragma mark -
#pragma mark Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        self.agent = YES;
        self.methodName = @"POST";
        self.shouldLoadResultSaveLocal = NO;
    }
    return self;
}


#pragma mark -
#pragma mark Params
- (NSError *)paramsValidation {
    NSError *error = [super paramsValidation];
    
    if (nil == error && nil == self.loginItem) {
        error = [NSError wsRequestParamError];
    }
    
    return error;
}

#pragma mark -
#pragma mark Template


- (NSError *)responseHanlderLoginSuccWithDataInfo:(NSDictionary *)info {
    NSError *error = nil;
    NSString *ticket = [info objectForSafeKey:@"ticket"];
    if (nil == error && (![ticket isKindOfClass:[NSString class]] || ![ticket hasContent])) {
        error = [NSError wsResponseDataFormatError];
    }
    
    NSDictionary *userInfoDict = [info objectForSafeKey:@"user"];
    KKPersonItem *personItem = [[KKPersonItem alloc] initWithDict:userInfoDict];
    if (nil != personItem) {
        [KKUserInfoItem sharedItem].personItem = personItem;
        [[KKUserInfoItem sharedItem] save];
        
        self.loginItem.personItem = personItem;
    }
    
    if (nil == error) {
        //  Save Ticket
        KKAccountItem *accountItem = [KKAccountItem sharedItem];
        
        accountItem.userId = personItem.kkId;
        accountItem.mobile = self.loginItem.mobile ? self.loginItem.mobile : @"unknown";
        accountItem.ticket = ticket;
        
        [accountItem save];
    }
    
    return error;
}

@end
