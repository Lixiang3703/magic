//
//  YYShareActivityView.m
//  YYActionView
//
//  Created by lilingang on 14-7-15.
//  Copyright (c) 2014年 lilingang. All rights reserved.
//

#import "YYShareActivityView.h"
#import "YYPageControl.h"
#import "DDCustomLayoutButton.h"

#import "DDShareCenter.h"
#import "KKShareManager.h"

#define kDefaultHorizontalMargin    (35)    //默认水平边距
#define kDefaultVerticalMargin      (10)    //默认垂直边距
#define kDefaultCountPerRow         (3)     //默认一行有3个item
#define kDefaultRowPerPage          (2)     //默认一页有两行

#define kTagOffSet          (100)

#define kNameLabelHeight    (30)
#define kPageControlheight  (15)
#define kCancelButtonHeight (44)
#define kUISpacing          (10)

@interface YYShareActivityView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIView *backGroundView;

@property (nonatomic, strong) UIView *containerView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIScrollView *myScrollView;

@property (nonatomic, strong) YYPageControl *pageControl;

@property (nonatomic, strong) UIButton *cancelButton;


@property (nonatomic, strong) NSArray *shareItems;

@property (nonatomic, copy) NSString *titleName;

@property (nonatomic, assign) CGFloat horizontalMargin;  //水平间距
@property (nonatomic, assign) CGFloat horizontalSpacing; //水平空隙
@property (nonatomic, assign) CGFloat verticalMargin;    //垂直空隙
@property (nonatomic, assign) CGFloat verticalSpacing;   //垂直间距

@property (nonatomic, assign) NSUInteger maxCountPerRow;
@property (nonatomic, assign) NSUInteger maxRowPerPage;
@property (nonatomic, assign) NSInteger  maxCountPerPage;

@property (nonatomic, assign) CGFloat scrollViewHeigh;
@property (nonatomic, assign) CGFloat itemWidth;
@property (nonatomic, assign) CGFloat itemHeight;

@end

@implementation YYShareActivityView

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    self.myScrollView.delegate = nil;
}

+ (YYShareActivityView *)baseShareWithTitle:(NSString *)title desc:(NSString *)desc url:(NSString *)url thumbImage:(UIImage *)thumbImage image:(UIImage *)image; {
    YYActivityViewItem *item1 = [YYActivityViewItem activityViewItemWithTheme:kThemeShareActivityWeChatFreindButton
                                                                    titleName:_(@"微信好友")];
    item1.actionBlock = ^{
        [[DDShareCenter getInstance] shareWechatWithTitle:title desc:desc link:url thumbImage:thumbImage scene:0];
    };
    
    YYActivityViewItem *item2 = [YYActivityViewItem activityViewItemWithTheme:kThemeShareActivityWeChatFriendCircleButton
                                                                    titleName:_(@"朋友圈")];
    item2.actionBlock = ^{
        [[DDShareCenter getInstance] shareWechatWithTitle:title desc:desc link:url thumbImage:thumbImage scene:1];
    };
    
    YYActivityViewItem *item3 = [YYActivityViewItem activityViewItemWithTheme:kThemeShareActivityQQButton
                                                                    titleName:_(@"QQ好友")];
    item3.actionBlock = ^{
        [[DDShareCenter getInstance] shareQQWithTitle:title desc:desc url:url thumbImage:thumbImage scene:0];
    };
    
    YYActivityViewItem *item4 = [YYActivityViewItem activityViewItemWithTheme:kThemeShareActivityQzoneButton
                                                                    titleName:_(@"QQ空间")];
    item4.actionBlock = ^{
        [[DDShareCenter getInstance] shareQQWithTitle:title desc:desc url:url thumbImage:thumbImage scene:1];
    };
    
    YYActivityViewItem *item5 = [YYActivityViewItem activityViewItemWithTheme:kThemeShareActivitySinaButton
                                                                    titleName:_(@"新浪微博")];
    item5.actionBlock = ^{
        NSString *weiboStr = [NSString stringWithFormat:@"%@ >> %@",title,url];
        [[DDShareCenter getInstance] shareWeiboWithTitle:weiboStr image:image];
    };
    
    item1.enable = [DDShareCenter checkInstalledWechat];
    item2.enable = [DDShareCenter checkInstalledWechat];
    item3.enable = [DDShareCenter checkInstalledQQ];
    item4.enable = [DDShareCenter checkInstalledQQ];
    item5.enable = [DDShareCenter checkInstalledWeibo];
    
    return [[YYShareActivityView alloc] initWithShareItems:[NSArray arrayWithObjects:item1,item2,item3,item4,item5, nil]
                                                 titleName:_(@"分享到:")
                                          horizontalMargin:35
                                         horizontalSpacing:50
                                            verticalMargin:0
                                           verticalSpacing:15
                                                itemHeight:68
                                               countPerRow:3
                                                rowPerPage:2
                                                statPrefix:@""];
}

+ (YYShareActivityView *)defaultShareWithLink:(NSString *)link
                                  contactName:(NSString *)contactName
                                   statPrefix:(NSString *)statPrefix
                                        image:(UIImage *)image {
    YYActivityViewItem *item1 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityWeChatFreindButton
                                                                    titleName:_(@"微信好友")];
    item1.actionBlock = ^{
    };
    
    YYActivityViewItem *item2 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityWeChatFriendCircleButton
                                                                    titleName:_(@"朋友圈")];
    item2.actionBlock = ^{
    };
    
    YYActivityViewItem *item3 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityQQButton
                                                                    titleName:_(@"QQ好友")];
    item3.actionBlock = ^{
    };
    
    YYActivityViewItem *item4 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityQzoneButton
                                                                    titleName:_(@"QQ空间")];
    item4.actionBlock = ^{
    };
    
    YYActivityViewItem *item5 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivitySinaButton
                                                                    titleName:_(@"新浪微博")];
    item5.actionBlock = ^{
    };
    
    item1.enable = [DDShareCenter checkInstalledWechat];
    item2.enable = [DDShareCenter checkInstalledWechat];
    item3.enable = [DDShareCenter checkInstalledQQ];
    item4.enable = [DDShareCenter checkInstalledQQ];
    item5.enable = [DDShareCenter checkInstalledWeibo];
    
    return [[YYShareActivityView alloc] initWithShareItems:[NSArray arrayWithObjects:item1,item2,item3,item4,item5, nil]
                                                 titleName:_(@"分享到:")
                                          horizontalMargin:35
                                         horizontalSpacing:50
                                            verticalMargin:0
                                           verticalSpacing:15
                                                itemHeight:68
                                               countPerRow:3
                                                rowPerPage:2
                                                statPrefix:statPrefix];
    
}

+ (YYShareActivityView *)defaultInviteWithStatPrefix:(NSString *)statPrefix{
    YYActivityViewItem *item1 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityWeChatFreindButton
                                                                    titleName:_(@"微信好友")];
    item1.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaWechatSessionWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item2 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityWeChatFriendCircleButton
                                                                    titleName:_(@"朋友圈")];
    item2.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaWechatSessionWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item3 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityQQButton
                                                                    titleName:_(@"QQ好友")];
    item3.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaQQWithStatPrefix:statPrefix];
    };

    YYActivityViewItem *item4 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivityQzoneButton
                                                                    titleName:_(@"QQ空间")];
    item4.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaQZoneWithStatPrefix:statPrefix];
    };
    
    YYActivityViewItem *item5 = [YYActivityViewItem activityViewItemWithTheme:kLinkThemeShareActivitySinaButton
                                                                    titleName:_(@"新浪微博")];
    item5.actionBlock = ^{
        [[KKShareManager getInstance] inviteViaWeiboWithStatPrefix:statPrefix];
    };
    
    [[DDShareCenter getInstance] pass];
    
    item1.enable = [DDShareCenter checkInstalledWechat];
    item2.enable = [DDShareCenter checkInstalledWechat];
    item3.enable = [DDShareCenter checkInstalledQQ];
    item4.enable = [DDShareCenter checkInstalledQQ];
    item5.enable = [DDShareCenter checkInstalledWeibo];
    
    return [[YYShareActivityView alloc] initWithShareItems:[NSArray arrayWithObjects:item1,item2,item3,item4,item5, nil]
                                                 titleName:_(@"邀请好友:")
                                          horizontalMargin:35
                                         horizontalSpacing:50
                                            verticalMargin:0
                                           verticalSpacing:15
                                                itemHeight:68
                                               countPerRow:3
                                                rowPerPage:2
                                                statPrefix:statPrefix];
}


#pragma mark -
#pragma mark   lifeCycle

- (instancetype)initWithShareItems:(NSArray *)shareItems
                         titleName:(NSString *)titlName
                        statPrefix:(NSString *)statPrefix{
    return  [self initWithShareItems:shareItems
                           titleName:titlName
                    horizontalMargin:kDefaultHorizontalMargin
                      verticalMargin:kDefaultVerticalMargin
                          itemHeight:0
                         countPerRow:kDefaultCountPerRow
                          rowPerPage:kDefaultRowPerPage
                          statPrefix:statPrefix];
}

- (instancetype)initWithShareItems:(NSArray *)shareItems
                         titleName:(NSString *)titlName
                  horizontalMargin:(NSInteger)horizontalMargin
                    verticalMargin:(NSInteger)verticalMargin
                        itemHeight:(NSInteger)itemHeight
                       countPerRow:(NSInteger)countPerRow
                        rowPerPage:(NSInteger)rowPerPage
                        statPrefix:(NSString *)statPrefix{
    return [self initWithShareItems:shareItems
                          titleName:titlName
                   horizontalMargin:horizontalMargin
                  horizontalSpacing:horizontalMargin
                     verticalMargin:verticalMargin
                    verticalSpacing:verticalMargin
                         itemHeight:itemHeight
                        countPerRow:countPerRow
                         rowPerPage:rowPerPage
                         statPrefix:statPrefix];
}

- (instancetype)initWithShareItems:(NSArray *)shareItems
                         titleName:(NSString *)titlName
                  horizontalMargin:(NSInteger)horizontalMargin
                 horizontalSpacing:(NSInteger)horizontalSpacing
                    verticalMargin:(NSInteger)verticalMargin
                   verticalSpacing:(NSInteger)verticalSpacing
                        itemHeight:(NSInteger)itemHeight
                       countPerRow:(NSInteger)countPerRow
                        rowPerPage:(NSInteger)rowPerPage
                        statPrefix:(NSString *)statPrefix{
    self = [super initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], 480)];
    if (self) {
        
        
        self.shareItems = shareItems;
        self.titleName = [titlName length] ? titlName :_(@"分享到");
        self.horizontalMargin = horizontalMargin;
        self.horizontalSpacing = horizontalSpacing;
        self.verticalMargin = verticalMargin;
        self.verticalSpacing = verticalSpacing;
        self.itemHeight = itemHeight;
        self.maxCountPerRow = countPerRow;
        
        //动态给出maxRowPerPage值默认是2
        self.maxRowPerPage = ([self.shareItems count] / self.maxCountPerRow >= 1 && [self.shareItems count] % self.maxCountPerRow > 0) ? rowPerPage : 1;
        
        self.maxCountPerPage = self.maxCountPerRow * self.maxRowPerPage;
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didEnterBackground:)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        [self initViews];
        
    }
    return self;
}


- (void)initViews{
    
    self.backgroundColor = [UIColor clearColor];
    
    //动态计算item宽度
    self.itemWidth = (self.width - (self.maxCountPerRow - 1) * self.horizontalSpacing - 2 * self.horizontalMargin) / self.maxCountPerRow;
    //动态计算item高度
    self.itemHeight = self.itemHeight ? self.itemHeight : self.itemWidth;
    
    //页数
    NSInteger numberOfPages = ceil((float)[self.shareItems count] / self.maxCountPerPage);
    
    //动态计算scrollView高度
    self.scrollViewHeigh = self.maxRowPerPage * self.itemHeight + (self.maxRowPerPage - 1) * self.verticalSpacing + 2 * self.verticalMargin;
    
    //背景
    self.backGroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.backGroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.backGroundView fullfillPrarentView];
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundViewPressed)];
    [self.backGroundView addGestureRecognizer:tapGestureRecognizer];
    [self addSubview:self.backGroundView];
    
    //containerView
    CGFloat contenViewHeight = self.scrollViewHeigh + kCancelButtonHeight + kNameLabelHeight + 4*kUISpacing + (numberOfPages <= 1 ? 0:  kPageControlheight);
    self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, contenViewHeight)];
    self.containerView.bottom = self.height;
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;

    self.containerView.backgroundColor = [UIColor whiteColor];
    
    //namelabel
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(kDefaultHorizontalMargin, kUISpacing, self.containerView.width -kDefaultHorizontalMargin, kNameLabelHeight)];
    self.nameLabel.text = self.titleName;
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.textColor = [UIColor blackColor];
    [self.containerView addSubview:self.nameLabel];
    
    //ScrollView
    self.myScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom + kUISpacing,self.containerView.width, self.scrollViewHeigh)];
    [self.myScrollView setContentSize:CGSizeMake(self.myScrollView.width * numberOfPages, self.scrollViewHeigh)];
    self.myScrollView.showsVerticalScrollIndicator = NO;
    self.myScrollView.showsHorizontalScrollIndicator = NO;
    self.myScrollView.pagingEnabled = YES;
    self.myScrollView.delegate = self;
    
    //PageControl
    self.pageControl = [[YYPageControl alloc] initWithFrame:CGRectMake(0, self.myScrollView.bottom + kUISpacing, self.containerView.width, kPageControlheight) type:YYPageControlTypeBlack];
    self.pageControl.numberOfPages = numberOfPages;
    self.pageControl.hidden = numberOfPages == 1;
    self.pageControl.currentPage = 0;
    
    //CancelButton
    self.cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0,self.containerView.height - kCancelButtonHeight, self.containerView.width, kCancelButtonHeight)];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [self.cancelButton addTarget:self action:@selector(cacelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.cancelButton.top - 1, self.containerView.width, 1)];
    lineImageView.image = [UIImage imageNamed:@"share_activity_line"];
    [self.containerView addSubview:lineImageView];
    
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.myScrollView];
    if (numberOfPages > 1) {
        [self.containerView addSubview:self.pageControl];
    }
    [self.containerView addSubview:self.cancelButton];
    [self layoutActivityViews];
}


//自动布局Items
- (void)layoutActivityViews{
    
    CGFloat screenWidth = self.width;
    
    //当前显示的页
    NSInteger currentPage = 0;
    
    DDCustomLayoutButton *activityView = nil;
    
    for (int i = 0; i < [self.shareItems count]; i++) {
        
        currentPage = i / self.maxCountPerPage;
        
        NSInteger currentRow = (i - currentPage * self.maxCountPerPage)/self.maxCountPerRow + 1;
        
        CGFloat originX = (screenWidth * currentPage) + self.horizontalMargin + (i%self.maxCountPerRow)* (self.horizontalSpacing + self.itemWidth);
        
        CGFloat originY = self.verticalMargin + (currentRow - 1) * (self.itemHeight + self.verticalSpacing);
        
        YYActivityViewItem *viewItem = [self.shareItems objectAtSafeIndex:i];
        activityView = [[DDCustomLayoutButton alloc] initWithFrame:CGRectMake(originX, originY, self.itemWidth, self.itemHeight)];
        [activityView setTitle:viewItem.titleName forState:UIControlStateNormal];
        [activityView setThemeUIType:[self theme:viewItem.theme enable:viewItem.enable]];
        activityView.customLayoutBlock = ^(UIButton *button) {
            button.titleLabel.frame = CGRectMake(0, button.height - 15, button.width, 15);
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            button.imageView.frame = CGRectMake(0, 0, button.width, button.height - 15);
            button.imageView.contentMode = UIViewContentModeCenter;
        };
        
        activityView.tag = i + kTagOffSet;
        [activityView addTarget:self action:@selector(activityButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.myScrollView addSubview:activityView];
        activityView = nil;
    }
}

#pragma mark -
#pragma mark    UIResponder Touches
//截获所有touch方法,不传给下级View
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
}

#pragma mark -
#pragma mark Theme

- (NSString *)theme:(NSString *)theme enable:(BOOL)enable{
    if (!enable) {
        return [theme stringByAppendingString:@"Disable"];
    } else {
        return theme;
    }
}

#pragma mark -
#pragma mark Button Actions

- (void)activityButtonPressed:(UIButton *)button{
    NSInteger pressedIndex = button.tag - kTagOffSet;
    YYActivityViewItem *item = [self.shareItems objectAtIndex:pressedIndex];
    if (item.enable) {
        if (item.actionBlock) {
            item.actionBlock();
        }
    } else {
        [UIAlertView postAlertWithMessage:_(@"无法分享，未安装客户端")];
    }
    [self dismissWithAnimation:YES];
}

- (void)backgroundViewPressed{
    [self dismissWithAnimation:YES];
}

- (void)cacelButtonPressed:(UIButton *)button{
    [self dismissWithAnimation:YES];
}

#pragma mark -
#pragma mark  UIApplicationDidEnterBackgroundNotification

- (void)didEnterBackground:(NSNotification *)notification{
    [self dismissWithAnimation:NO];
}

#pragma mark -
#pragma mark  UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage =(int)(scrollView.contentOffset.x/scrollView.width);
}


#pragma mark -
#pragma mark  show && dismiss

- (void)showInView:(UIView *)view{
    CGRect frame = view.bounds;
    self.frame = frame;
    self.containerView.top = CGRectGetHeight(frame);
    [view addSubview:self];
    [view bringSubviewToFront:self];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.containerView.bottom =CGRectGetHeight(frame);
    }];
}

- (void)dismissWithAnimation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            self.containerView.top =CGRectGetHeight(self.frame);
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
    }
}

@end
