//
//  KKModifyDelegate.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol KKModifyDelegate <NSObject>

@required
@property (nonatomic, strong) DDBlock modifyDidSuccessBlock;

@optional
@property (nonatomic, assign) BOOL hasModified;

@end