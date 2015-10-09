//
//  TKAlertCenter.h
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class TKAlertView;
@class WSBaseRequestModel;
@interface TKAlertCenter : NSObject {
	NSMutableArray *_alerts;
	BOOL _active;
	TKAlertView *_alertView;
	CGRect _alertFrame;
    
    NSTimeInterval _lastAlertTime;
}

@property (nonatomic, retain) NSMutableArray *alerts;
@property (nonatomic, assign) BOOL active;
@property (nonatomic, retain) TKAlertView *alertView;
@property (nonatomic, assign) CGRect alertFrame;

+ (TKAlertCenter*) defaultCenter;

- (void) postAlertWithMessage:(NSString*)message image:(UIImage*)image;
- (void) postAlertWithMessage:(NSString *)message;
+ (void) postAlertWithMessage:(NSString *)message image:(UIImage *)image withAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration;
+ (void) postAlertWithMessage:(NSString *)message;
+ (void) postAlertWithMessage:(NSString *)message withAnimation:(BOOL)animation forDuration:(NSTimeInterval)duration;
@end