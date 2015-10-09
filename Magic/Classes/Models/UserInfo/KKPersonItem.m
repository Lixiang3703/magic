//
//  KKPersonItem.m
//  Link
//
//  Created by Lixiang on 14/10/28.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKPersonItem.h"

@implementation KKPersonItem

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super initWithDict:dict];
    if (self) {
        self.imageItem = [KKImageItem itemWithDict:[dict objectForSafeKey:@"imageItem"]];
        self.authImageItem = [KKImageItem itemWithDict:[dict objectForSafeKey:@"authImageItem"]];
        self.parentItem = [KKPersonItem itemWithDict:[dict objectForSafeKey:@"parentItem"]];
    }
    return self;
}

- (void)copyFromPersonItem:(KKPersonItem *)personItem {
    if (!personItem) {
        return;
    }
    self.kkId = personItem.kkId;
    self.role = personItem.role;
    self.name = personItem.name;
    self.parentId = personItem.parentId;
    self.company = personItem.company;
}


- (BOOL)isMineWithPersonItem:(KKPersonItem *)personItem {
    return (self.kkId == personItem.kkId);
}

- (BOOL)isMineWithPersonId:(NSInteger)personId {
    return (self.kkId == personId);
}

- (BOOL)hasAvatar {
    if (self.imageItem && [self.imageItem.urlMiddle hasContent]) {
        return YES;
    }
    return NO;
}

@end
