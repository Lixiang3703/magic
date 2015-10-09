//
//  WSErrorMessageCenter.m
//  iPhone
//
//  Created by Cui Tong on 19/04/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "WSErrorMessageCenter.h"
#import "SynthesizeSingleton.h"
#import "WSDefinitions.h"

@interface WSErrorMessageCenter ()

- (BOOL)shouldShowErrorMessageWithCode:(NSInteger)errorCode;

@end

@implementation WSErrorMessageCenter
SYNTHESIZE_SINGLETON_FOR_CLASS(WSErrorMessageCenter);

#pragma mark -
#pragma mark Properties


- (BOOL)shouldShowErrorMessageWithCode:(NSInteger)errorCode {
    return YES;
}

- (void)showAlertMessageWithError:(NSError *)error {
    if (nil == self.lastErrorMessageDate || [[NSDate date] timeIntervalSinceDate:self.lastErrorMessageDate] > kWS_ErrorMessage_Display_TimeInterval) {
        self.lastErrorMessageDate = [NSDate date];
        
        NSInteger errorCode = error.code;
        
        NSString *errorDetail = error.wsDetail;

        if ([self shouldShowErrorMessageWithCode:errorCode]) {
#ifdef DEBUG
        NSString *errorTitle = error.wsTitle;
        [UIAlertView postAlertWithMessage:[NSString stringWithFormat:@"%@\n(%@%ld)", errorDetail, errorTitle, (long)errorCode]];
#else
        [UIAlertView postAlertWithMessage:errorDetail];
        
#endif
        }

    } else {
        //  Do nothing here
    }
}

@end
