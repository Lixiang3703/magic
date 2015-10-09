//
//  KKCaseItem.m
//  Magic
//
//  Created by lixiang on 15/4/12.
//  Copyright (c) 2015年 lixiang. All rights reserved.
//

#import "KKCaseItem.h"

@implementation KKCaseItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.customItem = [KKCaseCustomItem itemWithDict:[dict objectForSafeKey:@"customItem"]];
        self.typeItem = [KKCaseTypeItem itemWithDict:[dict objectForSafeKey:@"caseTypeItem"]];
        self.trademarkItem = [KKImageItem itemWithDict:[dict objectForSafeKey:@"trademarkItem"]];
    }
    return self;
}

- (KKCaseCustomItem *)customItem {
    if (_customItem == nil) {
        _customItem = [[KKCaseCustomItem alloc] init];
    }
    return _customItem;
}

- (void)createCustom {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setSafeObject:self.customItem.applyNumber forKey:@"applyNumber"];
    [dict setSafeObject:self.customItem.applyName forKey:@"applyName"];
    [dict setSafeObject:self.customItem.productionName forKey:@"productionName"];
    
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    self.custom = myString;
}

- (void)createTitle {
    if (!self.title || ![self.title hasContent]) {
        self.title = @"我申请办理一个业务";
    }
}


@end
