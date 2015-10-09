//
//  WSBaseRequestModel.m
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "WSBaseRequestModel.h"
#import "WSDownloadCache.h"
#import "NSError+WebService.h"
#import "WSManager.h"
#import "WSErrorMessageCenter.h"
#import "WSMetaItem.h"

#define kApiHost (@"www.linkzhuo.com:8081/magic.web")
//#define kApiHost (@"www.linkzhuo.com:8086/link.web")
//#define kApiHost (@"10.10.7.104:8080/magic.web")
//#define kApiHost (@"192.168.1.100:8080/magic.web")

@interface WSBaseRequestModel () 

@end

@implementation WSBaseRequestModel

#pragma mark -
#pragma mark Accessors
- (NSString *)url {
    return [NSString stringWithFormat:@"http://%@/json%@.html", kApiHost, self.modelName];
}

- (NSTimeInterval)timeSpent {
    if (nil != self.requestSentDate && nil != self.requestFinishedDate) {
        return [self.requestFinishedDate timeIntervalSinceDate:self.requestSentDate];
    }
    return 0;
}


#pragma mark -
#pragma mark Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        self.methodName = @"GET";   //  Default if GET
        self.parameters = [NSMutableDictionary dictionary];
        self.diaplayErrorInfo = YES;
        
        self.shouldLoadResultSaveLocal = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Post Settings
- (NSDictionary *)basicParams {
    return nil;
}

- (NSData *)postBodyData {
    return nil;
}

- (void)postMultiPartHanlderWith:(id<AFMultipartFormData>)formData {
    
}

- (NSString *)postRequestQuery {
    __block NSMutableArray *paramEntry = [NSMutableArray arrayWithCapacity:[self.basicParams count]];
    
    NSArray *keys = [self.basicParams allKeys];
    NSArray *sortedKeys = [keys sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    
    
    for (id key in sortedKeys) {
        id obj = [self.basicParams objectForKey:key];
        if ([obj isKindOfClass:[NSArray class]]) {
            [obj enumerateObjectsUsingBlock:^(id value, NSUInteger idx, BOOL *stop) {
                [paramEntry addObject:[NSString stringWithFormat:@"%@=%@", key, [[value description] stringByPercentEscaping]]];
            }];
        } else {
            [paramEntry addObject:[NSString stringWithFormat:@"%@=%@", key, [[obj description] stringByPercentEscaping]]];
        }
        
    }
    
    return [paramEntry componentsJoinedByString:@"&"];
}

- (NSString *)postAbsoluteUrl {
    if (0 == [self.basicParams count]) {
        return self.url;
    } else {
        return [NSString stringWithFormat:@"%@?%@", self.url, self.postRequestQuery];
    }
}

#pragma mark -
#pragma mark Load

- (void)load {
    //	Check validation before sending request, such as text formats, empty text, date stamp and etc.
    NSError *error = nil;
    error = [self paramsValidation];
    if (error) {	// Found error, then return and shows the user a message
        [self requestDidFailWithError:error headers:nil localResult:YES];
        return;
    }
    
    //	Initialize returned dictionary
    [self paramsSettings];
    
    //	Mark the date time
    [self requestWillLoadSettings];
    
    //  Prepare before real loading
    if (self.prepareBlock && !self.shouldLoadLocalOnly) {
        self.prepareBlock(self);
    }
    
    [[WSManager getInstance] loadWithRequestModel:self];
}

- (void)loadLocalData {
    self.shouldLoadLocalOnly = YES;
    
    [self load];
}

- (void)loadWithLoadingMore:(BOOL)loadingMore {
    if (!loadingMore) {
        self.cursor = nil;
        self.hasNext = NO;
    }
    self.shouldLoadLocalOnly = NO;
    self.isLoadingMore = loadingMore;
    
    if (!loadingMore) {
        [self cancel];
    }
    
    [self load];
}

- (void)cancel {
    [self.operation cancel];
}

- (void)loadWithBackgroundPrehandler:(DDBlock)prehandler {
    if (nil != prehandler) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            prehandler(self);
            dispatch_async(dispatch_get_main_queue(), ^{
                [self load];
            });
        });
    } else {
        [self load];
    }
}

- (void)loadWithPrehandler:(DDBlock)prehandler {
    if (nil != prehandler) {
        prehandler(self);
    }
    [self load];
}


#pragma mark -
#pragma mark Web Servcie Response
- (void)requestWillLoadSettings {
    self.loadCount ++;
    self.requestSentDate = [NSDate date];
    self.timeSpent = 0;
    self.inProgress = YES;
}

- (void)requestDidFinishedSettings {
    self.requestFinishedDate = [NSDate date];
    self.operation = nil;
    self.inProgress = NO;
    
    //    DDLog(@"%f", self.timeSpent);
}

- (void)requestDidSuccessWithObject:(id)responseObject headers:(NSDictionary *)headers localResult:(BOOL)localResult {
    //  Update Request Model
    self.resultDidLoad = YES;
    self.didUseLocalData = localResult;
    [self requestDidFinishedSettings];
    
    if (self.successBlock) {
        self.successBlock(responseObject, headers, self);
    }
    
}

- (void)requestDidFailWithError:(NSError *)error headers:(NSDictionary *)headers localResult:(BOOL)localResult{
    //  Update Request Model
    [self requestDidFinishedSettings];
    
    if (!error.shouldIgnoreError && self.diaplayErrorInfo) {
        [[WSErrorMessageCenter getInstance] showAlertMessageWithError:error];
    }
    
    if (error.code == kWS_ErrorCode_RequestDidCancelledError && self.cancelBlock) {
        self.cancelBlock(error, headers, self);
    }
    
    if (!error.shouldIgnoreError && self.failBlock) {
        self.failBlock(error, headers, self);
    }
    
    //  Retry
    if (error.shouldRetryError && self.loadCount < 2) {
        [self loadWithLoadingMore:NO];
    }
    
}

#pragma mark -
#pragma mark Templates

- (NSError *)paramsValidation {
    return nil;
}

- (void)paramsSettings {
    [self.parameters removeAllObjects];
}

- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info {
    return nil;
}

@end
