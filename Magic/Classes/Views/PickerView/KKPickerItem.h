//
//  KKPickerItem.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKPickerItem : NSObject

@property (nonatomic, strong) id rawObject;

@property (nonatomic, assign) NSInteger iKKId;

@property (nonatomic, copy) NSString *displayId;

@property (nonatomic, copy) NSString *displayString;

@property (nonatomic, strong) NSArray *childPickerItems;

@end
