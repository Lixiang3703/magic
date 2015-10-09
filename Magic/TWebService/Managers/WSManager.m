//
//  WSManager.m
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "WSManager.h"
#import "WSBaseRequestModel.h"
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

#import "WSMetaItem.h"
#import "WSDownloadCache.h"
#import "NSError+WebService.h"
#import "WSCertificationManager.h"

@interface WSManager ()


@property (nonatomic, strong) NSDictionary *linkMetaErrorCodeMessagesInfo;

//@property (nonatomic, strong) NSDictionary *metaErrorCodeMessagesInfo;

@property (atomic, strong) NSHashTable *getRequestPool;
@property (atomic, strong) NSHashTable *postRequestPool;
@property (atomic, strong) NSMutableArray *agentRequestPool;
@property (atomic, strong) NSMutableDictionary *lastUpdateDateInfo;

@end

@implementation WSManager
SYNTHESIZE_SINGLETON_FOR_CLASS(WSManager);

#pragma mark -
#pragma mark Accessors

-(NSDictionary *)linkMetaErrorCodeMessagesInfo {
    if (_linkMetaErrorCodeMessagesInfo == nil) {
        _linkMetaErrorCodeMessagesInfo = @{@(401):@"需要登录",
                                           @(403):@"没有权限",
                                           @(500):@"服务器出错了",
                                           @(40000):@"请求的Item不存在",
                                           @(40001):@"用户名或密码不对",
                                           @(40002):@"插入失败",
                                           @(40003):@"更新失败",
                                           @(40005):@"旧密码不对",
                                           @(40006):@"验证码不对",
                                           @(40007):@"验证码发送过于频繁",
                                           @(40010):@"生成订单失败",
                                           
                                           @(40012):@"对于这个实体已经评论过了",
                                           @(40013):@"图片是后台管理员上传的，不能删除",
                                           @(40021):@"机构已经存在 请直接加入",
                                           @(40022):@"机构不存在",
                                           
                                           @(40034):@"没有最近的聊天信息",
                                           
                                           @(40082):@"该邮箱或手机号已被注册",
                                           @(40083):@"注册插入失败",
                                           @(40085):@"此手机号还未注册，请注册",
                                           };
    }
    return _linkMetaErrorCodeMessagesInfo;
}

//- (NSDictionary *)metaErrorCodeMessagesInfo {
//    if (nil == _metaErrorCodeMessagesInfo) {
//        _metaErrorCodeMessagesInfo = @{@(403):@"没有权限",
//                                       @(500):@"服务器出错了~我们正在紧张的修复中",
//                                       @(40000):@"手机号或密码错误",
//                                       @(40001):@"请输入正确的手机号",
//                                       @(40002):@"该手机号已注册，可直接登录",
//                                       @(40003):@"验证码发的太快了，请稍后再试",
//                                       @(40004):@"验证码错误",
//                                       @(40005):@"验证码过期了，请重新发送验证码",
//                                       @(40006):@"帐号出现异常\n请联系wuyafeedback@gmail.com",
//                                       @(40007):@"最多可评论1000字",
//                                       @(40008):@"评论不能超过1000字",
//                                       @(40011):@"服务器出错了，请稍后再试",
//                                       @(40012):@"该乌鸦已被删除",
//                                       @(40013):@"发布失败，请检查你要发布的内容",
//                                       @(40014):@"你已被禁言\n请联系wuyafeedback@gmail.com",
//                                       @(40015):@"操作过快",
//                                       @(40016):@"学校信息半年内只能修改一次，有修改需要发邮件至wuyafeedback@gmail.com",
//                                       @(40017):@"输入文字太长了，一条最多500字",
//                                       @(40018):@"评价不能超过15个字",
//                                       @(40019):@"TA还没有加入乌鸦，或你不在TA的通讯录中\n你不能再评价TA了~",
//                                       @(40020):@"你刚刚已经评价过TA了，过一会才能再次评价",
//                                       @(40021):@"你目前无法对该用户进行评价",
//                                       @(40022):@"你今天的评价次数用完啦，明天再来吧",
//                                       @(40023):@"旧密码输入错误",
//                                       @(40024):@"帐号没有注册，请检查手机号",
//                                       @(40025):@"学校信息有误，请重新选择",
//                                       @(40026):@"对方拒绝接受你的消息",
//                                       };
//    }
//    return _metaErrorCodeMessagesInfo;
//}

#pragma mark -
#pragma mark Reset
- (void)reset {
    [self.getRequestPool removeAllObjects];
    [self.postRequestPool removeAllObjects];
    [self.agentRequestPool removeAllObjects];
    [self.lastUpdateDateInfo removeAllObjects];
}

#pragma mark -
#pragma mark Newtork Indicator

- (void)networkIndicatorEnabled:(BOOL)enabled {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = enabled;
}

- (void)networkIndicatorIncrementActivityCount {
    [[AFNetworkActivityIndicatorManager sharedManager] incrementActivityCount];
}

- (void)networkIndicatorDecrementActivityCount {
    [[AFNetworkActivityIndicatorManager sharedManager] decrementActivityCount];
}

#pragma mark -
#pragma mark Initialization

- (instancetype)init {
    self = [super init];
    if (self) {
        self.getRequestPool = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsWeakMemory capacity:4];
        self.postRequestPool = [[NSHashTable alloc] initWithOptions:NSPointerFunctionsStrongMemory capacity:4];
        self.agentRequestPool = [NSMutableArray array];
        
        self.lastUpdateDateInfo = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -
#pragma mark Request Pool
- (NSHashTable *)requestPoolWithMethod:(NSString *)method {
    if ([method isEqualIgnoringCase:@"GET"]) {
        return self.getRequestPool;
    } else if ([method isEqualIgnoringCase:@"POST"]) {
        return self.postRequestPool;
    }
    return nil;
}

- (BOOL)containsRequestModel:(WSBaseRequestModel *)requestModel {
    NSHashTable *requestPool = [self requestPoolWithMethod:requestModel.methodName];
    return [requestPool containsObject:requestModel];
}

- (void)addRequestModel:(WSBaseRequestModel *)requestModel {
    NSHashTable *requestPool = [self requestPoolWithMethod:requestModel.methodName];
    
    [requestPool containsObject:requestModel];
    
    if (requestModel.agent) {
        [self.agentRequestPool addObject:requestModel];
    }
}

- (void)removeRequestModel:(WSBaseRequestModel *)requestModel success:(BOOL)success {
    NSHashTable *requestPool = [self requestPoolWithMethod:requestModel.methodName];
    [requestPool removeObject:requestModel];;
    
    if (requestModel.agent) {
        [self.agentRequestPool removeObject:requestModel];
    }
    
}


#pragma mark -
#pragma mark Load

- (void)loadWithRequestModel:(WSBaseRequestModel *)requestModel {
    
    if (requestModel.ttl > 0 && !requestModel.shouldLoadLocalOnly) {
        NSDate *lastDate = [self.lastUpdateDateInfo objectForKey:requestModel.modelName];
        NSTimeInterval timeInterval = [[NSDate date] timeIntervalSinceDate:lastDate];
        if (timeInterval < requestModel.ttl) {
            return;
        }
        
        [self.lastUpdateDateInfo setObject:[NSDate date] forKey:requestModel.modelName];
    }
    
    if (!requestModel.agent && requestModel.operation.isExecuting) {
        [requestModel.operation cancel];
    }
    
    [self addRequestModel:requestModel];
    
    
    NSMutableURLRequest *request = [self urlRequestWithWSRequestModel:requestModel];

    
    //  Local Local Resulst
    if (requestModel.shouldLoadLocalOnly) {
        
        if (requestModel.publicAPI && [[WSDownloadCache getInstance] cacheDidExistWithUrl:request.URL.absoluteString resource:NO]) {
            [[WSDownloadCache getInstance] moveItemsFromLocalForUrl:request.URL.absoluteString resource:NO];
        }
        
        NSDictionary *result = [[WSDownloadCache getInstance] resultForUrl:request.URL.absoluteString];
        NSDictionary *headers = [[WSDownloadCache getInstance] headersForUrl:request.URL.absoluteString];
        
        if (nil != result) {
            [self afDidSuccessWithOperation:nil responseObject:result headerFields:headers localRequestModel:requestModel localResult:YES];
        } else {
            [self afDidFailWithOperation:nil error:[NSError wsNoLocalResultError] headerFields:headers localRequestModel:requestModel localResult:YES];
        }
        
        return;
    }
    
    
    __weak WSBaseRequestModel *weakRequestModel = requestModel;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //  Operation
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [[WSManager getInstance] afDidSuccessWithOperation:operation responseObject:responseObject headerFields:operation.response.allHeaderFields localRequestModel:weakRequestModel localResult:NO];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [[WSManager getInstance] afDidFailWithOperation:operation error:error headerFields:operation.response.allHeaderFields localRequestModel:weakRequestModel localResult:NO];
        
    }];
    
    [operation setWillSendRequestForAuthenticationChallengeBlock:^(NSURLConnection *connection, NSURLAuthenticationChallenge *challenge) {
        NSURLProtectionSpace *protectionSpace = [challenge protectionSpace];
        SecTrustRef trust = [protectionSpace serverTrust];
        SecTrustResultType trustResult;
        OSStatus err = SecTrustEvaluate(trust, &trustResult);
        BOOL trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed) || (trustResult == kSecTrustResultUnspecified));
        if (!trusted) {
            err = SecTrustSetAnchorCertificates(trust, (__bridge CFArrayRef) [WSCertificationManager getInstance].certificates);
            if (err == noErr) {
                err = SecTrustEvaluate(trust, &trustResult);
            }
            trusted = (err == noErr) && ((trustResult == kSecTrustResultProceed) || (trustResult == kSecTrustResultUnspecified));
        }
        
        if (!trusted) {
            [[challenge sender] useCredential:[NSURLCredential credentialForTrust:trust] forAuthenticationChallenge:challenge];
        }

    }];
    
    requestModel.operation = operation;
    
    [manager.operationQueue addOperation:operation];
//    
//    //  Logger
//    [[DDCrashManager getInstance] logRequestModel:request.URL.absoluteString];
}



- (NSMutableURLRequest *)urlRequestWithWSRequestModel:(WSBaseRequestModel *)requestModel {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSDictionary *parameters = [requestModel.parameters count] > 0 ? requestModel.parameters : nil;
    
    NSMutableURLRequest *request = nil;
    
    NSTimeInterval timeoutInterval = requestModel.timeoutInterval;
    
    if ([@"GET" isEqualIgnoringCase:requestModel.methodName]) {
        request = [manager.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:requestModel.url relativeToURL:manager.baseURL] absoluteString] parameters:parameters error:nil];
        
        //  Set Timeout
        if (0 == timeoutInterval) {
            timeoutInterval = kWS_Request_TimeOut_Get_Interval;
        }
    } else if ([@"POST" isEqualIgnoringCase:requestModel.methodName]) {
        switch (requestModel.postRequestMode) {
            case WSPOSTRequestModeURLFormEncoded:
            {
                request = [manager.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:requestModel.postAbsoluteUrl relativeToURL:manager.baseURL] absoluteString] parameters:parameters error:nil];
            }
                break;
            case WSPOSTRequestModeMultiPart:
            {
                NSString *url = requestModel.postAbsoluteUrl;
                __weak WSBaseRequestModel *weakRequestModel = requestModel;
                request = [manager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:url relativeToURL:manager.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                    [weakRequestModel postMultiPartHanlderWith:formData];
                } error:nil];
            }
                break;
            case WSPOSTRequestModeBodyData:
            {
                request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestModel.postAbsoluteUrl]];
                
                // Generate an NSData
                NSData *postBody = [requestModel postBodyData];
                
                // Add Content-Length header if your server needs it
                unsigned long long postLength = postBody.length;
                NSString *contentLength = [NSString stringWithFormat:@"%llu", postLength];
                [request addValue:contentLength forHTTPHeaderField:@"Content-Length"];
                [request addValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
                
                [request setHTTPMethod:@"POST"];
                [request setHTTPBody:postBody];
            }
                break;
            default:
                break;
        }
        
        //  Set Timeout
        if (0 == timeoutInterval) {
            timeoutInterval = kWS_Request_TimeOut_Post_Interval;
        }
    }
    
    [request setTimeoutInterval:timeoutInterval];
    
//    NSString *idfaString = [UIDevice deviceIdentifier];
//    if ([idfaString hasContent]) {
//        [request addValue:idfaString forHTTPHeaderField:@"IDFA"];
//    }

    [request setValue:[UIDevice platform] forHTTPHeaderField:@"iOS-Platform"];
    
    return request;
}

#pragma mark -
#pragma mark Response Handler

- (void)afDidSuccessWithOperation:(AFHTTPRequestOperation *)operation responseObject:(id)responseObject headerFields:(NSDictionary *)headerFields localRequestModel:(WSBaseRequestModel *)localRequestModel localResult:(BOOL)localResult {
//    DDLog(@"%@", responseObject);
    
    WSBaseRequestModel *requestModel = localRequestModel;
    
    NSError *theError = nil;

    NSDictionary *responseDict = (NSDictionary *)responseObject;
    
    if (nil == theError && ![responseDict isKindOfClass:[NSDictionary class]]) {
        theError = [NSError wsResponseFormatError];
    }
    
    WSMetaItem *metaItem = [[WSMetaItem alloc] initWithDict:[responseDict objectForSafeKey:@"meta"]];
    
    if (![requestModel didUseLocalData]) {
        // 这里可能需要重新算allCost
//        NSTimeInterval allCost = [[NSDate date]timeIntervalSinceDate:requestModel.requestSentDate];
//        metaItem.cost = allCost;
    }
    
    if (nil == theError && nil == metaItem) {
        theError = [NSError wsMetaEmptyError];
    }
    
    if (nil == theError && 401 == metaItem.code) {
        theError = [NSError wsNeedLoginError];
    }
    
    if (nil == theError && 1 != metaItem.code) {
        theError = [NSError errorWithCode:kWS_ErrorCode_MetaCodeError title:[NSString stringWithFormat:@"wsMetaCodeError%lu", (unsigned long)metaItem.code] detail:[self.linkMetaErrorCodeMessagesInfo objectForSafeKey:@(metaItem.code)]];
        if (metaItem.code == 500) {

        }
    }
    
    NSDictionary *dataDict = [responseDict objectForSafeKey:@"data"];
    if (nil == theError && ![dataDict isKindOfClass:[NSDictionary class]]) {
        theError = [NSError wsResponseDataFormatError];
    }
    
    if (nil == theError) {
        theError = [requestModel responseHanlderWithDataInfo:dataDict];
    }
    
    if (nil == theError) {

        //  Order is really important
        [self removeRequestModel:requestModel success:YES];
        
        //  Save Resulst
        if (!localResult && requestModel.shouldLoadResultSaveLocal && [requestModel.methodName isEqualToString:@"GET"] && !requestModel.isLoadingMore) {
            [[WSDownloadCache getInstance] saveInfo:responseObject headers:headerFields forUrl:operation.request.URL.absoluteString];
        }
        
        requestModel.metaItem = metaItem;
        [requestModel requestDidSuccessWithObject:responseObject headers:headerFields localResult:localResult];
        

        
    } else {
        //  Go Error branch
        requestModel.metaItem = metaItem;
        [self afDidFailWithOperation:operation error:theError headerFields:headerFields localRequestModel:localRequestModel localResult:localResult];
    }
}

- (void)afDidFailWithOperation:(AFHTTPRequestOperation *)operation error:(NSError *)error headerFields:(NSDictionary *)headerFields localRequestModel:(WSBaseRequestModel *)localRequestModel localResult:(BOOL)localResult {

    WSBaseRequestModel *requestModel = localRequestModel;
    
    NSError *theError = error.isTError ? error : nil;
    
    if (nil == theError && operation.isCancelled) {
        theError = [NSError wsRequestDidCancelledError];
    }
    
    if (nil == theError && -1009 == error.code) {
        theError = [NSError wsNetworkNotAvalableError];
    }
    
    if (nil == theError && 0 == operation.response.statusCode) {
        theError = [NSError wsRequestTimeoutError];
    }
    
    if (nil == theError && 401 == operation.response.statusCode) {
        theError = [NSError wsNeedLoginError];
    }
    
    if (nil == theError && 200 != operation.response.statusCode) {
        theError = [NSError wsHttpResponseStatusError];
    }
    
    if (nil == theError && ![[[operation.response allHeaderFields] responseHeaderContentType] hasPrefix:@"application/json"]) {
        theError = [NSError wsHttpResponseAcceptContentTypeError];
    }
    
    if (nil == theError && nil == operation.responseString) {
        theError = [NSError wsResponseEmptyError];
    }
    
    if (nil == theError && operation.responseString.length > 0) {
        theError = [NSError wsJSONParserError];
//        [[DDStat getInstance] addStatObject:[NSString stringWithFormat:@"%@-[jsonParseError]",[requestModel modelName]] forType:DDGatherLogTypeServerFailRequests];
    }
    
    if (nil == theError) {
        theError = [NSError wsUnknownError];
    }
    

    [self removeRequestModel:requestModel success:NO];
    
    //  Handle TTL
    if (requestModel.ttl > 0) {
        [self.lastUpdateDateInfo removeObjectForKey:requestModel.modelName];
    }
    
    [requestModel requestDidFailWithError:theError headers:headerFields localResult:localResult];

    
    if (theError.code == kWS_ErrorCode_NeedLoginError) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kWS_Notification_NeedLogin object:nil];
    }
}


@end
