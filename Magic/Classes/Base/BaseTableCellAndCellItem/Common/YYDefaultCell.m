//
//  YYDefaultCell.m
//  Wuya
//
//  Created by Tong on 20/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYDefaultCell.h"

@implementation YYDefaultCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.textLabel setThemeUIType:kThemeTableDefaultLabel];
    }
    return self;
}

@end
