//
//  KKChangePasswordViewController.m
//  Link
//
//  Created by lixiang on 15/1/21.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKChangePasswordViewController.h"
#import "KKLoginManager.h"

#import "KKUserUpdatePasswordRequestModel.h"

#import "KKCommonGlobal.h"
#import "KKUserInfoItem.h"

#define kInitialContainerViewTopInvalid      (-500)
#define kContainerViewFloatHeight            (50)
#define kAnimationDuration                   (0.3)

@interface KKChangePasswordViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;


@property (nonatomic, strong) YYLoginBgView *currentPsdTextFieldBgImageView;
@property (nonatomic, strong) YYLoginBgView *passwordTextFieldBgImageView;

@property (nonatomic, strong) YYLoginTextField *passwordTextField;
@property (nonatomic, strong) YYLoginTextField *nPasswordTextField;
@property (nonatomic, strong) YYLoginTextField *repeatPasswordTextField;

@property (nonatomic, strong) UIButton *mobileCodeButton;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) NSTimer *countDownTimer;
@property (nonatomic, assign) NSUInteger countDownNumber;

@property (nonatomic, assign) CGFloat originContainerTop;
@property (nonatomic, assign) CGFloat floatContainerTop;

@property (nonatomic, strong) KKUserUpdatePasswordRequestModel *changeRequestModel;

@end

@implementation KKChangePasswordViewController

#pragma mark -
#pragma mark Accessor

- (KKUserUpdatePasswordRequestModel *)changeRequestModel {
    if (_changeRequestModel == nil) {
        _changeRequestModel = [[KKUserUpdatePasswordRequestModel alloc] init];
    }
    return _changeRequestModel;
}

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
    
    [self setTitle:_(@"修改密码")];
}

#pragma mark -
#pragma mark Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    
    //  Container
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.backgroundColor = [UIColor clearColor];
    [self.containerView fullfillPrarentView];
    
    //  Mobile
    self.currentPsdTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:CGRectMake(kUI_Login_Common_Margin, kUI_Login_Common_Margin, self.view.width - 2 * kUI_Login_Common_Margin, kUI_Login_Common_Button_Height)];
    
    self.passwordTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, 0, self.currentPsdTextFieldBgImageView.width - 2 * kUI_TableView_Common_Margin, kUI_Login_Common_Button_Height)];
    self.passwordTextField.delegate = self;
    self.passwordTextField.placeholder = _(@"请输入当前密码");
    self.passwordTextField.secureTextEntry = YES;
    self.passwordTextField.returnKeyType = UIReturnKeyNext;
    
    [self.currentPsdTextFieldBgImageView addSubview:self.passwordTextField];
    
    //  Password
    self.passwordTextFieldBgImageView = [[YYLoginBgView alloc] initWithFrame:CGRectMake(kUI_Login_Common_Margin, self.currentPsdTextFieldBgImageView.bottom + kUI_TableView_Common_Margin, self.view.width - 2 * kUI_Login_Common_Margin, 2 * kUI_Login_Common_Button_Height)];
    
    self.nPasswordTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, 0, self.passwordTextFieldBgImageView.width - 2 * kUI_TableView_Common_Margin, kUI_Login_Common_Button_Height)];
    self.nPasswordTextField.delegate = self;
    self.nPasswordTextField.placeholder = _(@"设置新密码，不少于6位");
    self.nPasswordTextField.secureTextEntry = YES;
    self.nPasswordTextField.returnKeyType = UIReturnKeyNext;
    
    self.repeatPasswordTextField = [[YYLoginTextField alloc] initWithFrame:CGRectMake(kUI_TableView_Common_Margin, kUI_Login_Common_Button_Height, self.passwordTextFieldBgImageView.width - 2 * kUI_TableView_Common_Margin, kUI_Login_Common_Button_Height)];
    self.repeatPasswordTextField.delegate = self;
    self.repeatPasswordTextField.placeholder = _(@"再次输入新密码");
    self.repeatPasswordTextField.secureTextEntry = YES;
    self.repeatPasswordTextField.returnKeyType = UIReturnKeyDone;
    
    UIView *seperatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.passwordTextField.bottom, self.passwordTextFieldBgImageView.width, 1)];
    seperatorLineView.backgroundColor = [UIColor YYLineColor];
    
    [self.passwordTextFieldBgImageView addSubview:seperatorLineView];
    [self.passwordTextFieldBgImageView addSubview:self.nPasswordTextField];
    [self.passwordTextFieldBgImageView addSubview:self.repeatPasswordTextField];
    
    //  Submit
    self.submitButton = [[UIButton alloc] initWithFrame:CGRectMake(roundf((self.view.width - kUI_Login_Button_Width) / 2), self.passwordTextFieldBgImageView.bottom + kUI_Login_Common_Margin, kUI_Login_Button_Width, kUI_Login_Button_Height)];
    self.submitButton.enabled = NO;
    [self.submitButton setThemeUIType:kThemeBasicButton_White16];
    self.submitButton.backgroundColor = [UIColor KKButtonColor];
    self.submitButton.layer.cornerRadius = kUI_Common_Radius;
    [self.submitButton setTitle:_(@"提  交") forState:UIControlStateNormal];
    
    [self.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.containerView addSubview:self.currentPsdTextFieldBgImageView];
    
    [self.containerView addSubview:self.mobileCodeButton];
    [self.containerView addSubview:self.passwordTextFieldBgImageView];
    [self.containerView addSubview:self.submitButton];
    
    [self.view addSubview:self.containerView];
    
    self.originContainerTop = self.containerView.top;
    self.floatContainerTop = self.containerView.top - kContainerViewFloatHeight;
    
    self.panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(gesture:)];
    [self.view addGestureRecognizer:self.panGestureRecognizer];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}


#pragma mark -
#pragma mark Gesture
- (void)gesture:(UIGestureRecognizer *)gesture {
    UITextField *textField = (UITextField *)[self.view.window findFirstResponder];
    if ([textField isKindOfClass:[UITextField class]]) {
        [textField resignFirstResponder];
    }
}


#pragma mark -
#pragma mark Notifications
- (void)addViewAppearNotification {
    [super addViewAppearNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldTextDidChangeNotification:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

#pragma mark -
#pragma mark UIWindow Keyboard Notifications
- (void)keyboardWillShow:(NSNotification *)notification {
    [self changeContainerViewTop:kInitialContainerViewTopInvalid];
}

- (void)keyboardDidShow:(NSNotification *)notification {
    
}

- (void)keyboardWillHide:(NSNotification *)notification {
    [self changeContainerViewTop:self.originContainerTop];
}

- (void)changeContainerViewTop:(CGFloat)initialTop {
    CGFloat top = self.containerView.top;
    if (initialTop > kInitialContainerViewTopInvalid) {
        top = initialTop;
    }
    else {
        if ([self.passwordTextField isFirstResponder]) {
            top = self.originContainerTop;
        }
        else
            if ([self.nPasswordTextField isFirstResponder]) {
                top = self.floatContainerTop + 20;
            }
            else if ([self.repeatPasswordTextField isFirstResponder])
            {
                top = self.floatContainerTop;
            }
    }
    
    if (self.containerView.top != top) {
        [UIView animateWithDuration:kAnimationDuration delay:0 options:YES animations:^{
            self.containerView.top = top;
        } completion:^(BOOL finished) {
        }];
    }
    
}

#pragma mark -
#pragma mark Buttons
- (void)submitButtonPressed:(id)sender {
    
    [self.passwordTextField resignFirstResponder];
    [self.nPasswordTextField resignFirstResponder];
    [self.repeatPasswordTextField resignFirstResponder];
    
    //  Validation
    
    __block NSString *password = self.passwordTextField.text;
    if (![password hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入旧密码")];
        [self.passwordTextField becomeFirstResponder];
        return;
    }
    
    NSString *newPassword = self.nPasswordTextField.text;
    if (![newPassword hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请输入新密码")];
        [self.nPasswordTextField becomeFirstResponder];
        return;
    }
    
    if (newPassword.length < 6) {
        [UIAlertView postAlertWithMessage:_(@"密码不少于6位")];
        [self.nPasswordTextField becomeFirstResponder];
        return;
    }
    
    NSString *repeatPassword = [self.repeatPasswordTextField textTrimed];
    if (![repeatPassword hasContent]) {
        [UIAlertView postAlertWithMessage:_(@"请再次输入密码")];
        [self.repeatPasswordTextField becomeFirstResponder];
        return;
    }
    if (![repeatPassword isEqualToString:newPassword]) {
        [UIAlertView postAlertWithMessage:_(@"两次输入的密码不一致")];
        [self.repeatPasswordTextField becomeFirstResponder];
        return;
    }
    
    self.changeRequestModel.currentPassword = [password stringForLinkMd5];
    self.changeRequestModel.password = [newPassword stringForLinkMd5];
    self.changeRequestModel.personItem = [KKUserInfoItem sharedItem].personItem;;
    
    __weak __typeof(self)weakSelf = self;
    self.changeRequestModel.successBlock = ^(id responseObject, NSDictionary *headers,  id requestModel) {
        [weakSelf.nPasswordTextField resignFirstResponder];
        [weakSelf.passwordTextField resignFirstResponder];
        [UIAlertView postAlertWithMessage:_(@"密码修改成功")];
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    
    self.changeRequestModel.failBlock = ^(NSError *error, NSDictionary *headers, id requestModel) {
        NSString *detail = [error.userInfo objectForSafeKey:@"detail"];
        [UIAlertView postAlertWithMessage:detail];
    };
    
    [self.changeRequestModel load];
}


#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.repeatPasswordTextField isFirstResponder]) {
        [self.repeatPasswordTextField resignFirstResponder];
    }
    
    if ([self.nPasswordTextField isFirstResponder]) {
        [self.repeatPasswordTextField becomeFirstResponder];
    }
    
    if ([self.passwordTextField isFirstResponder]) {
        [self.passwordTextField resignFirstResponder];
        [self.nPasswordTextField becomeFirstResponder];
    }
    
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.submitButton.enabled = NO;
    return YES;
}

- (void)textFieldTextDidChangeNotification:(NSNotification *)notification{
    BOOL enable = self.passwordTextField.text.length > 0 && [self.nPasswordTextField hasContent] && [self.repeatPasswordTextField hasContent];
    self.submitButton.enabled = enable;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    [self changeContainerViewTop:kInitialContainerViewTopInvalid];
}


@end
