//
//  PhotoGalleryViewController.m
//  Wuya
//
//  Created by Lixiang on 14/12/25.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "PhotoGalleryViewController.h"



@interface PhotoGalleryViewController ()<YYGalleryPhotoDelegate,YYGalleryPhotoViewDelegate,UIScrollViewDelegate>

@property (nonatomic, assign) NSInteger initialIndex;

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIScrollView *scrollView;


@end

@implementation PhotoGalleryViewController

#pragma mark -
#pragma mark accessor

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.top = self.view.top + self.view.height;
        _toolBar.barStyle = UIBarStyleBlackTranslucent;
        _toolBar.alpha = 1.0;
    }
    return _toolBar;
}

- (UIView *)naviView {
    if (_naviView == nil) {
        _naviView = [[UIView alloc] initWithFrame:CGRectZero];
        _naviView.frame = CGRectMake( 0, 20, self.scrollView.frame.size.width, kPhotoGalleryToolbarHeight);
        _naviView.backgroundColor = [UIColor blackColor];
    }
    return _naviView;
}

- (UINavigationBar *)naviBar {
    if (_naviBar == nil) {
        _naviBar = [[UINavigationBar alloc] initWithFrame:CGRectZero];
        _naviBar.frame = CGRectMake( 0, 20, self.scrollView.frame.size.width, kPhotoGalleryToolbarHeight);
        _naviBar.barStyle = UIBarStyleBlack;
        _naviBar.backgroundColor = [UIColor clearColor];
    }
    return _naviBar;
}

#pragma mark -
#pragma mark Initialization

- (void)initSettings {
    [super initSettings];
    
    self.navigationBarHidden = YES;
}

- (instancetype)initWithPhotoSource:(id<YYPhotoGalleryViewControllerDelegate>)photoSrc {
    if ((self = [self init])) {
        self.photoViewsArray = [NSMutableArray arrayWithCapacity:1];
        self.photoLoadersDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
        
        self.photoSource = photoSrc;
    }
    return self;

}

- (instancetype)initWithPhotoSource:(id<YYPhotoGalleryViewControllerDelegate>)photoSrc initialIndex:(NSInteger)initialIndex {
    if (self = [self initWithPhotoSource:photoSrc]) {
        self.initialIndex = initialIndex;
    }
    return self;
}

- (instancetype)initWithPhotoSource:(id<YYPhotoGalleryViewControllerDelegate>)photoSrc initialIndex:(NSInteger)initialIndex localUIImageArray:(NSArray *)uiImageArray supportDelete:(BOOL)supportDelete {
    self = [self initWithPhotoSource:photoSrc initialIndex:initialIndex];
    if (self) {
        self.localUIImageArray = uiImageArray;
        self.isLocalUIImages = YES;
        self.supportDelete = supportDelete;
    }
    return self;
}

#pragma mark -
#pragma mark life cycle

- (void)dealloc {
    NSArray *keys = [self.photoLoadersDictionary allKeys];
    NSUInteger i, count = [keys count];
    for (i = 0; i < count; i++) {
        YYGalleryPhoto *photo = [self.photoLoadersDictionary objectForKey:[keys objectAtIndex:i]];
        photo.delegate = nil;
        [photo unloadThumbnail];
        [photo unloadFullsize];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self exitFullscreen];
    [self reloadGalleryWithIndex:self.initialIndex];

    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.image = [UIImage imageNamed:@"invite_weibo.jpg"];
//    
//    [self.view addSubview:imageView];
    
    //  TODO
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isActive = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.isActive = NO;
    
    [[UIApplication sharedApplication] setStatusBarStyle:[[UIApplication sharedApplication] statusBarStyle] animated:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self updateOnePhotoContent];
//    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
//    
//    self.naviView.alpha = 0.0;
}

- (void)loadView {
    [super loadView];
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.backgroundView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.backgroundView];
    
    self.innerContainer	= [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.innerContainer.autoresizesSubviews	= NO;
    
    // scroll view
    self.scrollView = [[UIScrollView alloc] init];
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.scrollView setFrame:self.view.frame];
    self.scrollView.contentInset = UIEdgeInsetsMake(-20, 0, 0, 0);
    
    // back button
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    btnBack.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btnBack setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateHighlighted];
    [btnBack addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.naviView addSubview:btnBack];
    
//    [self.naviBar addSubview:btnBack];
    
    float titleWidth = 200;
    float titleHeigth = 44;
    float startX = (self.view.frame.size.width - titleWidth)/2;
    
    self.naviTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX, 0, titleWidth, titleHeigth)];
    [self.naviTitleLabel setText:@"photo"];
    [self.naviTitleLabel setTextColor:[UIColor whiteColor]];
    [self.naviTitleLabel setBackgroundColor:[UIColor clearColor]];
    self.naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.naviView addSubview:self.naviTitleLabel];
    
    if (self.supportDelete) {
        // delele button
        UIButton *delBack = [[UIButton alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - 40, 0, 40, 44)];
        delBack.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [delBack setImage:[UIImage imageNamed:@"photo_del_icon"] forState:UIControlStateNormal];
        [delBack setImage:[UIImage imageNamed:@"photo_del_icon"] forState:UIControlStateHighlighted];
        [delBack addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(delButtonLongPressed:)];
        [delBack addGestureRecognizer:longPressGesture];
        
        [self.naviView addSubview:delBack];
    }
    
    // add items to their containers
    [self.backgroundView addSubview:_innerContainer];
    [self.innerContainer addSubview:self.scrollView];
    if (!self.toolbarHide) {
        [self.innerContainer addSubview:self.toolBar];
    }    
    [self.innerContainer addSubview:self.naviView];
    
    CGFloat titleViewHeight = [UIDevice screenHeight]/3 - 60;
    
    self.contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIDevice screenWidth], titleViewHeight)];
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    self.contentView.clipsToBounds = YES;
    
    self.contentBgView = [[UIView alloc] initWithFrame:self.contentView.frame];
    [self.contentView addSubview:self.contentBgView];
    [self.contentBgView setBackgroundColor:[UIColor blackColor]];
    self.contentBgView.alpha = 0.7;
    self.contentBgView.height = [UIDevice screenHeight];
    
    [self.contentView addSubview:self.contentBgView];
    
    
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(kPhotoGalleryContentView_margin_left, kPhotoGalleryContentView_margin_top, [UIDevice screenWidth] - 2*kPhotoGalleryContentView_margin_left, titleViewHeight - 2*kPhotoGalleryContentView_margin_top)];
    [self.contentLabel setBackgroundColor:[UIColor clearColor]];
    self.contentLabel.text = @"";
    [self.contentLabel setTextColor:[UIColor whiteColor]];
    [self.contentLabel setFont:[UIFont systemFontOfSize:kPhotoGalleryContentLabel_fontSize]];
    self.contentLabel.numberOfLines = 0;
    
    self.contentTextView = [[UITextView alloc] initWithFrame:CGRectMake(kPhotoGalleryContentView_margin_left, kPhotoGalleryContentView_margin_top, [UIDevice screenWidth] - 2*kPhotoGalleryContentView_margin_left, titleViewHeight - 2*kPhotoGalleryContentView_margin_top)];
    [self.contentTextView setBackgroundColor:[UIColor clearColor]];
    [self.contentTextView setTextColor:[UIColor whiteColor]];
    [self.contentTextView setFont:[UIFont systemFontOfSize:kPhotoGalleryContentLabel_fontSize]];
    [self.contentTextView setEditable:NO];
    
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.contentTextView];
    
    [self.innerContainer addSubview:self.contentView];
    
    self.contentTextView.hidden = YES;
    self.contentLabel.hidden = YES;
    
    self.statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    self.statusBarView.tag = kUI_StatusBarView_Tag;
    self.statusBarView.backgroundColor = [UIColor blackColor];
    self.statusBarView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.statusBarView];
    
    //  Gesture
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressed:)];
    [self.scrollView addGestureRecognizer:longPressGesture];
}

#pragma mark -
#pragma mark Gesture

- (void)longPressed:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        
        YYGalleryPhoto *photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)self.currentIndex]];
        
        if (photo && photo.fullsize) {
            UIImageWriteToSavedPhotosAlbum(photo.fullsize, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
        }
        else if (!self.isLocalUIImages) {
            [self loadFullsizeImageWithIndex:self.currentIndex];
            [UIAlertView postAlertWithMessage:_(@"正在下载清晰大图")];
        }
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (!error) {
        [UIAlertView postAlertWithMessage:_(@"已保存至手机相册")];
    } else {
        [UIAlertView postAlertWithMessage:_(@"保存至手机相册失败")];
    }
}

#pragma mark -
#pragma mark Button Actions

- (void)backButtonClick:(id)sender {
    
    //  TODO:
//    [self.navigationController popViewControllerAnimated:YES];
    
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryViewControllerWillDismiss:touched:)]) {
        [self.photoSource photoGalleryViewControllerWillDismiss:self touched:YES];
    }
    if (self.isPushAnimation) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryViewControllerDidDismiss:)]) {
        [self.photoSource photoGalleryViewControllerDidDismiss:self];
    }

}

- (void)delButtonLongPressed:(id)sender {
    
}

- (void)delButtonPressed:(id)sender {
    [self deleteAction];
}

- (void)deleteAction {
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryDeletePhoto:atIndex:successBlock:failedBlock:)]) {
        
        __weak __typeof(self) weakSelf = self;
        
        [self.photoSource photoGalleryDeletePhoto:self atIndex:self.currentIndex successBlock:^(id userInfo) {
            if (weakSelf.currentIndex > 0) {
                weakSelf.initialIndex = weakSelf.currentIndex - 1;
            }
            else {
                weakSelf.initialIndex = 0;
            }
            
            if (![_photoSource numberOfPhotosForPhotoGallery:weakSelf]) {
                [weakSelf backButtonClick:nil];
            }
            [weakSelf reloadGalleryWithIndex:weakSelf.initialIndex];
            
        } failedBlock:^(id userInfo) {
        }];
    }
}

#pragma mark -
#pragma mark reloadGallery

- (void)reloadGallery {
    
    [self destroyViews];
    [self buildViews];
    [self preloadThumbnailImages];
    
    // layout
    [self layoutViews];
}

- (void)reloadGalleryWithIndex:(NSInteger)gotoIndex {
    
    [self destroyViews];
    [self buildViews];
    
    [self preloadThumbnailImages];
    [self gotoImageByIndex:gotoIndex animated:NO];
    
    [self layoutViews];
}

#pragma mark -
#pragma mark preloadThumbnailImages & gotoImageByIndex & createGalleryPhotoForIndex

- (void)preloadThumbnailImages {
    //    NSLog(@"preloadThumbnailImages and index:%d",_currentIndex);
    NSUInteger index = _currentIndex;
    NSUInteger count = [self.photoViewsArray count];
    
    // make sure the images surrounding the current index have thumbs loading
    NSUInteger nextIndex = index + 1;
    NSUInteger prevIndex = index - 1;
    
    if (prevIndex <= 0) {
        prevIndex = 0;
    }
    if (nextIndex >= (count - 1)) {
        nextIndex = count - 1;
    }
    
    NSUInteger preloadCount = 2;
    YYGalleryPhoto *photo;
    
    // check to see if the current image thumb has been loaded
    photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
    
    if( !photo ) {
        [self loadFullsizeImageWithIndex:index];
        photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
    }
    
    NSUInteger curIndex = prevIndex;
    //    int cha = prevIndex - preloadCount;
    while( curIndex > -1 && curIndex > prevIndex - preloadCount) {
        photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)curIndex]];
        
        if( !photo ) {
            [self loadFullsizeImageWithIndex:curIndex];
            photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)curIndex]];
        }
        
        if (!photo.hasFullsizeLoaded && !photo.isFullsizeLoading) {
            [photo loadFullsize];
        }
        
        curIndex--;
    }
    
    curIndex = nextIndex;
    while( curIndex < count && curIndex < nextIndex + preloadCount ) {
        photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)curIndex]];
        
        if( !photo ) {
            [self loadFullsizeImageWithIndex:curIndex];
            photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)curIndex]];
        }
        
        if (!photo.hasFullsizeLoaded && !photo.isFullsizeLoading) {
            [photo loadFullsize];
        }
        
        curIndex++;
    }
    
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryViewControllerHasNextItem:)]) {
        BOOL hasNext = [self.photoSource photoGalleryViewControllerHasNextItem:self];
        if (hasNext) {
            NSUInteger photosCount = [self.photoSource numberOfPhotosForPhotoGallery:self];
            if (self.currentIndex >= (photosCount - 2) || photosCount <= 2) {
                if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryViewControllerDidLoadLastItem:)]) {
                    [self.photoSource photoGalleryViewControllerDidLoadLastItem:self];
                }
            }
        }
    }
}

- (void)gotoImageByIndex:(NSUInteger)index animated:(BOOL)animated {
    //    NSLog(@"gotoImageByIndex:index:%d",index);
    NSUInteger numPhotos = [_photoSource numberOfPhotosForPhotoGallery:self];
    
    // constrain index within our limits
    if( index >= numPhotos ) index = numPhotos - 1;
    
    if( numPhotos == 0 ) {
        // no photos!
        self.currentIndex = -1;
    }
    else {
        // clear the fullsize image in the old photo
        [self unloadFullsizeImageForIndex:self.currentIndex];
        
        self.currentIndex = index;
        [self moveScrollerToCurrentIndexWithAnimation:animated];
        
        if( !animated )	{
            [self preloadThumbnailImages];
            [self loadFullsizeImageWithIndex:index];
        }
    }
    [self updateOnePhotoContent];
    
    [self resetImageViewZoomLevels];
}

- (void)resetImageViewZoomLevels {
    // resize all the image views
    NSUInteger i, count = [self.photoViewsArray count];
    for (i = 0; i < count; i++) {
        YYGalleryPhotoView * photoView = [self.photoViewsArray objectAtIndex:i];
        [photoView resetZoom];
    }
}

- (void)loadFullsizeImageWithIndex:(NSUInteger)index {
    NSLog(@"loadFullsizeImageWithIndex and index:%ld",(unsigned long)index);
    YYGalleryPhoto *photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
    
    if (photo == nil) {
        photo = [self createGalleryPhotoForIndex:index];
    }
    
    if (!self.isLocalUIImages) {
        [photo loadFullsize];
    }
}


- (void)unloadFullsizeImageForIndex:(NSInteger)index {
//TODO: 这里需要释放图片，再写
//    [self unloadFullsizeImageWithIndex:index - 3];
//    [self unloadFullsizeImageWithIndex:index + 3];
}

- (void)unloadFullsizeImageWithIndex:(NSInteger)index {
    YYGalleryPhoto *photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
    
    if (photo != nil) {
        NSLog(@"unloadFullsizeImageWithIndex:%ld",(long)index);
        YYGalleryPhotoView *photoView = [self.photoViewsArray objectAtIndex:photo.tag];
        
        if (photoView != nil) {
            [photoView removeFromSuperview];
            photoView = nil;
        }
        
        photo = nil;
    }
}

- (YYGalleryPhoto *)createGalleryPhotoForIndex:(NSUInteger)index {
    //    NSLog(@"loadFullsizeImageWithIndex:%d",index);
    YYGalleryPhoto *photo;
    
    if (self.isLocalUIImages && self.localUIImageArray && index < self.localUIImageArray.count) {
        UIImage *image = [self.localUIImageArray objectAtIndex:index];
        photo = [[YYGalleryPhoto alloc] initWithImage:image];
        return photo;
    }
    
    NSString *thumbPath;
    NSString *fullsizePath;
    
    thumbPath = @"http://c.hiphotos.baidu.com/image/pic/item/0b46f21fbe096b63d46e495e0e338744ebf8ac4c.jpg";
    fullsizePath = @"http://a.hiphotos.baidu.com/image/pic/item/a8773912b31bb0518019090b357adab44aede0d0.jpg";
    
    if (index % 3 == 1) {
        thumbPath = @"http://f.hiphotos.baidu.com/image/pic/item/0e2442a7d933c8957c19967cd31373f082020055.jpg";
        fullsizePath = @"http://f.hiphotos.baidu.com/image/pic/item/0e2442a7d933c8957c19967cd31373f082020055.jpg";
    }
    
    if (index % 3 == 2) {
        thumbPath = @"http://b.hiphotos.baidu.com/image/pic/item/8694a4c27d1ed21bbfb43a13ac6eddc450da3fc2.jpg";
        fullsizePath = @"http://b.hiphotos.baidu.com/image/pic/item/8694a4c27d1ed21bbfb43a13ac6eddc450da3fc2.jpg";
    }
    
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGallery:urlForPhotoSize:atIndex:)]) {
        thumbPath = [self.photoSource photoGallery:self urlForPhotoSize:YYGalleryPhotoSizeThumbnail atIndex:index];
        fullsizePath = [self.photoSource photoGallery:self urlForPhotoSize:YYGalleryPhotoSizeFullsize atIndex:index];
    }
    
    photo = [[YYGalleryPhoto alloc] initWithThumbnailUrl:thumbPath fullsizeUrl:fullsizePath delegate:self];
    
    // assign the photo index
    photo.tag = index;
    
    // store it
    [self.photoLoadersDictionary setObject:photo forKey: [NSString stringWithFormat:@"%lu", (unsigned long)index]];
    
    return photo;
}



#pragma mark -
#pragma mark buildViews

- (void)buildViews {
    NSUInteger count = [self.photoSource numberOfPhotosForPhotoGallery:self];
    for (NSUInteger i = 0; i < count; i++) {
        YYGalleryPhotoView *photoView = [[YYGalleryPhotoView alloc] initWithFrame:CGRectZero];
        photoView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        photoView.autoresizesSubviews = YES;
        photoView.photoDelegate = self;
        [self.scrollView addSubview:photoView];
        [self.photoViewsArray addObject:photoView];
        
        if (self.isLocalUIImages && self.localUIImageArray && i < self.localUIImageArray.count) {
            UIImage *image = [self.localUIImageArray objectAtIndex:i];
            photoView.imageView.image = image;
            [photoView killActivityIndicator];
        }
    }
}

- (void)destroyViews {
    // remove previous photo views
    for (UIView *view in self.photoViewsArray) {
        [view removeFromSuperview];
    }
    [self.photoViewsArray removeAllObjects];
    
    // remove photo loaders
    NSArray *photoKeys = [self.photoLoadersDictionary allKeys];
    for (int i=0; i<[photoKeys count]; i++) {
        YYGalleryPhoto *photoLoader = [self.photoLoadersDictionary objectForKey:[photoKeys objectAtIndex:i]];
        photoLoader.delegate = nil;
        [photoLoader unloadFullsize];
        [photoLoader unloadThumbnail];
    }
    [self.photoLoadersDictionary removeAllObjects];
}

#pragma mark -
#pragma mark layoutViews

- (void)layoutViews {
    
    self.backgroundView.top = self.view.top;
    
    [self positionInnerContainer];
    
    [self updateScrollSize];
    [self updateOnePhotoContent];
    [self resizeImageViewsWithRect:self.scrollView.frame];
    [self moveScrollerToCurrentIndexWithAnimation:NO];
    
    CGFloat toolbarTop = self.scrollView.frame.size.height - kPhotoGalleryToolbarHeight;
    if (self.isFullscreen) {
        toolbarTop += kPhotoGalleryToolbarHeight;
    }
    
    self.toolBar.frame = CGRectMake(0, toolbarTop, self.scrollView.frame.size.width, kPhotoGalleryToolbarHeight);
    
    self.contentView.bottom = self.toolBar.top;
    self.contentView.left = 0;
    self.contentView.width = self.scrollView.frame.size.width;
}

- (void)resizeImageViewsWithRect:(CGRect)rect {
    // resize all the image views
    NSUInteger i, count = [self.photoViewsArray count];
    float dx = 0;
    for (i = 0; i < count; i++) {
        YYGalleryPhotoView * photoView = [self.photoViewsArray objectAtIndex:i];
        photoView.frame = CGRectMake(dx, 0, rect.size.width, rect.size.height );
        dx += rect.size.width;
    }
}

- (void)moveScrollerToCurrentIndexWithAnimation:(BOOL)animation {
    int xp = self.scrollView.frame.size.width * _currentIndex;
    [self.scrollView scrollRectToVisible:CGRectMake(xp, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:animation];
    self.isScrolling = animation;
}

- (void)positionInnerContainer {
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    CGRect innerContainerRect;
    
    if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
        //portrait
        innerContainerRect = CGRectMake( 0, 0, screenFrame.size.width, screenFrame.size.height);
    }
    else {
        // landscape
        innerContainerRect = CGRectMake( 0, self.view.frame.size.height - screenFrame.size.width, self.view.frame.size.width, screenFrame.size.width );
    }
    
    //    NSLog(@"innerFrame:%f,%f,%f,%f,",innerContainerRect.origin.x,innerContainerRect.origin.y
    //          ,innerContainerRect.size.width,innerContainerRect.size.height);
    //    NSLog(@"mainScreen:%f,%f",screenFrame.size.width,screenFrame.size.height);
    //    NSLog(@"self.view.frame:%f,%f,",self.view.frame.size.width,self.view.frame.size.height);
    
    self.innerContainer.frame = innerContainerRect;
    self.scrollView.frame = innerContainerRect;
}

#pragma mark -
#pragma mark Update Views

- (void)updateScrollSize {
    float contentWidth = self.scrollView.frame.size.width * [_photoSource numberOfPhotosForPhotoGallery:self];
    [self.scrollView setContentSize:CGSizeMake(contentWidth, self.scrollView.frame.size.height)];
}

- (void)updateOnePhotoContent {
    [self updateNaviTitle];
    [self updateContentLabel];
}

- (void)updateContentLabel {
    if ([self.photoSource numberOfPhotosForPhotoGallery:self] > 0) {
        if ([self.photoSource respondsToSelector:@selector(photoGallery:contentForPhotoAtIndex:)]) {
            NSString *content = [self.photoSource photoGallery:self contentForPhotoAtIndex:self.currentIndex];
            
            if (content && content.length > 0) {
                
                CGFloat maxHeight = [UIDevice screenHeight]/3 - 60;
                
                CGSize contentSize = [content boundingRectWithSize:CGSizeMake([UIDevice screenWidth] - 2*kPhotoGalleryContentView_margin_left, maxHeight + 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:kPhotoGalleryContentLabel_fontSize]} context:nil].size;
                
                if (contentSize.height < maxHeight) {
                    self.contentTextView.hidden = YES;
                    self.contentLabel.hidden = NO;
                    
                    self.contentLabel.height = contentSize.height;
                    self.contentLabel.text = content;
                    
                    self.contentViewHeight = kPhotoGalleryContentView_margin_top * 2 + contentSize.height;
                }
                else {
                    self.contentTextView.hidden = NO;
                    self.contentLabel.hidden = YES;
                    
                    self.contentTextView.text = content;
                    self.contentTextView.height = maxHeight;
                    
                    self.contentViewHeight = kPhotoGalleryContentView_margin_top * 2 + maxHeight;
                }
                
                self.contentView.height = self.contentViewHeight;
                self.contentView.bottom = self.toolBar.top;
                self.contentView.hidden = NO;
            }
            else {
                self.contentView.hidden = YES;
                self.contentLabel.hidden = YES;
                self.contentTextView.hidden = YES;
            }
        }
        else {
            self.contentView.hidden = YES;
            self.contentLabel.hidden = YES;
            self.contentTextView.hidden = YES;
        }
    }
}

- (void)updateNaviTitle {
    if ([self.photoSource numberOfPhotosForPhotoGallery:self] > 0) {
        if ([self.photoSource respondsToSelector:@selector(photoGallery:captionForPhotoAtIndex:)]) {
            NSString *caption = [self.photoSource photoGallery:self captionForPhotoAtIndex:self.currentIndex];
            self.naviTitleLabel.text = caption;
        }
        else {
            NSString *caption = [NSString stringWithFormat:@"%ld / %lu", (long)(_currentIndex + 1),(unsigned long)[self.photoViewsArray count]];
            [self.naviTitleLabel setText:caption];
        }
    }
}

- (void)updateButtons {
    
}

#pragma mark -
#pragma mark YYGalleryPhotoViewDelegate

- (void)didTapPhotoView:(YYGalleryPhotoView*)photoView {
    // don't change when scrolling
    if( _isScrolling || !_isActive ) return;
    
    // toggle fullscreen.
    if( _isFullscreen == NO ) {
        [self enterFullscreen];
    }
    else {
        [self exitFullscreen];
    }
}

#pragma mark -
#pragma mark YYGalleryPhotoDelegate

- (void)galleryPhotoFailLoad:(YYGalleryPhoto *)photo {
    if (self.photoViewsArray.count > photo.tag) {
        //        NSLog(@"didLoadFullsize:photoView.tag:%d",photo.tag);
        YYGalleryPhotoView *photoView = [self.photoViewsArray objectAtIndex:photo.tag];
        [photoView killActivityIndicator];
    }
}

- (void)galleryPhoto:(YYGalleryPhoto*)photo willLoadThumbnailFromPath:(NSString*)path {
    
}


- (void)galleryPhoto:(YYGalleryPhoto*)photo willLoadThumbnailFromUrl:(NSString*)url {
    
}


- (void)galleryPhoto:(YYGalleryPhoto*)photo didLoadThumbnail:(UIImage*)image {
    if (self.photoViewsArray.count > photo.tag) {
        //        NSLog(@"didLoadFullsize:photoView.tag:%d",photo.tag);
        YYGalleryPhotoView *photoView = [self.photoViewsArray objectAtIndex:photo.tag];
        photoView.imageView.image = photo.thumbnail;
        [photoView killActivityIndicator];
    }
}


- (void)galleryPhoto:(YYGalleryPhoto*)photo didLoadFullsize:(UIImage*)image {
    if (self.photoViewsArray.count > photo.tag) {
        //        NSLog(@"didLoadFullsize:photoView.tag:%d",photo.tag);
        YYGalleryPhotoView *photoView = [self.photoViewsArray objectAtIndex:photo.tag];
        photoView.imageView.image = photo.fullsize;
        [photoView killActivityIndicator];
    }
}

#pragma mark -
#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _isScrolling = YES;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if( !decelerate ) {
        [self scrollingHasEnded];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollingHasEnded];
}

// 在滚动条结束的时候调用，相对 gotoimageByIndex 的意思是说，没有滑动的直接指向那个图片
- (void)scrollingHasEnded {
    
    _isScrolling = NO;
    
    NSUInteger newIndex = floor( self.scrollView.contentOffset.x / self.scrollView.frame.size.width );
    
    // don't proceed if the user has been scrolling, but didn't really go anywhere.
    if( newIndex == _currentIndex )
        return;
    
    // clear previous
    [self unloadFullsizeImageForIndex:_currentIndex];
    
    _currentIndex = newIndex;
    [self updateOnePhotoContent];
    [self updateButtons];
    [self loadFullsizeImageWithIndex:_currentIndex];
    [self preloadThumbnailImages];
    
    [self resetImageViewZoomLevels];
}


#pragma mark -
#pragma mark switch FullScreen

- (void)enableApp {
    [[UIApplication sharedApplication] endIgnoringInteractionEvents];
}

- (void)disableApp {
    [[UIApplication sharedApplication] beginIgnoringInteractionEvents];
}

- (void)enterFullscreen {
    _isFullscreen = YES;
    
    [self disableApp];
    
    self.statusBarColor = [UIColor clearColor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    __weak __typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.toolBar.alpha = 1.0;
        self.naviView.alpha = 0.0;
        self.naviView.bottom = 0;
        self.statusBarView.hidden = YES;
        [weakSelf layoutViews];
    } completion:^(BOOL finished) {
        [weakSelf enableApp];
    }];
}

- (void)exitFullscreen {
    _isFullscreen = NO;
    
    [self disableApp];
    
    self.statusBarColor = [UIColor blackColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.toolBar.alpha = 1.0;
        self.naviView.alpha = 1.0;
        self.naviView.bottom = kPhotoGalleryToolbarHeight + 20;
        self.statusBarView.hidden = NO;
        [weakSelf layoutViews];
    } completion:^(BOOL finished) {
        [weakSelf enableApp];
    }];
}

#pragma mark -
#pragma mark StatusBar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

-(BOOL)prefersStatusBarHidden{
//    if (self.isFullscreen) {
//        return YES;
//    }
    return NO;
}


@end



