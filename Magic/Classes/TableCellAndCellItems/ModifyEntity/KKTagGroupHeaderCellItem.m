//
//  KKTagGroupHeaderCellItem.m
//  Link
//
//  Created by Lixiang on 14/10/30.
//  Copyright (c) 2014年 Lixiang. All rights reserved.
//

#import "KKTagGroupHeaderCellItem.h"

@implementation KKTagGroupHeaderCellItem

- (void)initSettings {
    [super initSettings];
    
    self.cellHeight = 45;    
    self.cellSelectionStyle = UITableViewCellSelectionStyleNone;
}

- (instancetype)initWithTagName:(NSString *)tagName buttonName:(NSString *)buttonName {
    self = [super init];
    if (self) {
        self.tagName = tagName;
        self.buttonName = buttonName;
    }
    return self;
}
@end
