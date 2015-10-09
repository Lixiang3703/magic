//
//  KKRegisterViewController.m
//  Link
//
//  Created by Lixiang on 14/11/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKRegisterViewController.h"

#import "KKRegisterEULAViewController.h"

#import "KKLoginManager.h"
#import "KKAccountItem.h"

@interface KKRegisterViewController ()
@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) YYLoginBgView *mobileTextFieldBgImageView;
@property (nonatomic, strong) YYLoginBgView *mobileCodeTextFieldBgImageView;

@property (nonatomic, strong) YYLoginBgView *nameTextFieldBgImageView;
@property (nonatomic, strong) YYLoginBgView *companyTextFieldBgImageView;
@property (nonatomic, strong) YYLoginBgView *passwordTextFieldBgImageView;
@property (nonatomic, strong) YYLoginBgView *repeatPasswordTextFieldBgImageView;

@property (nonatomic, strong) YYLoginTextField *mobileTextField;
@property (nonatomic, strong) YYLoginTextField *mobileCodeTextField;
@property (nonatomic, strong) YYLoginTextField *nameTextField;
@property (nonatomic, strong) YYLoginTextField *companyTextField;
@property (nonatomic, strong) YYLoginTextField *passwordTextField;
@property (nonatomic, strong) YYLoginTextField *repeatPasswordTextField;

@property (nonatomic, strong) UIButton *mobileCodeButton;
@property (nonatomic, strong) UIButton *submitButton;
@property (nonatomic, strong) UIButton *bottomSmallButton;

@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSUInteger countDownNumber;

@end

@implementation KKRegisterViewController

- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -
#pragma mark Initialization

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
    
    [self initCountDownNumber];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)initCountDownNumber {
    self.countDownNumber = 90;
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setTitle:_(@"注册")];
}

#pragma mark -
#pragma mark Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    __weak __typeof(self) weakSelf = self;
    //  Container
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.containerView fullfillPrarentView];
    
    CGFloat codeButtonWidth = 120;
    
    //  Mobile
    self.mobileTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:CGRectMake(0, kUI_Login_Common_Margin, self.view.width, kUI_Login_Common_Button_Height)];
    
    
    self.mobileTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_Login_TextField_Left, 0, self.mobileTextFieldBgImageView.width - 2 * kUI_Login_TextField_Left, kUI_Login_Common_Button_Height)];
    self.mobileTextField.delegate = self;
    self.mobileTextField.placeholder = _(@"请填写手机号");
    self.mobileTextField.keyboardType = UIKeyboardTypePhonePad;
    self.mobileTextField.returnKeyType = UIReturnKeyNext;
    self.mobileTextField.becomeFirstResponderBlock = ^{
        [weakSelf keyboardOffsetToBottom];
    };
    
    [self.mobileTextFieldBgImageView addSubview:self.mobileTextField];
    
    //  Code
    self.mobileCodeTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:self.mobileTextFieldBgImageView.frame];
    self.mobileCodeTextFieldBgImageView.top = self.mobileTextFieldBgImageView.bottom;
    self.mobileCodeTextFieldBgImageView.topLineHidden = YES;
    
    self.mobileCodeTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_Login_TextField_Left, 0, self.mobileCodeTextFieldBgImageView.width - 2 * kUI_Login_TextField_Left, kUI_Login_Common_Button_Height)];
    self.mobileCodeTextField.delegate = self;
    self.mobileCodeTextField.rightViewMode = UITextFieldViewModeNever;
    self.mobileCodeTextField.placeholder = _(@"请输入验证码");
    self.mobileCodeTextField.keyboardType = UIKeyboardTypePhonePad;
    self.mobileCodeTextField.returnKeyType = UIReturnKeyNext;
    self.mobileCodeTextField.becomeFirstResponderBlock = ^{
        [weakSelf keyboardOffsetToBottom];
    };
    
    [self.mobileCodeTextFieldBgImageView addSubview:self.mobileCodeTextField];
    
    self.mobileCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.mobileCodeTextFieldBgImageView.right - kUI_TableView_Common_Margin - codeButtonWidth, self.mobileCodeTextFieldBgImageView.top + kUI_TableView_Common_MarginS, codeButtonWidth, kUI_Login_Button_Height)];
    self.mobileCodeButton.enabled = YES;
    [self.mobileCodeButton setThemeUIType:kThemeBasicButton_White16];
    self.mobileCodeButton.backgroundColor = [UIColor KKButtonColor];
    self.mobileCodeButton.layer.cornerRadius = kUI_Common_Radius;
    [self.mobileCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [self.mobileCodeButton addTarget:self action:@selector(mobileCodeButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // name
    self.nameTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:self.mobileTextFieldBgImageView.frame];
    self.nameTextFieldBgImageView.top = self.mobileCodeTextFieldBgImageView.bottom + kUI_Login_Common_Margin;
    self.nameTextFieldBgImageView.topLineHidden = YES;
    
    self.nameTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_Login_TextField_Left, 0, self.nameTextFieldBgImageView.width - 2 * kUI_Login_TextField_Left, kUI_Login_Common_Button_Height)];
    self.nameTextField.delegate = self;
    self.nameTextField.placeholder = _(@"输入真实姓名");
    self.nameTextField.returnKeyType = UIReturnKeyDone;
    self.nameTextField.becomeFirstResponderBlock = ^{
        [weakSelf keyboardOffsetToTop];
    };
    
    // company
    self.companyTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:self.mobileTextFieldBgImageView.frame];
    self.companyTextFieldBgImageView.top = self.nameTextFieldBgImageView.bottom;
    self.companyTextFieldBgImageView.topLineHidden = YES;
    
    self.companyTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_Login_TextField_Left, 0, self.nameTextFieldBgImageView.width - 2 * kUI_Login_TextField_Left, kUI_Login_Common_Button_Height)];
    self.companyTextField.delegate = self;
    self.companyTextField.placeholder = _(@"输入公司名称(选填)");
    self.companyTextField.returnKeyType = UIReturnKeyDone;
    self.companyTextField.becomeFirstResponderBlock = ^{
        [weakSelf keyboardOffsetToTop];
    };
    
    //  Password
    self.passwordTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:self.mobileTextFieldBgImageView.frame];
    self.passwordTextFieldBgImageView.top = self.companyTextFieldBgImageView.bottom + kUI_Login_Common_Margin;
    self.passwordTextFieldBgImageView.topLineHidden = YES;
    
    self.passwordTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_Login_TextField_Left, 0, self.passwordTextFieldBgImageView.width - 2 * kUI_Login_TextField_Left, kUI_Login_Common_Button_Height)];
    self.passwordTextField.delegate = self;
    self.passwordTextField.placeholder = _(@"设置密码，不少于6位");
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    self.passwordTextField.becomeFirstResponderBlock = ^{
        [weakSelf keyboardOffsetToTop];
    };
    
    // repeat password
    self.repeatPasswordTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:self.passwordTextFieldBgImageView.frame];
    self.repeatPasswordTextFieldBgImageView.top = self.passwordTextFieldBgImageView.bottom;
    self.repeatPasswordTextFieldBgImageView.topLineHidden = YES;
    
    self.repeatPasswordTextField = [[YYLoginTextField alloc] initWithFrame:self.passwordTextField.frame];
    self.repeatPasswordTextField.delegate = self;
    self.repeatPasswordTextField.placeholder = _(@"再次输入密码");
    self.repeatPasswordTextField.secureTextEntry = YES;
    self.repeatPasswordTextField.returnKeyType = UIReturnKeyDone;
    self.repeatPasswordTextField.becomeFirstResponderBlock = ^{
        [weakSelf keyboardOffsetToTop];
    };
    

    [self.nameTextFieldBgImageView addSubview:self.nameTextField];
    [self.companyTextFieldBgImageView addSubview:self.companyTextField];
    [self.passwordTextFieldBgImageView addSubview:self.passwordTextField];
    [self.repeatPasswordTextFieldBgImageView addSubview:self.repeatPasswordTextField];
    
    //  Submit
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(roundf((self.view.width - kUI_Login_Button_Width) / 2), self.self.repeatPasswordTextFieldBgImageView.bottom  + kUI_Login_Common_Margin, kUI_Login_Button_Width, kUI_Login_Button_Height)];
    self.submitButton.enabled = NO;
    [self.submitButton setThemeUIType:kThemeBasicButton_White16];
    [self.submitButton setBackgroundColor:[UIColor KKButtonColor]];
    self.submitButton.layer.cornerRadius = kUI_Common_Radius;
    [self.submitButton setTitle:_(@"提  交") forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bottomSmallButton = [[UIButton alloc] initWithFrame:CGRectMake(([UIDevice screenWidth] - 66)/2, self.submitButton.bottom + 10, 66, 18)];
    self.bottomSmallButton.hitTestEdgeInsets = UIEdgeInsetsMake(-10, -20, -10, -20);
    [self.bottomSmallButton setThemeUIType:kThemeCommonBorderlessButton];
    [self.bottomSmallButton setTitle:_(@"用户协议?") forState:UIControlStateNormal];
    [self.bottomSmallButton addTarget:self action:@selector(bottomSmallButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.bottomSmallButton.left, self.bottomSmallButton.bottom, self.bottomSmallButton.width, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    
    [self.containerView addSubview:self.mobileTextFieldBgImageView];
    [self.containerView addSubview:self.mobileCodeTextFieldBgImageView];
    [self.containerView addSubview:self.mobileCodeButton];
    [self.containerView addSubview:self.nameTextFieldBgImageView];
    [self.containerView addSubview:self.companyTextFieldBgImageView];
    [self.containerView addSubview:self.passwordTextFieldBgImageView];
    [self.containerView addSubview:self.repeatPasswordTextFieldBgImageView];
    [self.containerView addSubview:self.submitButton];
    [self.containerView addSubview:self.bottomSmallButton];
    [self.containerView addSubview:lineView];
    
    [self.view addSubview:self.containerView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.passwordTextField isFirstResponder]){
        [self.repeatPasswordTextField becomeFirstResponder];
        [self keyboardOffsetToTop];
        
    } else if ([self.repeatPasswordTextField isFirstResponder]){
        [self.repeatPasswordTextField resignFirstResponder];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    if (textField == self.mobileTextField) {
        self.mobileCodeButton.enabled = NO;
    }
    self.submitButton.enabled = NO;
    return YES;
}

#pragma mark -
#pragma mark  UITextFieldTextDidChangeNotification

- (void)textFieldTextDidChange:(NSNotification *)notification{
    if (notification.object == self.mobileTextField) {
        self.mobileCodeButton.enabled = [self.mobileTextField hasContent];
    }
    
    BOOL enable = [self.mobileTextField hasContent] && [self.mobileCodeTextField hasContent] && [self.passwordTextField hasContent] && [self.repeatPasswordTextField hasContent];
    
    self.submitButton.enabled = enable;
}


#pragma mark -
#pragma mark Buttons

- (void)bottomSmallButtonPressed:(id)sender {
    KKRegisterEULAViewController *viewController = [[KKRegisterEULAViewController alloc] init];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)mobileCodeButtonPressed:(id)sender {
    //  Validation
    NSString *mobile = [self.mobileTextField textTrimed];
    if (![mobile hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入手机号")];
        [self.mobileTextField becomeFirstResponder];
        return;
    }
    
    NSString *mobileNumber = [self.mobileTextField textTrimed];
    if (mobileNumber.length != 11) {
        [UIAlertView postAlertWithMessage:_(@"请输入11位手机号")];
        [self.mobileTextField becomeFirstResponder];
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    
    [[KKLoginManager getInstance] handleLoginStatus:KKLoginStatusRegisterSendMobileVerifyCode prepareBlock:^(KKLoginItem *loginItem) {
        loginItem.mobile = mobile;
    } successBlock:^(KKLoginItem *loginItem) {
        weakSelf.mobileCodeButton.enabled = NO;
        [weakSelf startTimer];
        [UIAlertView postAlertWithMessage:_(@"发送成功")];
    } failBlock:^(NSError *error, KKLoginItem *loginItem) {
        
//        weakSelf.mobileCodeButton.enabled = NO;
//        [weakSelf startTimer];
        [UIAlertView postAlertWithMessage:_(@"发送失败")];
        [UIAlertView HUDAlertDismiss];
    }];

}

- (void)submitButtonPressed:(id)sender {
    
    //  Validation
    NSString *mobile = [self.mobileTextField textTrimed];
    if (![mobile hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入手机号")];
        [self.mobileTextField becomeFirstResponder];
        return;
    }
    
    NSString *mobileCode = [self.mobileCodeTextField textTrimed];
    if (![mobileCode hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入验证码")];
        [self.mobileTextField becomeFirstResponder];
        return;
    }
    
    NSString *name = [self.nameTextField textTrimed];
    if (![name hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入昵称")];
        [self.nameTextField becomeFirstResponder];
        return;
    }
    
    NSString *password = [self.passwordTextField textTrimed];
    if (![password hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入密码")];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    if (password.length < 6) {
        [UIAlertView postAlertWithMessage:_(@"密码不少于6位")];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    NSString *repeatPassword = [self.repeatPasswordTextField textTrimed];
    if (![repeatPassword hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请再次输入密码")];
        [self.repeatPasswordTextField becomeFirstResponder];
        return;
    }
    if (![repeatPassword isEqualToString:password]) {
        [UIAlertView postAlertWithMessage:_(@"两次输入的密码不一致")];
        [self.repeatPasswordTextField becomeFirstResponder];
        return;
    }
    NSString *company = [self.companyTextField textTrimed];
    
    [self.mobileTextField resignFirstResponder];
    [self.mobileCodeTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
    
    [UIAlertView postHUDAlertWithMessage:nil];
    __weak __typeof(self) weakSelf = self;
    
    [[KKLoginManager getInstance] handleLoginStatus:KKLoginStatusRegister prepareBlock:^(KKLoginItem *loginItem) {
        loginItem.mobile = mobile;
        loginItem.personItem.name = name;
        loginItem.personItem.company = company;
        loginItem.password = [password stringForLinkMd5];
        loginItem.mobileCode = mobileCode;
    } successBlock:^(KKLoginItem *loginItem) {
        [UIAlertView HUDAlertDismiss];
        [UIAlertView postAlertWithMessage:_(@"注册成功")];
        [weakSelf.navigationController popViewControllerAnimated:NO];
    } failBlock:^(NSError *error, KKLoginItem *loginItem) {
        [UIAlertView postAlertWithMessage:_(@"注册失败")];
        [UIAlertView HUDAlertDismiss];
    }];
    
}

#pragma mark -
#pragma mark Timer

- (void)startTimer {
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
    [self initCountDownNumber];
    [self.mobileCodeButton setTitle:self.resendButtonTitle forState:UIControlStateDisabled];
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateResendButtonTitleForCountDown) userInfo:nil repeats:YES];
}

- (void)updateResendButtonTitleForCountDown {
    self.countDownNumber --;
    if (self.countDownNumber <= 0) {
        [self.countDownTimer invalidate];
        self.countDownTimer = nil;
        self.mobileCodeButton.enabled = YES;
        return;
    }
    [self.mobileCodeButton setTitle:self.resendButtonTitle forState:UIControlStateDisabled];
}

- (NSString *)resendButtonTitle {
    return [NSString stringWithFormat:_(@"重新发送(%d)"), self.countDownNumber];
}

#pragma mark -
#pragma mark  Notification

- (void)keyboardOffsetToTop{
    CGFloat offSet = self.view.height - self.submitButton.bottom - kUI_Keyboard_Height;
    if (offSet < 0) {
        [UIView animateWithDuration:0.25 animations:^{
            self.containerView.top = offSet;
        } completion:nil];
    }
}

- (void)keyboardOffsetToBottom{
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.top = 0;
    } completion:nil];
}


- (void)keyboardWillShow:(NSNotification *)notification{
    
    if ([self.passwordTextField isFirstResponder] || [self.repeatPasswordTextField isFirstResponder]){
        [self keyboardOffsetToTop];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification{
    [self keyboardOffsetToBottom];
}


@end
