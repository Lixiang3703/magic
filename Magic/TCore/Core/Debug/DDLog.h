//
//  DDLog.h
//  Lucky
//
//  Created by Tong on 30/03/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//



//  Debug Log - Style
//#define DDLOG_LINENUMBER_METHOD(s,...) NSLog((@"[Line %d] %s " s), __LINE__,__PRETTY_FUNCTION__, ##__VA_ARGS__);
#define DDLOG_LINENUMBER_METHOD(s,...) NSLog(@"[%@(%d)] %@",[[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__]);


//  Debug Log - Normal
#ifdef DEBUG
#define DDLog(s,...) DDLOG_LINENUMBER_METHOD(s,##__VA_ARGS__)
#else
#define DDLog(s,...)
#endif


//  Debug Log - Rect
#define DDLogFromRect(rect) DDLog(@"%@", NSStringFromCGRect(rect));

//  Debug Log - Size
#define DDLogFromSize(size) DDLog(@"%@", NSStringFromCGSize(size));

//  Debug Log - Point
#define DDLogFromPoint(point) DDLog(@"%@", NSStringFromCGPoint(point));

//  Debug Log - View Frame
#define DDLogFromView(view) DDLog(@"%@", view);

//  Debug Log - BOOL
#define DDLogFromBOOL(b) DDLog(@"%@", [NSString stringWithFormat:@"%@", b ? @"YES" : @"NO"]);

//  Debug Log - BOOL
#define DDLogFromBOOLM(b, s) DDLog(@"%@ - %@", [NSString stringWithFormat:@"%@", s], [NSString stringWithFormat:@"%@", b ? @"YES" : @"NO"]);

//  Debug Log - Line
#define DDLogLINE()    DDLog(@"-----------------------")
