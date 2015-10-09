//
//  YYTextCenterCell.m
//  Wuya
//
//  Created by Tong on 20/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYTextCenterCell.h"

@implementation YYTextCenterCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

@end
