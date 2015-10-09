//
//  DDLauncher.m
//  Link
//
//  Created by Lixiang on 14/10/25.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "DDLauncher.h"

@implementation DDLauncher

SYNTHESIZE_SINGLETON_FOR_CLASS(DDLauncher);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Accessors

#pragma mark -
#pragma mark Life cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}


#pragma mark -
#pragma mark Update Logic
- (void)appDidFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self singletonManagersPass];
    
    [self checkAppUpdate];
    
    [self checkRemoteAppConstant];
    [self checkUserInfo];
    [self checkAddressBookContacts];
    
}

- (void)applicationWillEnterForeground {
    [self checkRemoteAppConstant];
    
    [self checkAddressBookContacts];
    
    [self checkUnreadInfo];
}

- (void)singletonManagersPass {
    
}

- (void)checkAppUpdate {

}

- (void)checkRemoteAppConstant {
    
}

- (void)checkUserInfo {
    
}


- (void)checkUnreadInfo {
}

- (void)checkUnreadInfoWithForce:(BOOL)force successBlock:(WSSuccessBlock)successBlock failBlock:(WSFailBlock)failBlock {
    
}

- (void)checkAddressBookContacts {
    
}

@end
