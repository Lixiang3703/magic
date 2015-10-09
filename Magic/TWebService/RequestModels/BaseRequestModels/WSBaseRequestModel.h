//
//  WSBaseRequestModel.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"
#import "WSDefinitions.h"
#import "WSAlertItem.h"
#import "WSMetaItem.h"

typedef NS_ENUM(NSUInteger, WSPOSTRequestMode) {
    WSPOSTRequestModeURLFormEncoded,
    WSPOSTRequestModeMultiPart,
    WSPOSTRequestModeBodyData,
};


@class WSBaseRequestModel;


typedef void (^WSPrepareBlock)(id requestModel);
typedef void (^WSSuccessBlock)(id responseObject, NSDictionary *headers, id requestModel);
typedef void (^WSFailBlock)(NSError *error, NSDictionary *headers, id requestModel);

@interface WSBaseRequestModel : NSObject {
    NSString *_url;
}

/** Name, e.g. /api/constants */
@property (atomic, copy) NSString *modelName;
/** Method "GET" or "POST" */
@property (atomic, copy) NSString *methodName;
/** Parameters */
@property (atomic, strong) NSMutableDictionary *parameters;
/** Whole URL e.g. http://papa.me/constants?hello=111 */
@property (atomic, readonly) NSString *url;
/** Custom Info */
@property (atomic, strong) NSDictionary *userInfo;
/** Custom Host */
@property (atomic, copy) NSString *customApiHost;
/** TTL */
@property (atomic, assign) NSUInteger ttl;
/** Publish */
@property (atomic, assign) BOOL publicAPI;
/** LocalSaveFilePath */
@property (atomic, copy) NSString *localSaveFilePath;
/** Timeout */
@property (atomic, assign) NSTimeInterval timeoutInterval;

/** Date */
@property (atomic, strong) NSDate *requestSentDate;
@property (atomic, strong) NSDate *requestFinishedDate;
@property (nonatomic, assign) NSTimeInterval timeSpent;
@property (atomic, assign) NSTimeInterval minTimeSpent;

/** Loading Flags */
@property (atomic, assign) NSInteger loadCount;
@property (atomic, assign) BOOL resultDidLoad;
@property (atomic, assign) BOOL inProgress;
@property (atomic, assign) BOOL diaplayErrorInfo;

/** Handler */
@property (atomic, copy) WSPrepareBlock prepareBlock;
@property (atomic, copy) WSSuccessBlock successBlock;
@property (atomic, copy) WSFailBlock failBlock;
@property (atomic, copy) WSFailBlock cancelBlock;

/** Default Response Alert Info */
@property (atomic, copy) WSAlertItem *successAlertItem;
@property (atomic, copy) WSAlertItem *failAlertItem;

/** URLConnection */
@property (atomic, weak) NSOperation *operation;
@property (atomic, assign) BOOL agent;

/** Meta */
@property (atomic, strong) WSMetaItem *metaItem;

/** Post Settings */
@property (atomic, assign) WSPOSTRequestMode postRequestMode;
- (NSDictionary *)basicParams;
- (NSData *)postBodyData;
- (void)postMultiPartHanlderWith:(id<AFMultipartFormData>)formData;
- (NSString *)postRequestQuery;
- (NSString *)postAbsoluteUrl;

/** Load */
- (void)load;
- (void)loadLocalData;
- (void)cancel;
- (void)loadWithBackgroundPrehandler:(DDBlock)prehandler;
- (void)loadWithPrehandler:(DDBlock)prehandler;



/** Loading More Things */
@property (atomic, assign) NSInteger count;
@property (atomic, copy) NSString *cursor;
@property (atomic, assign) BOOL hasNext;
@property (atomic, assign) BOOL isLoadingMore;
- (void)loadWithLoadingMore:(BOOL)loadingMore;

/** Cache */
@property (atomic, assign) BOOL shouldLoadLocalOnly;
@property (atomic, assign) BOOL shouldLoadResultSaveLocal;
@property (atomic, assign) BOOL didUseLocalData;
@property (atomic, assign) BOOL shouldAddToObjectsPool;


/** Web Servcie Response */
- (void)requestDidSuccessWithObject:(id)responseObject headers:(NSDictionary *)headers localResult:(BOOL)localResult;
- (void)requestDidFailWithError:(NSError *)error headers:(NSDictionary *)headers localResult:(BOOL)localResult;

/** Templates */

//	Template method, return an error before http request starts
- (NSError *)paramsValidation;
- (void)paramsSettings;
- (NSError *)responseHanlderWithDataInfo:(NSDictionary *)info;


@end
