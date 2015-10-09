//
//  YYGalleryPhoto.m
//  Wuya
//
//  Created by Lixiang on 14-9-16.
//  Copyright (c) 2014年 Longbeach. All rights reserved.
//

#import "YYGalleryPhoto.h"
#import "WSDownloadCache.h"

@interface YYGalleryPhoto()
@property(nonatomic, strong) NSMutableData *thumbData;
@property(nonatomic, strong) NSMutableData *fullsizeData;

@property(nonatomic, strong) NSURLConnection *thumbConnection;
@property(nonatomic, strong) NSURLConnection *fullsizeConnection;

@property(nonatomic, strong) NSString *thumbUrl;
@property(nonatomic, strong) NSString *fullsizeUrl;

// delegate notifying methods
- (void)willLoadThumbFromUrl;
- (void)willLoadFullsizeFromUrl;
- (void)willLoadThumbFromPath;
- (void)willLoadFullsizeFromPath;
- (void)didLoadThumbnail;
- (void)didLoadFullsize;

// loading local images with threading
- (void)loadFullsizeInThread;
- (void)loadThumbnailInThread;

// cleanup
- (void)killThumbnailLoadObjects;
- (void)killFullsizeLoadObjects;

@end

@implementation YYGalleryPhoto

- (instancetype)initWithImage:(UIImage *)image {
    self = [super init];
    if (self) {
        self.fullsize = image;
        self.thumbnail = image;
    }
    return self;
}

- (id)initWithThumbnailUrl:(NSString *)thumb fullsizeUrl:(NSString *)fullsize delegate:(id<YYGalleryPhotoDelegate>)delegate {
    self = [super init];
    if (self) {
        self.useNetwork = YES;
        self.thumbUrl = thumb;
        self.fullsizeUrl = fullsize;
        self.delegate = delegate;
    }
    return self;
}

- (id)initWithThumbnailPath:(NSString *)thumb fullsizePath:(NSString *)fullsize delegate:(id<YYGalleryPhotoDelegate>)delegate {
    self = [super init];
    if (self) {
        self.useNetwork = NO;
        self.thumbUrl = thumb;
        self.fullsizeUrl = fullsize;
        self.delegate = delegate;
    }
    return self;
}

- (void)loadThumbnail
{
	if( _isThumbLoading || _hasThumbLoaded ) return;
	
	// load from network
	if( _useNetwork )
    {
        [self performSelector:@selector(didFailLoad) withObject:nil afterDelay:10];
        
        if ([[WSDownloadCache getInstance] cacheDidExistWithUrl:_thumbUrl resource:YES]) {
            // notify delegate
            [self willLoadThumbFromPath];
            _isThumbLoading = YES;
            
            // spawn a new thread to load from disk
            [NSThread detachNewThreadSelector:@selector(loadThumbnailInThread) toTarget:self withObject:nil];
        }
        else {
            [self willLoadThumbFromUrl];
            
            _isThumbLoading = YES;
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_thumbUrl]];
            _thumbConnection = [NSURLConnection connectionWithRequest:request delegate:self];
            _thumbData = [[NSMutableData alloc] init];
        }
	}
	
	// load from disk
	else {
		// notify delegate
		[self willLoadThumbFromPath];
		_isThumbLoading = YES;
        
		// spawn a new thread to load from disk
		[NSThread detachNewThreadSelector:@selector(loadThumbnailInThread) toTarget:self withObject:nil];
	}
}


- (void)loadFullsize
{
    //    NSLog(@"loadFullsize and index:%d and thumburl:%@",self.tag,_fullsizeUrl);
	if( _isFullsizeLoading || _hasFullsizeLoaded ) return;
	
	if( _useNetwork )
	{
        [self performSelector:@selector(didFailLoad) withObject:nil afterDelay:10];
        if ([[WSDownloadCache getInstance] cacheDidExistWithUrl:_fullsizeUrl resource:YES]) {
            // notify delegate
            [self willLoadFullsizeFromPath];
            
            _isFullsizeLoading = YES;
            
            // spawn a new thread to load from disk
            [NSThread detachNewThreadSelector:@selector(loadFullsizeInThread) toTarget:self withObject:nil];
        }
        else {
            // notify delegate
            [self willLoadFullsizeFromUrl];
            
            _isFullsizeLoading = YES;
            
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_fullsizeUrl]];
            _fullsizeConnection = [NSURLConnection connectionWithRequest:request delegate:self];
            _fullsizeData = [[NSMutableData alloc] init];
        }
	}
	else {
        // notify delegate
		[self willLoadFullsizeFromPath];
		
		_isFullsizeLoading = YES;
		
		// spawn a new thread to load from disk
		[NSThread detachNewThreadSelector:@selector(loadFullsizeInThread) toTarget:self withObject:nil];
	}
}

- (void)loadFullsizeInThread {
    _fullsize = [[WSDownloadCache getInstance] imageWithUrl:_fullsizeUrl];
    
	_hasFullsizeLoaded = YES;
	_isFullsizeLoading = NO;
    
	[self performSelectorOnMainThread:@selector(didLoadFullsize) withObject:nil waitUntilDone:YES];
}

- (void)loadThumbnailInThread {
    _thumbnail = [[WSDownloadCache getInstance] imageWithUrl:_thumbUrl];
	_hasThumbLoaded = YES;
	_isThumbLoading = NO;
	
	[self performSelectorOnMainThread:@selector(didLoadThumbnail) withObject:nil waitUntilDone:YES];
}

- (void)unloadFullsize {
    //    NSLog(@"unloadFullsize and index:%d and thumburl:%@",self.tag,_thumbUrl);
	[_fullsizeConnection cancel];
	[self killFullsizeLoadObjects];
	
	_isFullsizeLoading = NO;
	_hasFullsizeLoaded = NO;
	
	_fullsize = nil;
    _delegate = nil;
}

- (void)unloadThumbnail {
	[_thumbConnection cancel];
	[self killThumbnailLoadObjects];
	
	_isThumbLoading = NO;
	_hasThumbLoaded = NO;
	
	_thumbnail = nil;
    _delegate = nil;
}


#pragma mark -
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)conn didReceiveResponse:(NSURLResponse *)response {
	if( conn == _thumbConnection )
		[_thumbData setLength:0];
	
    else if( conn == _fullsizeConnection )
		[_fullsizeData setLength:0];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)connection:(NSURLConnection *)conn didReceiveData:(NSData *)data
{
    //    NSLog(@"data.length:%d",data.length);
	if( conn == _thumbConnection )
		[_thumbData appendData:data];
	
    else if( conn == _fullsizeConnection )
		[_fullsizeData appendData:data];
	
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)conn {
	if( conn == _thumbConnection ) {
		_isThumbLoading = NO;
		_hasThumbLoaded = YES;
		
		// create new image with data
		_thumbnail = [[UIImage alloc] initWithData:_thumbData];
        
        // save to disk
        [[WSDownloadCache getInstance] saveData:_thumbData headers:[NSDictionary dictionary] forUrl:_thumbUrl];
        
		// cleanup
		[self killThumbnailLoadObjects];
		
		// notify delegate
		if( _delegate )
			[self didLoadThumbnail];
	}
    else if( conn == _fullsizeConnection ) {
		_isFullsizeLoading = NO;
		_hasFullsizeLoaded = YES;
		
		// create new image with data
		_fullsize = [[UIImage alloc] initWithData:_fullsizeData];
		
        // save to disk
        [[WSDownloadCache getInstance] saveData:_fullsizeData headers:[NSDictionary dictionary] forUrl:_fullsizeUrl];
        
		// cleanup
		[self killFullsizeLoadObjects];
		
		// notify delegate
		if( _delegate )
			[self didLoadFullsize];
	}
	
	// turn off data indicator
	if( !_isFullsizeLoading && !_isThumbLoading )
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark -
#pragma mark Delegate Notification Methods

- (void)didFailLoad {
    if ( _delegate && [_delegate respondsToSelector:@selector(galleryPhotoFailLoad:)]) {
        [_delegate galleryPhotoFailLoad:self];
    }
}

- (void)willLoadThumbFromUrl {
	if([_delegate respondsToSelector:@selector(galleryPhoto:willLoadThumbnailFromUrl:)])
		[_delegate galleryPhoto:self willLoadThumbnailFromUrl:_thumbUrl];
}

- (void)willLoadFullsizeFromUrl {
	if([_delegate respondsToSelector:@selector(galleryPhoto:willLoadFullsizeFromUrl:)])
		[_delegate galleryPhoto:self willLoadFullsizeFromUrl:_fullsizeUrl];
}

- (void)willLoadThumbFromPath {
	if([_delegate respondsToSelector:@selector(galleryPhoto:willLoadThumbnailFromPath:)])
		[_delegate galleryPhoto:self willLoadThumbnailFromPath:_thumbUrl];
}

- (void)willLoadFullsizeFromPath {
	if([_delegate respondsToSelector:@selector(galleryPhoto:willLoadFullsizeFromPath:)])
		[_delegate galleryPhoto:self willLoadFullsizeFromPath:_fullsizeUrl];
}

- (void)didLoadThumbnail {
    //	NSLog(@"gallery phooto did load thumbnail!");
	if(_delegate && [_delegate respondsToSelector:@selector(galleryPhoto:didLoadThumbnail:)])
		[_delegate galleryPhoto:self didLoadThumbnail:_thumbnail];
}

- (void)didLoadFullsize {
    //	NSLog(@"gallery phooto did load fullsize!");
	if([_delegate respondsToSelector:@selector(galleryPhoto:didLoadFullsize:)])
		[_delegate galleryPhoto:self didLoadFullsize:_fullsize];
}

#pragma mark -
#pragma mark Memory Management

- (void)killThumbnailLoadObjects {
	_thumbConnection = nil;
	_thumbData = nil;
}

- (void)killFullsizeLoadObjects {
	_fullsizeConnection = nil;
	_fullsizeData = nil;
}

- (void)dealloc
{
    //	NSLog(@"FGalleryPhoto dealloc");
	_delegate = nil;
	
	[_fullsizeConnection cancel];
	[_thumbConnection cancel];
	[self killFullsizeLoadObjects];
	[self killThumbnailLoadObjects];
	
	_thumbUrl = nil;
	_fullsizeUrl = nil;
	
	_thumbnail = nil;
	_fullsize = nil;
}


@end
