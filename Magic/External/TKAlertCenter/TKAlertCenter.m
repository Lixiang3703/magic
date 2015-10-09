//
//  TKAlertCenter.m
//  Created by Devin Ross on 9/29/10.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "TKAlertCenter.h"
#import "UIView+TKCategory.h"
#define DDKeyWindow [(iPhoneAppDelegate *)[UIApplication sharedApplication].delegate window]

#pragma mark -
@interface TKAlertView : UIView {
	CGRect _messageRect;
	NSString *_text;
	UIImage *_image;
}

- (id) init;
- (void) setMessageText:(NSString*)str;
- (void) setImage:(UIImage*)image;

@end


#pragma mark -
@implementation TKAlertView

- (id) init{
	if(!(self = [super initWithFrame:CGRectMake(0, 0, 100, 100)])) return nil;
	_messageRect = CGRectInset(self.bounds, 10, 10);
	self.backgroundColor = [UIColor clearColor];
	return self;
	
}
- (void) dealloc{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
	[_text release];
	[_image release];
	[super dealloc];
}


- (void) drawRect:(CGRect)rect{
    [[UIColor colorWithWhite:0 alpha:0.8] set];
    [UIView drawRoundRectangleInRect:rect withRadius:10];
    //	[[UIColor whiteColor] set];
    [RGBCOLOR(233, 233, 233) set];
    
    if ([_text hasContent]) {
        //        [_text drawInRect:_messageRect withFont:[UIFont boldSystemFontOfSize:16] lineBreakMode:NSLineBreakByWordWrapping alignment:NSTextAlignmentCenter];
        NSMutableParagraphStyle *paragrapStyle = [[NSMutableParagraphStyle alloc] init];
        paragrapStyle.alignment = NSTextAlignmentCenter;
        [_text drawInRect:_messageRect withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],NSForegroundColorAttributeName:[UIColor whiteColor], NSParagraphStyleAttributeName:paragrapStyle}];
        [paragrapStyle release];
        CGRect r = CGRectZero;
        r.origin.y = 15;
        r.origin.x = (rect.size.width-_image.size.width)/2;
        r.size = _image.size;
    }
    
    if (_image) {
        CGRect r = CGRectZero;
        r.origin.y = (rect.size.height-_image.size.height)/2;
        r.origin.x = (rect.size.width-_image.size.width)/2;
        r.size = _image.size;
        [_image drawInRect:r];
    }
    
    
}

#pragma mark Setter Methods
- (void) adjust{
    
    //	CGSize s = [_text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(160,200) lineBreakMode:NSLineBreakByWordWrapping];
    
    CGSize s = CGSizeZero;
    float imageAdjustment = 0;
    
    if (![_text hasContent]) {
        s = _image.size;
        
        //	self.bounds = CGRectMake(0, 0, s.width+40, s.height+15+15+imageAdjustment);
        self.bounds = CGRectMake(0, 0, s.width+22+22, s.height+22+22+imageAdjustment);
        
        _messageRect = CGRectZero;
    } else {
        //        s = [_text sizeWithFont:[UIFont boldSystemFontOfSize:17] constrainedToSize:CGSizeMake(200,200) lineBreakMode: NSLineBreakByWordWrapping];
        s = [_text boundingRectWithSize:CGSizeMake(200,200) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17]} context:nil].size;
        
        if (_image) {
            imageAdjustment = 7+_image.size.height;
        }
        
        //	self.bounds = CGRectMake(0, 0, s.width+40, s.height+15+15+imageAdjustment);
        self.bounds = CGRectMake(0, 0, s.width+22+22, s.height+22+22+imageAdjustment);
        
        
        _messageRect.size = s;
        _messageRect.size.height += 5;
        _messageRect.origin.x = 22;
        _messageRect.origin.y = 22+imageAdjustment;
    }
    
    
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
    
}
- (void) setMessageText:(NSString*)str{
	[_text release];
	_text = [str retain];
	[self adjust];
}
- (void) setImage:(UIImage*)img{
	[_image release];
	_image = [img retain];
	[self adjust];
}

@end


#pragma mark -
#import "AppDelegate.h"
#define DDDKeyWindow ((AppDelegate *)[UIApplication sharedApplication].delegate).window

@implementation TKAlertCenter

@synthesize alerts = _alerts;
@synthesize active = _active;
@synthesize alertView = _alertView;
@synthesize alertFrame = _alertFrame;

- (void) dealloc{
	[_alerts release];
	[_alertView release];
	[super dealloc];
}


//4 test


#pragma mark Init & Friends
static TKAlertCenter *defaultCenter = nil;
+ (TKAlertCenter*) defaultCenter {
	if (!defaultCenter) {
		defaultCenter = [[TKAlertCenter alloc] init];
	}
    
//    if (defaultCenter.alerts) {
//        [defaultCenter.alerts removeAllObjects];
//    }
    
	return defaultCenter;
}
- (id) init{
	if(!(self=[super init])) return nil;
	
	_alerts = [[NSMutableArray alloc] init];
	_alertView = [[TKAlertView alloc] init];
	_active = NO;
		
	_alertFrame = DDDKeyWindow.bounds;
    if (CGRectIsEmpty(_alertFrame)) {
        _alertFrame = CGRectMake(0, 0, [UIDevice screenWidth], [UIDevice screenHeight]);
    }
    //    _alertFrame = DDKeyWindow.bounds;
	
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardDidHideNotification object:nil];
//	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationWillChange:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    
	return self;
}


#pragma mark Show Alert Message
- (void) showAlertsWithAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration
{
	if (animation) {
        [self showAlerts:duration];
        return;
    }
    
	if([_alerts count] < 1) {
		_active = NO;
		return;
	}
	
	_active = YES;
	
	[DDDKeyWindow addSubview:_alertView];
	
	NSArray *ar = [_alerts objectAtIndex:0];
	
	UIImage *img = nil;
	if([ar count] > 1) img = [[_alerts objectAtIndex:0] objectAtIndex:1];
	
	
    
	if([ar count] > 0) [_alertView setMessageText:[[_alerts objectAtIndex:0] objectAtIndex:0]];
	
    [_alertView setImage:img];
	
	_alertView.center = CGPointMake(_alertFrame.origin.x+_alertFrame.size.width/2, _alertFrame.origin.y+_alertFrame.size.height/2);
    
	CGRect rr = _alertView.frame;
	rr.origin.x = (int)rr.origin.x;
	rr.origin.y = (int)rr.origin.y;
	_alertView.frame = rr;
	
	UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat degrees = 0;
	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	_alertView.alpha = 1;
    
//    [self performSelector:@selector(animationStep3) withObject:nil afterDelay:duration];
    
    int64_t delayInSeconds = duration;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_alertView removeFromSuperview];
        [_alerts removeObjectAtIndex:0];
        [self showAlerts:0.0];
    });
    
}

- (void)showAlerts:(NSTimeInterval)duration{
	
	if([_alerts count] < 1) {
		_active = NO;
		return;
	}
	
	_active = YES;
	
	_alertView.transform = CGAffineTransformIdentity;
	_alertView.alpha = 0;
    [DDDKeyWindow addSubview:_alertView];
    
	NSArray *ar = [_alerts objectAtIndex:0];
	
	UIImage *img = nil;
	if([ar count] > 1) img = [[_alerts objectAtIndex:0] objectAtIndex:1];
	if([ar count] > 0) [_alertView setMessageText:[[_alerts objectAtIndex:0] objectAtIndex:0]];
	
    [_alertView setImage:img];
    
	_alertView.center = CGPointMake(_alertFrame.origin.x+_alertFrame.size.width/2, _alertFrame.origin.y+_alertFrame.size.height/2);
    
	CGRect rr = _alertView.frame;
	rr.origin.x = (int)rr.origin.x;
	rr.origin.y = (int)rr.origin.y;
    if (![UIDevice is4InchesScreen]) {
        rr.origin.y -= 30;
    }
	_alertView.frame = rr;
	
	UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
	CGFloat degrees = 0;
	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	//_alertView.transform = CGAffineTransformScale(_alertView.transform, 2, 2);
    
    // depending on how many words are in the text
	// change the animation duration accordingly
	// avg person reads 200 words per minute
	NSArray * words = [[[_alerts objectAtIndex:0] objectAtIndex:0] componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if (duration == 0.0) duration = 1.0;
    double newDelayDuration = MAX(((double)[words count]*60.0/200.0), duration);
	
	[UIView animateWithDuration:0.15
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         //_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
                         //_alertView.frame = CGRectMake ((int)_alertView.frame.origin.x, (int)_alertView.frame.origin.y, _alertView.frame.size.width, _alertView.frame.size.height);
                         [_alertView setAlpha:1];
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2
                                               delay:newDelayDuration
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              
                                              UIInterfaceOrientation o = [UIApplication sharedApplication].statusBarOrientation;
                                              CGFloat degrees = 0;
                                              if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
                                              else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
                                              else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
                                              _alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
                                              _alertView.transform = CGAffineTransformScale(_alertView.transform, 0.5, 0.5);
                                              
                                              _alertView.alpha = 0;
                                              
                                          } completion:^(BOOL finished) {
                                              
                                              [_alertView removeFromSuperview];
                                              [_alerts removeObjectAtIndex:0];
                                              [self showAlerts:0.0];
                                              
                                          }];
                         
                     }];
	
}

- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image{
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    if (currentTime - _lastAlertTime < 1.0f) {
        return;
    }
    _lastAlertTime = [[NSDate date] timeIntervalSince1970];
    
	[_alerts addObject:[NSArray arrayWithObjects:message,image,nil]];
	if(!_active) [self showAlerts:0.0];
}

- (void)postAlertWithMessage:(NSString *)message image:(UIImage *)image withAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration
{
    
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    if (currentTime - _lastAlertTime < 1.0f) {
        return;
    }
    _lastAlertTime = [[NSDate date] timeIntervalSince1970];
    
	[_alerts addObject:[NSArray arrayWithObjects:message,image,nil]];
	if(!_active) [self showAlertsWithAnimation:animation forDuration:duration];
}

- (void) postAlertWithMessage:(NSString*)message{
	[self postAlertWithMessage:message image:nil];
}

- (void)postAlertWithMessage:(NSString *)message withAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration
{
    [self postAlertWithMessage:message image:nil withAnimation:animation forDuration:duration];
}


#pragma mark System Observation Changes
CGRect subtractRect(CGRect wf,CGRect kf);
CGRect subtractRect(CGRect wf,CGRect kf){
	
	
	
	if(!CGPointEqualToPoint(CGPointZero,kf.origin)){
		
		if(kf.origin.x>0) kf.size.width = kf.origin.x;
		if(kf.origin.y>0) kf.size.height = kf.origin.y;
		kf.origin = CGPointZero;
		
	}else{
		
		
		kf.origin.x = fabs(kf.size.width - wf.size.width);
		kf.origin.y = fabs(kf.size.height -  wf.size.height);
		
		
		if(kf.origin.x > 0){
			CGFloat temp = kf.origin.x;
			kf.origin.x = kf.size.width;
			kf.size.width = temp;
		}else if(kf.origin.y > 0){
			CGFloat temp = kf.origin.y;
			kf.origin.y = kf.size.height;
			kf.size.height = temp;
		}
		
	}
	return CGRectIntersection(wf, kf);
	
}
- (void) keyboardWillAppear:(NSNotification *)notification {
	
	NSDictionary *userInfo = [notification userInfo];
	NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
	CGRect kf = [aValue CGRectValue];
	CGRect wf = DDDKeyWindow.bounds;
	//CGRect wf = DDKeyWindow.bounds;
    
	[UIView beginAnimations:nil context:nil];
	_alertFrame = subtractRect(wf,kf);
	_alertView.center = CGPointMake(_alertFrame.origin.x+_alertFrame.size.width/2, _alertFrame.origin.y+_alertFrame.size.height/2);
    
	[UIView commitAnimations];
    
}
- (void) keyboardWillDisappear:(NSNotification *) notification {
	_alertFrame = DDDKeyWindow.bounds;
    //_alertFrame = DDKeyWindow.bounds;
    
}
- (void) orientationWillChange:(NSNotification *) notification {
	
	NSDictionary *userInfo = [notification userInfo];
	NSNumber *v = [userInfo objectForKey:UIApplicationStatusBarOrientationUserInfoKey];
	UIInterfaceOrientation o = [v intValue];
	
	
	
	
	CGFloat degrees = 0;
	if(o == UIInterfaceOrientationLandscapeLeft ) degrees = -90;
	else if(o == UIInterfaceOrientationLandscapeRight ) degrees = 90;
	else if(o == UIInterfaceOrientationPortraitUpsideDown) degrees = 180;
	
	[UIView beginAnimations:nil context:nil];
	_alertView.transform = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	_alertView.frame = CGRectMake((int)_alertView.frame.origin.x, (int)_alertView.frame.origin.y, (int)_alertView.frame.size.width, (int)_alertView.frame.size.height);
	[UIView commitAnimations];
	
}

+ (void)postAlertWithMessage:(NSString *)message
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:message];
}

+ (void)postAlertWithMessage:(NSString *)message withAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration
{
    [[TKAlertCenter defaultCenter] postAlertWithMessage:message withAnimation:animation forDuration:duration];
}

+ (void) postAlertWithMessage:(NSString *)message image:(UIImage *)image withAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration {
    [[TKAlertCenter defaultCenter] postAlertWithMessage:message image:image withAnimation:animation forDuration:duration];
}


@end


