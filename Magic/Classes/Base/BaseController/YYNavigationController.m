//
//  YYNavigationController.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYNavigationController.h"
#import "AppDelegate.h"

@interface YYNavigationController ()

@property (nonatomic, strong) UIView *bottomLineView;

@end

@implementation YYNavigationController




#pragma mark -
#pragma mark Life cycle

- (void)loadView {
    [super loadView];
    
    [self.navigationBar setTranslucent:NO];
    
    [self.navigationBar setShadowImage:[UIImage yyImageWithColor:[UIColor clearColor]]];
    [self.navigationBar setBackgroundImage:[UIImage yyImageWithColor:[UIColor clearColor]] forBarMetrics:UIBarMetricsDefault];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor clearColor];
    shadow.shadowOffset = CGSizeMake(0, 0);
    NSDictionary *_titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                           NSShadowAttributeName : shadow,
                                           NSFontAttributeName : [UIFont boldSystemFontOfSize:19]};
    
    [self.navigationBar setTitleTextAttributes:_titleTextAttributes];
    self.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationBar.barTintColor = [UIColor KKMainColor];
//    self.navigationBar.translucent = YES;
    
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBar.height - 1, self.navigationBar.width, 1)];
    self.bottomLineView.backgroundColor = [UIColor YYMainTabbarTopLineColor];
    [self.navigationBar addSubview:self.bottomLineView];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
//    //  Remove the bottom dark line
//    for (UIView *view in self.navigationBar.subviews) {
//        for (UIView *view2 in view.subviews) {
//            if ([view2 isKindOfClass:[UIImageView class]]) {
//                [view2 removeFromSuperview];
//            }
//        }
//    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
