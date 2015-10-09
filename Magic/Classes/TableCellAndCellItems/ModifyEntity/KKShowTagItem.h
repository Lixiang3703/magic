//
//  KKShowTagItem.h
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KKShowTagGlobalDefine.h"

@interface KKShowTagItem : NSObject

@property (nonatomic, assign) BOOL canNotEdit;

@property (nonatomic, assign) KKShowTagCellLayoutType cellLayoutType;

@property (nonatomic, copy) NSString *placeHolderString;
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *titleName;

@end
