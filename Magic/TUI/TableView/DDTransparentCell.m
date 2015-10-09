//
//  DDTransparentCell.m
//  Wuya
//
//  Created by Tong on 25/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDTransparentCell.h"

@implementation DDTransparentCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}


@end
