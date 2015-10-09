    //
//  PhotoScrollingViewController.m
//  Wuya
//
//  Created by Lixiang on 14-9-15.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "PhotoScrollingViewController.h"

#define kTopToolbarHeight 44
#define kToolbarHeight 40

#define kTitleLeftMargin 0
#define kTitleTopMargin 5
#define kTitleSizeWidth 280
#define kTitleSizeHeight 31

#define kPhotoScrollingToolbarButtonWidth  (25)
#define kPhotoScrollingToolbarButtonHeight  (20)
#define kPhotoScrollingToolbarButtonLeftMargin  (70)


@interface PhotoScrollingViewController()<UIScrollViewDelegate, PhotoGalleryViewControllerDelegate>

@property (nonatomic, assign) NSInteger initialIndex;

//@property (strong, nonatomic) UIButton *nextButton;
//@property (strong, nonatomic) UIButton *prevButton;

@property (strong, nonatomic) UIBarButtonItem *nextButton;
@property (strong, nonatomic) UIBarButtonItem *prevButton;


@property (strong, nonatomic) UIView *backgroundView;
@property (strong, nonatomic) UIView  *container;
@property (strong, nonatomic) UIView *innerContainer;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UILabel *naviTitleLabel;
@property (strong, nonatomic) UINavigationBar *naviBar;
@property (strong, nonatomic) UIToolbar *toolBar;

@end

@implementation PhotoScrollingViewController

#pragma mark -
#pragma mark accessor

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
        _toolBar.top = self.view.top + self.view.height;
        _toolBar.barStyle = UIBarStyleBlackTranslucent;
        _toolBar.alpha = 0.7;
    }
    return _toolBar;
}

- (UINavigationBar *)naviBar {
    if (_naviBar == nil) {
        _naviBar = [[UINavigationBar alloc] initWithFrame:CGRectZero];
        _naviBar.frame = CGRectMake( 0, 20, self.scrollView.frame.size.width, kTopToolbarHeight);
        _naviBar.barStyle = UIBarStyleBlack;
        _naviBar.backgroundColor = [UIColor clearColor];
    }
    return _naviBar;
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

- (id)initWithPhotoSource:(id<PhotoGalleryViewControllerDelegate>)photoSrc
{
	if((self = [self init])) {
        self.photoViewsArray = [NSMutableArray arrayWithCapacity:1];
        self.photoLoadersDictionary = [NSMutableDictionary dictionaryWithCapacity:1];
        self.barItemsArray = [NSMutableArray arrayWithCapacity:1];
        
		_photoSource = photoSrc;
        if (_photoSource == nil) {
            _photoSource = self;
        }
	}
	return self;
}

- (id)initWithPhotoSource:(id<PhotoGalleryViewControllerDelegate>)photoSrc initialIndex:(NSInteger)initialIndex {
    if (self = [self initWithPhotoSource:photoSrc]) {
        self.initialIndex = initialIndex;
    }
    return self;
}

- (UIBarButtonItem *)rightBarButtonItem {
    return [UIBarButtonItem barButtonItemWithTitle:_(@"删除") target:self action:@selector(delButtonPressed:)];
}

- (void)backButtonClick:(id)sender {
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryViewControllerWillDismiss:touched:)]) {
        [self.photoSource photoGalleryViewControllerWillDismiss:self touched:YES];
    }
    if (self.isPushAnimation) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)delButtonPressed:(id)sender {
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGalleryDeletePhoto:atIndex:successBlock:failedBlock:)]) {
        __weak PhotoScrollingViewController *weakSelf = self;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self exitFullscreen];
    
    [self reloadGalleryWithIndex:self.initialIndex];
    
//    [self setRightBarButtonItem:[self rightBarButtonItem] animated:NO];
}

- (void)loadView {
    [super loadView];
    
    self.backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.backgroundView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:self.backgroundView];
    
    _innerContainer	= [[UIView alloc] initWithFrame:CGRectZero];
    _innerContainer.autoresizesSubviews	= NO;
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.scrollView setBackgroundColor:[UIColor blackColor]];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.delegate = self;
    [self.scrollView setFrame:self.view.frame];
    
    // create buttons for toolbar
	UIImage *leftIcon = [UIImage imageNamed:@"photo-gallery-left"];
	UIImage *rightIcon = [UIImage imageNamed:@"photo-gallery-right"];    
    
	_nextButton = [[UIBarButtonItem alloc] initWithImage:rightIcon style:UIBarButtonItemStyleDone target:self action:@selector(next)];
	_prevButton = [[UIBarButtonItem alloc] initWithImage:leftIcon style:UIBarButtonItemStyleDone target:self action:@selector(previous)];
	_prevNextButtonSize = leftIcon.size.width;
	
    // add prev next to front of the array
	[_barItemsArray insertObject:_nextButton atIndex:0];
	[_barItemsArray insertObject:_prevButton atIndex:0];
    
    // set buttons on the toolbar.
	[self.toolBar setItems:_barItemsArray animated:NO];
    
    // back button
    UIButton *btnBack = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 44)];
    btnBack.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    [btnBack setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateNormal];
    [btnBack setImage:[UIImage imageNamed:@"navi_back"] forState:UIControlStateHighlighted];
    [btnBack addTarget:self action:@selector(backButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.naviBar addSubview:btnBack];
    
    float titleWidth = 100;
    float titleHeigth = 44;
    float startX = (self.view.frame.size.width - titleWidth)/2;
    
    self.naviTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(startX, 0, titleWidth, titleHeigth)];
    [self.naviTitleLabel setText:@"photo"];
    [self.naviTitleLabel setTextColor:[UIColor whiteColor]];
    [self.naviTitleLabel setBackgroundColor:[UIColor clearColor]];
    self.naviTitleLabel.textAlignment = NSTextAlignmentCenter;
    [self.naviBar addSubview:self.naviTitleLabel];
    
    if (self.supportDelete) {
        // del button
        UIButton *delBack = [[UIButton alloc] initWithFrame:CGRectMake([UIDevice screenWidth] - 40, 0, 40, 44)];
        delBack.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [delBack setImage:[UIImage imageNamed:@"photo_del_icon"] forState:UIControlStateNormal];
        [delBack setImage:[UIImage imageNamed:@"photo_del_icon"] forState:UIControlStateHighlighted];
        [delBack addTarget:self action:@selector(delButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.naviBar addSubview:delBack];
    }

    // add items to their containers
	[self.backgroundView addSubview:_innerContainer];
    [_innerContainer addSubview:self.scrollView];
    [_innerContainer addSubview:self.toolBar];
    [_innerContainer addSubview:self.naviBar];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _isActive = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
	_isActive = NO;
    
	[[UIApplication sharedApplication] setStatusBarStyle:[[UIApplication sharedApplication] statusBarStyle] animated:animated];
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
	
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden:YES animated:YES]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];
	
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.toolBar.alpha = 0.0;
        self.naviBar.alpha = 0.0;
        [weakSelf layoutViews];
    } completion:^(BOOL finished) {
        [weakSelf enableApp];
    }];
}

- (void)exitFullscreen {
	_isFullscreen = NO;
    
	[self disableApp];
    
	UIApplication* application = [UIApplication sharedApplication];
	if ([application respondsToSelector: @selector(setStatusBarHidden:withAnimation:)]) {
		[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade]; // 3.2+
	} else {
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
		[[UIApplication sharedApplication] setStatusBarHidden:NO animated:NO]; // 2.0 - 3.2
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
	}
	[self.navigationController setNavigationBarHidden:NO animated:YES];
    
    __weak __typeof(self)weakSelf = self;
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.toolBar.alpha = 0.7;
        self.naviBar.alpha = 0.7;
        [weakSelf layoutViews];
    } completion:^(BOOL finished) {
        [weakSelf enableApp];
    }];
}

#pragma mark -
#pragma mark reloadGallery

// 这个reloadGallery 暂时没用，用下面那个带 gotoIndex 的函数
- (void)reloadGallery {
    _currentIndex = 0;
    
    // remove the old
    [self destroyViews];
    
    // build the new
    // create the image views for each photo
    [self buildViews];
    
    // start loading thumbs
    [self preloadThumbnailImages];
    
    // start on first image
    //    [self gotoImageByIndex:_currentIndex animated:NO];
    
    // layout
    [self layoutViews];
}

- (void)reloadGalleryWithIndex:(NSInteger)gotoIndex {
    [self destroyViews];
    
    // build the new
    // create the image views for each photo
    [self buildViews];
    
    // start loading thumbs
    [self preloadThumbnailImages];
    
    // start on first image
    [self gotoImageByIndex:gotoIndex animated:NO];
    
    // layout
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
	
	// the preload count indicates how many images surrounding the current photo will get preloaded.
	// a value of 2 at maximum would preload 4 images, 2 in front of and two behind the current image.
	NSUInteger preloadCount = 2;
	
	YYGalleryPhoto *photo;
	
	// check to see if the current image thumb has been loaded
	photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
	
	if( !photo )
	{
		[self loadFullsizeImageWithIndex:index];
		photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
	}
	
	NSUInteger curIndex = prevIndex;
    //    int cha = prevIndex - preloadCount;
	while( curIndex > -1 && curIndex > prevIndex - preloadCount)
	{
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
	while( curIndex < count && curIndex < nextIndex + preloadCount )
	{
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
}

- (void)gotoImageByIndex:(NSUInteger)index animated:(BOOL)animated
{
    //    NSLog(@"gotoImageByIndex:index:%d",index);
	NSUInteger numPhotos = [_photoSource numberOfPhotosForPhotoGallery:self];
	
	// constrain index within our limits
    if( index >= numPhotos ) index = numPhotos - 1;
	
	if( numPhotos == 0 ) {
		// no photos!
		_currentIndex = -1;
	}
	else {
		// clear the fullsize image in the old photo
        //		[self unloadFullsizeImageWithIndex:_currentIndex];
		
		_currentIndex = index;
		[self moveScrollerToCurrentIndexWithAnimation:animated];
		[self updateTitle];
		
		if( !animated )	{
			[self preloadThumbnailImages];
			[self loadFullsizeImageWithIndex:index];
		}
	}
	[self updateButtons];
	[self updateCaption];
    
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
//    NSLog(@"loadFullsizeImageWithIndex and index:%d",index);
	YYGalleryPhoto *photo = [self.photoLoadersDictionary objectForKey:[NSString stringWithFormat:@"%lu", (unsigned long)index]];
	
	if (photo == nil)
		photo = [self createGalleryPhotoForIndex:index];
	
    if (!self.isLocalUIImages) {
        [photo loadFullsize];
    }
	
}

- (YYGalleryPhoto *)createGalleryPhotoForIndex:(NSUInteger)index {
    NSLog(@"loadFullsizeImageWithIndex:%lu",(unsigned long)index);
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
    
    if (self.photoSource && [self.photoSource respondsToSelector:@selector(photoGallery:urlForPhotoSize:atIndex:)]) {
        thumbPath = [_photoSource photoGallery:self urlForPhotoSize:YYGalleryPhotoSizeThumbnail atIndex:index];
        fullsizePath = [_photoSource photoGallery:self urlForPhotoSize:YYGalleryPhotoSizeFullsize atIndex:index];
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
    NSUInteger count = [_photoSource numberOfPhotosForPhotoGallery:self];
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
	[self positionInnerContainer];

	[self positionToolbar];
	[self updateScrollSize];
	[self updateCaption];
	[self resizeImageViewsWithRect:self.scrollView.frame];
	[self layoutButtons];
	[self moveScrollerToCurrentIndexWithAnimation:NO];
}

- (void)resizeImageViewsWithRect:(CGRect)rect
{
	// resize all the image views
	NSUInteger i, count = [self.photoViewsArray count];
	float dx = 0;
	for (i = 0; i < count; i++) {
		YYGalleryPhotoView * photoView = [self.photoViewsArray objectAtIndex:i];
		photoView.frame = CGRectMake(dx, 0, rect.size.width, rect.size.height );
		dx += rect.size.width;
	}
}

- (void)moveScrollerToCurrentIndexWithAnimation:(BOOL)animation
{
	int xp = self.scrollView.frame.size.width * _currentIndex;
	[self.scrollView scrollRectToVisible:CGRectMake(xp, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height) animated:animation];
	_isScrolling = animation;
}

- (void)positionInnerContainer
{
	CGRect screenFrame = [[UIScreen mainScreen] bounds];
	CGRect innerContainerRect;
	
	if( self.interfaceOrientation == UIInterfaceOrientationPortrait || self.interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
        //portrait
		innerContainerRect = CGRectMake( 0, 0, screenFrame.size.width, screenFrame.size.height);
//        if (_isFullscreen) {
//            innerContainerRect.size.height += 64;
//        }
	}
	else {
        // landscape
		innerContainerRect = CGRectMake( 0, self.view.frame.size.height - screenFrame.size.width, self.view.frame.size.width, screenFrame.size.width );
	}
    
    //    NSLog(@"innerFrame:%f,%f,%f,%f,",innerContainerRect.origin.x,innerContainerRect.origin.y
    //          ,innerContainerRect.size.width,innerContainerRect.size.height);
    //    NSLog(@"mainScreen:%f,%f",screenFrame.size.width,screenFrame.size.height);
    //    NSLog(@"self.view.frame:%f,%f,",self.view.frame.size.width,self.view.frame.size.height);
    
	_innerContainer.frame = innerContainerRect;
    self.scrollView.frame = innerContainerRect;
}

- (void)positionToolbar {
	self.toolBar.frame = CGRectMake( 0, self.scrollView.frame.size.height-kToolbarHeight - ([UIDevice below7] ? 20 : 0), self.scrollView.frame.size.width, kToolbarHeight);
}

- (void)layoutButtons
{
	NSUInteger buttonWidth = roundf( self.toolBar.frame.size.width / [self.barItemsArray count] - _prevNextButtonSize * .5);
	
	// loop through all the button items and give them the same width
	NSUInteger i, count = [self.barItemsArray count];
	for (i = 0; i < count; i++) {
		UIBarButtonItem *btn = [self.barItemsArray objectAtIndex:i];
		btn.width = buttonWidth;
	}
	[self.toolBar setNeedsLayout];
}

#pragma mark -
#pragma mark update Views
- (void)updateScrollSize {
    float contentWidth = self.scrollView.frame.size.width * [_photoSource numberOfPhotosForPhotoGallery:self];
    [self.scrollView setContentSize:CGSizeMake(contentWidth, self.scrollView.frame.size.height)];
}

- (void)updateCaption {
    
}

- (void)updateButtons {
	_prevButton.enabled = ( _currentIndex <= 0 ) ? NO : YES;
	_nextButton.enabled = ( _currentIndex >= [_photoSource numberOfPhotosForPhotoGallery:self]-1 ) ? NO : YES;
}

- (void)updateTitle {
    NSString *caption = [NSString stringWithFormat:@"%ld / %lu", (long)(_currentIndex + 1),(unsigned long)[self.photoViewsArray count]];
    [self.naviTitleLabel setText:caption];
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
        //        [photoView.activity stopAnimating];
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
#pragma mark PhotoGalleryViewControllerDelegate

- (NSUInteger)numberOfPhotosForPhotoGallery:(PhotoScrollingViewController *)gallery {
    return 10;
}

#pragma mark -
#pragma mark next & previous
- (void)next {
	NSUInteger numberOfPhotos = [_photoSource numberOfPhotosForPhotoGallery:self];
	NSUInteger nextIndex = _currentIndex+1;
	
	// don't continue if we're out of images.
	if( nextIndex <= numberOfPhotos )
	{
		[self gotoImageByIndex:nextIndex animated:NO];
	}
}

- (void)previous {
	NSUInteger prevIndex = _currentIndex-1;
	[self gotoImageByIndex:prevIndex animated:NO];
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
    //	[self unloadFullsizeImageWithIndex:_currentIndex];
	
	_currentIndex = newIndex;
	[self updateCaption];
	[self updateTitle];
	[self updateButtons];
	[self loadFullsizeImageWithIndex:_currentIndex];
	[self preloadThumbnailImages];
    
    [self resetImageViewZoomLevels];
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





