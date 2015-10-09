//
//  KKIndustryManager.h
//  Magic
//
//  Created by lixiang on 15/4/25.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "DDSingletonObject.h"
#import "KKIndustryItem.h"

typedef void (^KKIndustryManagerBlock)(KKIndustryItem *industryItem);


@interface KKIndustryManager : DDSingletonObject

@property (nonatomic, strong) NSArray *industryItemList;
@property (nonatomic, assign) NSInteger type;

/** Singleton */
+ (KKIndustryManager *)getInstance;

- (void)loadIndustryList:(KKIndustryManagerBlock)prepareBlock;

@end
