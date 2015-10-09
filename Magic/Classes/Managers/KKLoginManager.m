//
//  KKLoginManager.m
//  Link
//
//  Created by Lixiang on 14/11/11.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKLoginManager.h"
#import "WSManager.h"
#import "WSDownloadCache.h"

#import "KKAccountItem.h"

#import "KKBaseLoginRequestModel.h"
#import "KKLogoutRequestModel.h"

#import "KKLoginViewController.h"
#import "YYNavigationController.h"

@interface KKLoginManager()

@property (nonatomic, strong) NSArray *statusLogics;

@end

@implementation KKLoginManager

SYNTHESIZE_SINGLETON_FOR_CLASS(KKLoginManager);

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Accessors

- (KKLoginItem *)loginItem {
    if (nil == _loginItem) {
        _loginItem = [[KKLoginItem alloc] init];
    }
    return _loginItem;
}

- (KKAccountItem *)accountItem {
    if (nil == _accountItem) {
        _accountItem = [KKAccountItem loadSavedItem];
    }
    return _accountItem;
}

#pragma mark -
#pragma mark Initialization
- (instancetype)init {
    self = [super init];
    if (self) {
        self.statusLogics = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"login" ofType:@"plist"]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wsNeedLoginErrorNotification:) name:kWS_Notification_NeedLogin object:nil];
        
    }
    return self;
}

#pragma mark -
#pragma mark Login Status

- (BOOL)isLoggedIn {
    return [self.accountItem.ticket hasContent];
}

#pragma mark -
#pragma mark Noticiations
- (void)wsNeedLoginErrorNotification:(NSNotification *)notification {
    [self logoutWithForce:NO];
}

- (void)showLoginControllerWithAnimated:(BOOL)animated {
    KKLoginViewController *viewController = [[KKLoginViewController alloc] init];
    
    YYNavigationController *navigationController = [[YYNavigationController alloc] initWithRootViewController:viewController];
    [[UINavigationController appNavigationController] presentViewController:navigationController animated:animated completion:^{
        
    }];
}

- (void)handleLoginStatus:(KKLoginStatus)loginStatus prepareBlock:(KKLoginStatusPrepareBlock)prepareBlock successBlock:(KKLoginStatusSuccessBlock)successBlock failBlock:(KKLoginStatusFailBlock)failBlock {
    
    prepareBlock(self.loginItem);
    
    self.loginStatusPrepareBlock = prepareBlock;
    self.loginStatusSuccessBlock = successBlock;
    self.loginStatusFailBlock = failBlock;
    
//    NSDictionary *info = [self.statusLogics objectAtSafeIndex:loginStatus];
//    NSString *requestName = [info objectForSafeKey:@"request"];
//    NSString *vcName = [info objectForSafeKey:@"vc"];
//    BOOL final = [[info objectForSafeKey:@"final"] boolValue];
    

    NSString *requestName = nil;
    NSString *vcName = nil;
    BOOL final = NO;
    
    switch (loginStatus) {
        case KKLoginStatusLogin:
            requestName = @"KKLoginRequestModel";
            final = YES;
            break;
        case KKLoginStatusRegisterSendMobileVerifyCode:
            requestName = @"KKRegisterCodeRequestModel";
            break;
        case KKLoginStatusRegister:
            requestName = @"KKRegisterRequestModel";
            final = YES;
            break;
        case KKLoginStatusForgetPasswordSendMobileVerifyCode:
            requestName = @"KKPasswordMobileCodeRequestModel";
            break;
        case KKLoginStatusPasswordReset:
            requestName = @"KKPasswordMobileResetRequestModel";
            break;
        case KKLoginStatusChangePassword:
            requestName = @"KKChangePasswordRequestModel";
            break;
        default:
            break;
    }
    
    if (nil != requestName) {
        __weak typeof(self)weakSelf = self;
        
        KKBaseLoginRequestModel *requestModel = [[NSClassFromString(requestName) alloc] init];
        requestModel.loginItem = self.loginItem;
        requestModel.successBlock = ^(id responseObject, NSDictionary *headers,  WSBaseRequestModel *requestModel) {
            
            [weakSelf handleLoginDidSuccessWithViewControllerClassName:vcName final:final];
        };
        requestModel.failBlock = ^(NSError *error, NSDictionary *headers, WSBaseRequestModel *requestModel) {
            if (weakSelf.loginStatusFailBlock) {
                weakSelf.loginStatusFailBlock(error, self.loginItem);
            }
        };
        
        [requestModel load];
        
    } else {
        [self handleLoginDidSuccessWithViewControllerClassName:vcName final:final];
    }
}

- (void)handleLoginDidSuccessWithViewControllerClassName:(NSString *)vcName final:(BOOL)final {
    
    if (self.loginStatusSuccessBlock) {
        self.loginStatusSuccessBlock(self.loginItem);
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginManager_Notification_WillLogIn object:nil];
    
    if (vcName) {
        [[UINavigationController appNavigationController] safePushViewController:[UIViewController viewControllerWithClassName:vcName] animated:YES];
    }
    
    if (final) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kLoginManager_Notification_DidLogIn object:@{@"loginStatus":@(self.loginStatus)}];
    }
    
    [self.loginItem save];
}


- (void)logoutWithForce:(BOOL)force {

    if (![self isLoggedIn]) {
        return;
    }
    
    //  RequestModel WS Manger
    [[WSManager getInstance] reset];
    
    //  Logout Request Model
    if (!force) {
        KKLogoutRequestModel *requestModel = [[KKLogoutRequestModel alloc] init];
        requestModel.successBlock = ^(id responseObject, NSDictionary *headers, id requestModel) {
            //  Pass
        };
        requestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
            //  Pass
        };
        [requestModel load];
    }
    
    //  Clear Cach
    [[WSDownloadCache getInstance] removeAllNonResourceCache];
    
    //  Clear Account and Save
    [self.accountItem clearAndSave];
    
    //  Post Notification
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginManager_Notification_WillLogout object:@{@"force":@(force)}];
    
    // some ui actions...
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginManager_Notification_DidLogout object:@{@"force":@(force)}];
}
@end
