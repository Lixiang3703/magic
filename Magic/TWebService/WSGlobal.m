//
//  WSGlobal.m
//  DDAPI
//
//  Created by Cui Tong on 26/06/2012.
//  Copyright (c) 2012 diandian. All rights reserved.
//

#import "WSGlobal.h"
#import "AFNetworkActivityLogger.h"
#import "AFNetworkReachabilityManager.h"
#import "AFNetworkActivityIndicatorManager.h"


@implementation WSGlobal

+ (void)globalSettings {

    
    //  Reachability
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //  Network Activity
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
    
    //  Logging
#ifdef DEBUG
    [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif
    
    
}


+ (void)clearCache {
  
}



@end
