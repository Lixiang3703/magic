//
//  DDBaseCellItem.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseCellItem.h"
#import "DDBaseCell.h"

@interface DDBaseCellItem ()

@end

@implementation DDBaseCellItem

#pragma mark -
#pragma mark Accessors


#pragma mark -
#pragma mark Life cycle
- (instancetype)init {
    return [self initWithRawItem:nil];
}

- (instancetype)initWithRawItem:(DDBaseItem *)item {
    self = [super init];
    if (self) {
        [self initSettings];
        self.rawObject = item;
        
    }
    return self;
}

- (void)initSettings {
    self.cellHeight = 44;
    //  Remove "Item" from DDBaseCellItem
    NSString *cellClassName = [[[self class] description] substringByRemovingLastIndex:4];
    self.cellClass = NSClassFromString(cellClassName);
    self.cellIdentifier = [[self class] description];
    
    self.cellStyle = UITableViewCellStyleDefault;
    self.cellSelectionStyle = UITableViewCellSelectionStyleGray;
    self.cellAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    self.selectable = YES;
    
    self.userInteractionEnabled = YES;
}

+ (instancetype)cellItemWithTitle:(NSString *)title {
    DDBaseCellItem *cellItem = [[self class] cellItem];
    cellItem.textLabelText = title;
    return cellItem;
}

+ (instancetype)cellItemWithTitle:(NSString *)title detail:(NSString *)detail imageName:(NSString *)imageName {
    
    DDBaseCellItem *cellItem = [[self class] cellItem];
    cellItem.cellStyle = UITableViewCellStyleValue1;
    cellItem.textLabelText = title;
    cellItem.detailLabelText = detail;
    cellItem.imageName = imageName;
    return cellItem;
}

+ (instancetype)cellItemWithRawItem:(DDBaseItem *)item {
    DDBaseCellItem *cellItem = [[[self class] alloc] initWithRawItem:item];
    return cellItem;
}

+ (instancetype)fakeCellItem {
    DDBaseCellItem *cellItem = [[[self class] alloc] init];
    cellItem.textLabelText = @"Title";
    cellItem.detailLabelText = @"Detail";
    return cellItem;
}

+ (instancetype)cellItem {
    DDBaseCellItem *cellItem = [[[self class] alloc] init];
    return cellItem;
}

+ (instancetype)cellItemWithHeight:(CGFloat)cellHeight {
    return [[self class] cellItemWithHeight:cellHeight title:nil];
}

+ (instancetype)cellItemWithHeight:(CGFloat)cellHeight title:(NSString *)title {
    DDBaseCellItem *cellItem = [[self class] cellItem];
    cellItem.textLabelText = title;
    cellItem.cellHeight = cellHeight;
    return cellItem;
}

@end
