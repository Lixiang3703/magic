//
//  DDTActionSheetItem.h
//  iPhone
//
//  Created by Cui Tong on 15/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DDTActionSheetItem : NSObject {
    NSString *_buttonTitle;
    SEL _selector;
    id _userInfo;
    BOOL _destructive;
}

@property (nonatomic, copy) NSString *buttonTitle;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, strong) id userInfo;
@property (nonatomic, assign) BOOL destructive;

+ (DDTActionSheetItem *)cancelActionSheetItem;

@end
