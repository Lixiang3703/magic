//
//  WSErrorMessageCenter.h
//  iPhone
//
//  Created by Cui Tong on 19/04/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "DDSingletonObject.h"

@interface WSErrorMessageCenter : DDSingletonObject {
    NSDate *_lastErrorMessageDate;
}

@property (strong) NSDate *lastErrorMessageDate;

+ (WSErrorMessageCenter *)getInstance;
- (void)showAlertMessageWithError:(NSError *)error;

@end
