//
//  KKClassicsManager.h
//  Magic
//
//  Created by lixiang on 15/4/26.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKClassicsItem.h"

typedef void (^KKClassicsManagerBlock)(KKClassicsItem *classicsItem);

@interface KKClassicsManager : DDSingletonObject

@property (nonatomic, strong) NSArray *itemList;
@property (nonatomic, strong) NSMutableDictionary *itemDict;
@property (nonatomic, assign) NSInteger type;

/** Singleton */
+ (KKClassicsManager *)getInstance;

@property (nonatomic, copy) KKClassicsManagerBlock prepareBlock;

- (void)loadIndustryList:(KKClassicsManagerBlock)prepareBlock;

@end
