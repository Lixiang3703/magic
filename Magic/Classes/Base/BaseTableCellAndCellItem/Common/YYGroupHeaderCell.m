//
//  YYGroupHeaderCell.m
//  Wuya
//
//  Created by Tong on 20/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "YYGroupHeaderCell.h"
#import "YYGroupHeaderCellItem.h"

@interface YYGroupHeaderCell ()

@property (nonatomic, assign) CGFloat margin;

@end

@implementation YYGroupHeaderCell


#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self.textLabel setThemeUIType:kThemeTableGroupLabel];
        
    }
    return self;
}


- (void)setValuesWithCellItem:(YYGroupHeaderCellItem *)cellItem {
    [super setValuesWithCellItem:cellItem];

}

@end
