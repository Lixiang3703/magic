//
//  KKLoginViewController.m
//  Link
//
//  Created by Lixiang on 14/11/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKLoginViewController.h"
#import "YYNavigationController.h"
#import "UIAlertView+Blocks.h"

#import "KKForgetPasswordViewController.h"
#import "KKRegisterViewController.h"

#import "KKLoginManager.h"
#import "KKAccountItem.h"

@interface KKLoginViewController ()

@property (nonatomic, strong) YYLoginBgView *mobileBgImageView;
@property (nonatomic, strong) YYLoginBgView *passwordBgImageView;
@property (nonatomic, strong) YYLoginTextField *mobileTextField;
@property (nonatomic, strong) YYLoginTextField *passwordTextField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *forgetPasswordButton;

@end

@implementation KKLoginViewController

#pragma mark -
#pragma mark Initialization

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setTitle:_(@"登录")];
    
    [self setLeftBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"取消") target:self action:@selector(leftBarButtonItemClick:)] animated:animated];
    
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:_(@"注册") target:self action:@selector(rightBarButtonItemClick:)] animated:animated];
}

#pragma mark -
#pragma mark Notification 

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidLogin:) name:kLoginManager_Notification_DidLogIn object:nil];
}

- (void)appDidLogin:(NSNotification *)notification {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark NavigationBar actions

- (void)leftBarButtonItemClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)rightBarButtonItemClick:(id)sender {
    KKRegisterViewController *viewController = [[KKRegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    
    //  TextFields
    self.mobileBgImageView = [[YYLoginBgView alloc] initWithFrame:CGRectMake(0, kUI_Login_Common_Margin, self.view.width, kUI_Login_Common_Button_Height)];
    self.mobileBgImageView.topLineHidden = NO;
    self.mobileBgImageView.bottomLineHidden = NO;
    
    self.mobileTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_Login_TextField_Left, 0, self.mobileBgImageView.width - 2 * kUI_Login_TextField_Left, kUI_Login_Common_Button_Height)];
    self.mobileTextField.delegate = self;
    self.mobileTextField.placeholder = _(@"手机号/邮箱");
    self.mobileTextField.keyboardType = UIKeyboardTypeDefault;
    
    self.mobileTextField.text = [[KKAccountItem sharedItem].mobile isEqualToString:@"unknown"] ? @"" : [KKAccountItem sharedItem].mobile;
    
//    self.mobileTextField.text = @"lixiang3703@gmail.com";
    
    self.mobileTextField.returnKeyType = UIReturnKeyNext;
    
    self.passwordBgImageView = [[YYLoginBgView alloc] initWithFrame:self.mobileBgImageView.frame];
    self.passwordBgImageView.topLineHidden = YES;
    self.passwordBgImageView.bottomLineHidden = NO;
    self.passwordBgImageView.top = self.mobileBgImageView.bottom;
    
    self.passwordTextField = [[YYLoginTextField alloc] initWithFrame:self.mobileTextField.frame];
    self.passwordTextField.delegate = self;
    self.passwordTextField.placeholder = _(@"密码");
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyDone;
    
    [self.mobileBgImageView addSubview:self.mobileTextField];
    [self.passwordBgImageView addSubview:self.passwordTextField];
    
    //  Buttons
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake(roundf((self.view.width - kUI_Login_Button_Width) / 2), kUI_Login_Button_Top, kUI_Login_Button_Width, kUI_Login_Button_Height)];
    [self.loginButton setThemeUIType:kThemeBasicButton_White16];
    self.loginButton.backgroundColor = [UIColor KKButtonColor];
    self.loginButton.layer.cornerRadius = kUI_Common_Radius;
    self.loginButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.loginButton setTitle:_(@"登  录") forState:UIControlStateNormal];
    [self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetPasswordButton = [[UIButton alloc] initWithFrame:CGRectMake(([UIDevice screenWidth] - 66)/2, self.loginButton.bottom + 10, 66, 18)];
    self.forgetPasswordButton.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
    [self.forgetPasswordButton setThemeUIType:kThemeCommonBorderlessButton];
    [self.forgetPasswordButton setTitle:_(@"忘记密码?") forState:UIControlStateNormal];
    [self.forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.forgetPasswordButton.left, self.forgetPasswordButton.bottom, self.forgetPasswordButton.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.mobileBgImageView];
    [self.view addSubview:self.passwordBgImageView];
    [self.view addSubview:self.loginButton];
    [self.view addSubview:self.forgetPasswordButton];
    [self.view addSubview:lineView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.mobileTextField) {
        [self.passwordTextField becomeFirstResponder];
    } else if (textField == self.passwordTextField) {
        [self loginButtonPressed:nil];
    }
    
    return YES;
}

#pragma mark -
#pragma mark Buttons

- (void)loginButtonPressed:(id)sender {
    
    [self.mobileTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    
    
    //  Validation
    NSString *mobile = [self.mobileTextField textTrimed];
    if (![mobile hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入手机号或者邮箱")];
        [self.mobileTextField becomeFirstResponder];
        return;
    }
    
    NSString *password = [self.passwordTextField textTrimed];
    if (![password hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入密码")];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    [UIAlertView postHUDAlertWithMessage:nil];
    
    [[KKLoginManager getInstance] handleLoginStatus:KKLoginStatusLogin prepareBlock:^(KKLoginItem *loginItem) {
        
        loginItem.mobile = mobile;
        loginItem.password = [password stringForLinkMd5];
        NSLog(@"loginItem.password:%@",loginItem.password);
        
    } successBlock:^(KKLoginItem *loginItem) {
        [UIAlertView HUDAlertDismiss];
        [UIAlertView postAlertWithMessage:_(@"登录成功")];
        
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
        
    
    } failBlock:^(NSError *error, KKLoginItem *loginItem) {
        [weakSelf.passwordTextField becomeFirstResponder];
        [UIAlertView HUDAlertDismiss];
    }];

}

- (void)registerButtonClick:(id)sender {
    KKRegisterViewController *viewController = [[KKRegisterViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)forgetPasswordButtonPressed:(id)sender {
    KKForgetPasswordViewController *viewController = [[KKForgetPasswordViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
