//
//  YYEmbedURLViewController.m
//  Wuya
//
//  Created by Lixiang on 14-6-26.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYEmbedURLViewController.h"
#import "Reachability.h"
#import "SVProgressHUD.h"
#import "DDTActionSheet.h"

#import "YYShareActivityView.h"

#import "AFNetworkReachabilityManager.h"

#define kDDEmbedURL_DefaultTitle           _(@"知产通")

@interface YYEmbedURLViewController () <UIWebViewDelegate>

@property (nonatomic, strong) NSString *webPageTitle;
@property (nonatomic, strong) NSString *shareTitle;
@property (nonatomic, strong) NSString *shareDesc;
@property (nonatomic, strong) NSString *urlString;
@end

@implementation YYEmbedURLViewController

#pragma mark -
#pragma mark Initialization

- (void)dealloc {
    if (self.webView) {
        self.webView.delegate = nil;
    }
}

- (void)initSettings {
    [super initSettings];
    
    self.tableSpinnerHidden = YES;
}

#pragma mark -
#pragma mark Navigation

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    if (self.webPageTitle) {
        [self setNaviTitle:self.webPageTitle];
    } else {
        [self setNaviTitle:kDDEmbedURL_DefaultTitle];
    }
    [self setRightBarButtonItem:[UIBarButtonItem barButtonItemWithTitle:@"更多" target:self action:@selector(moreButtonClick:)] animated:YES];
//    [self setRightBarButtonItem:[UIBarButtonItem iconBarbuttonItemWithImage:[UIImage imageNamed:@"post_lightlarge_more_icon"] target:self action:@selector(moreButtonClick:)] animated:animated];
}

#pragma mark -
#pragma mark Observers

- (void)addGlobalNotification {
    [super addGlobalNotification];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadWebView) name:UIApplicationDidBecomeActiveNotification object:nil];
}

#pragma mark -
#pragma mark accessor

- (YYEmbedUrlEmptyView *)emptyView {
    __weak typeof(self)weakSelf = self;
    if (_emptyView == nil) {
        _emptyView = [[YYEmbedUrlEmptyView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
        _emptyView.viewPressedBlock = ^(id userInfo) {
            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:weakSelf.embedURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5]];
        };
    }
    return _emptyView;
}

#pragma mark -
#pragma mark Life Cycle
+ (instancetype)viewControllerWithURLString:(NSString *)urlString {
    return [[YYEmbedURLViewController alloc] initWithURLString:urlString];
}

- (instancetype)initWithURLString:(NSString *)urlString {
    self = [super init];
    if (self) {
        if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
        self.urlString = urlString;
        self.embedURL = [NSURL URLWithString:urlString];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.webView) {
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], [UIDevice screenHeight] - 64)];
        webView.scalesPageToFit = YES;
        webView.opaque = NO;
        webView.backgroundColor = [UIColor clearColor];
        webView.dataDetectorTypes = UIDataDetectorTypeNone;
        
        if ([[webView subviews] count] > 0) {
            for (UIView* shadowView in [[[webView subviews] objectAtIndex:0] subviews]) {
                if([shadowView isKindOfClass:[UIImageView class]]) { shadowView.hidden = YES; }
            }
        }
        [self.view addSubview:webView];
        self.webView = webView;
        self.webView.delegate = self;
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        [UIAlertView postAlertWithMessage:@"当前网络不可用"];
    }
    
    [SVProgressHUD showWithStatus:nil];
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.embedURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:5]];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backButtonItemWithTarget:self action:@selector(cancelButtonPressed:)];
}

- (void)viewDidAppear:(BOOL)animated {
    
    if (!self.isViewLoaded) {
        [self reloadWebView];
    }
    
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [SVProgressHUD dismiss];
    [super viewWillDisappear:animated];
    // TODO: set leftBarItem according to self.presentingViewController
}

#pragma mark -
#pragma mark button
- (void)moreButtonClick:(id)sender {
    NSMutableArray *actionSheetItems = [[NSMutableArray alloc] initWithCapacity:3];

    DDTActionSheetItem *actionSheetItem = nil;
    
//    actionSheetItem = [[DDTActionSheetItem alloc] init];
//    actionSheetItem.buttonTitle = _(@"分享");
//    actionSheetItem.selector = @selector(shareWithInfo:);
//    actionSheetItem.userInfo = nil;
//    [actionSheetItems addObject:actionSheetItem];
//    actionSheetItem = nil;
    
    actionSheetItem = [[DDTActionSheetItem alloc] init];
    actionSheetItem.buttonTitle = _(@"刷新");
    actionSheetItem.selector = @selector(refreshWithInfo:);
    actionSheetItem.userInfo = nil;
    [actionSheetItems addObject:actionSheetItem];
    actionSheetItem = nil;
    
    [actionSheetItems addObject:[DDTActionSheetItem cancelActionSheetItem]];
    
    DDTActionSheet *actionSheet = [[DDTActionSheet alloc] initWithTitle:nil ActionSheetItems:actionSheetItems];

    actionSheet.lbDelegate = self;
    [actionSheet showInView:self.navigationController.view];
}

#pragma mark -
#pragma mark ActionSheet
- (void)shareWithInfo:(NSDictionary *)dict {
    UIImage *shareImage = [UIImage imageNamed:@"icon_qq"];
    UIImage *weiboImage = [UIImage imageNamed:@"icon_qq"];
    YYShareActivityView *shareActivity = [YYShareActivityView baseShareWithTitle:self.shareTitle desc:self.shareDesc url:self.urlString thumbImage:shareImage image:weiboImage];
    [shareActivity showInView:self.navigationController.view];
}

- (void)refreshWithInfo:(NSDictionary *)dict {
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.embedURL]];
}

#pragma mark -
#pragma mark Logic

- (void)setViewControllerTitleFromWebView:(UIWebView *)webView {
    NSString *webPageTitle=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.webPageTitle = webPageTitle;
    [self updateNavigationBar:NO];
}

- (void)reloadWebView {
    [SVProgressHUD showWithStatus:nil];
    [self.webView reload];
}

#pragma mark -
#pragma mark Navigation Button Actions
- (void)cancelButtonPressed:(id)sender {
    if (self.presentingViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark -
#pragma mark UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [SVProgressHUD dismiss];
    
    [self setViewControllerTitleFromWebView:webView];
    self.navigationItem.rightBarButtonItem.enabled = YES;
    
    // Disable user selection
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    // TODO: for more logical

    NSLog(@"%@,\n%@,\n%@,\n%@,\n%@,",request.URL.scheme, request.URL.absoluteString, request.URL.query, request.URL.relativePath, request.URL.parameterString);
    NSMutableDictionary *dict = [self getDictFromStr:request.URL.query];
    
    if ([dict objectForSafeKey:@"shareTitle"]) {
        self.shareTitle = [[dict objectForSafeKey:@"shareTitle"] decodeString:[dict objectForSafeKey:@"shareTitle"]];
    }
    
    if ([dict objectForSafeKey:@"shareDesc"]) {
        self.shareDesc = [[dict objectForSafeKey:@"shareDesc"] decodeString:[dict objectForSafeKey:@"shareDesc"]];
    }
    
    if (request.URL.relativePath && [request.URL.relativePath rangeOfString:@"share"].location != NSNotFound) {
        YYShareActivityView *shareActivity = [YYShareActivityView defaultInviteWithStatPrefix:@"share crow"];
        [shareActivity showInView:self.navigationController.view];
        return NO;
    }
    else
    if (request.URL.absoluteString && [request.URL.absoluteString rangeOfString:@"closesmartview"].location != NSNotFound) {
        [self performSelector:@selector(cancelButtonPressed:) withObject:nil afterDelay:0.5];
        return NO;
    }
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [SVProgressHUD dismiss];
    [self.view addSubview:self.emptyView];
}

#pragma mark -
#pragma mark Other logical

- (NSMutableDictionary *)getDictFromStr:(NSString *)origin {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    NSArray *array = [origin componentsSeparatedByString:@"&"];
    
    for (NSString *item in array) {
        NSArray *temp = [item componentsSeparatedByString:@"="];
        if (temp.count > 1) {
            NSString *key = [temp objectAtIndex:0];
            NSString *value = [temp objectAtIndex:1];
            [dict setObject:value forKey:key];
        }
    }
    return dict;
}


@end
