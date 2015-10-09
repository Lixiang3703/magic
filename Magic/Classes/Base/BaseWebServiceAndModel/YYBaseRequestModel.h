//
//  YYBaseRequestModel.h
//  Wuya
//
//  Created by Tong on 10/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "WSBaseRequestModel.h"
#import "YYAPIDefinitions.h"
#import "KKAPIDefinitions.h"
#import "NSError+WebService.h"

@class YYBaseAPIItem;

@interface YYBaseRequestModel : WSBaseRequestModel


/** Params */
@property (atomic, weak) YYBaseAPIItem *originItem;

/** Handler */
@property (atomic, assign) BOOL customHandle;


/** Result */
@property (atomic, assign) BOOL resultItemSingle;
@property (atomic, strong) id resultItem;
@property (atomic, copy) NSString *resultItemsKeyword;
@property (atomic, copy) NSString *resultItemsClassName;
@property (atomic, strong) NSArray *resultItems;



@end
