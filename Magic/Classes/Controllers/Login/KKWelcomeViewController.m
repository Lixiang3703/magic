//
//  YYWelcomeViewController.m
//  Link
//
//  Created by lixiang on 15/3/1.
//  Copyright (c) 2015年 Lixiang. All rights reserved.
//

#import "KKWelcomeViewController.h"
#import "DDPageControl.h"

@interface KKWelcomeViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) DDPageControl *pageControl;
@property (nonatomic, strong) UIButton *doneButton;
@end

@implementation KKWelcomeViewController

#pragma mark -
#pragma mark Initialization
- (void)initSettings {
    [super initSettings];
    
    //  NavigationBar
    self.navigationBarHidden = YES;
    //    self.statusBarHidden = YES;
}

#pragma mark -
#pragma mark Navigation Bar

- (void)updateNavigationBar:(BOOL)animated {
    [super updateNavigationBar:animated];
    
    [self setTitle:kString_PlaceHolderBack];
}

#pragma mark -
#pragma mark Life cycle

- (NSArray *)welcomeImages {
    NSMutableArray *images = [NSMutableArray array];
    for (int i = 1; i <= 4; i++) {
        if ([UIDevice is4InchesScreen]) {
            [images addSafeObject:[UIImage imageNamed:[NSString stringWithFormat:@"welcome_%d", i]]];
        } else {
            [images addSafeObject:[UIImage imageNamed:[NSString stringWithFormat:@"welcome-%d-640-960", i]]];
        }
    }
    
    return images;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //  UI
    self.view.backgroundColor = [UIColor clearColor];
    
    //  ScrollView
    NSArray *images = [self welcomeImages];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height)];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.autoresizesSubviews = YES;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delegate = self;
    
    //  Assign images
    CGFloat x = 0;
    UIImageView *imageView = nil;
    for (UIImage *image in images) {
        imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(x, 0, self.scrollView.width, self.scrollView.height);
        [imageView fullfillPrarentView];
        x += imageView.width;
        [self.scrollView addSubview:imageView];
    }
    
    //  Buttons
    self.doneButton = [[UIButton alloc] initWithFrame:CGRectMake(roundf((self.view.width - kUI_Login_Button_Width) / 2), self.view.height - 23 - kUI_Login_Button_Height, kUI_Login_Button_Width, kUI_Login_Button_Height)];
    self.doneButton.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    self.doneButton.backgroundColor = [UIColor KKRedColor];
    self.doneButton.layer.cornerRadius = kUI_Common_Radius;
    self.doneButton.titleLabel.font = [UIFont boldSystemFontOfSize:16];
    [self.doneButton setTitle:_(@"立即体验") forState:UIControlStateNormal];
    [self.doneButton addTarget:self action:@selector(doneButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //  PageControl
    self.pageControl = [[DDPageControl alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.width, 10) type:DDPageControlTypeBlack];
    self.pageControl.bottom = self.doneButton.top - kUI_Compose_Toolbar_At_Height;
    self.pageControl.pageIndicatorImage = [UIImage imageNamed:@"welcome_control_normal"];
    self.pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"badge_small"];
    self.pageControl.numberOfPages = [images count];
    self.pageControl.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.pageControl];
    [self.view addSubview:self.doneButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.scrollView.contentSize = CGSizeMake(self.scrollView.width * [[self welcomeImages] count], self.scrollView.height);
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger currentPage = (scrollView.contentOffset.x + 160) / 320;
    self.pageControl.currentPage = currentPage;
}

#pragma mark -
#pragma mark Actions

- (void)doneButtonClick:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
