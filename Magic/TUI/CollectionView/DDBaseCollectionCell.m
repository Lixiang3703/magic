//
//  DDBaseCollectionCell.m
//  TongTest
//
//  Created by Tong on 29/07/2014.
//  Copyright (c) 2014 LuckyTR. All rights reserved.
//

#import "DDBaseCollectionCell.h"
#import "DDBaseCollectionCellItem.h"

@interface DDBaseCollectionCell ()


@end

@implementation DDBaseCollectionCell


#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initSettings];
    }
    return self;
}

- (void)initSettings {
    self.firstAssignValues = YES;
    
    self.backgroundColor = [UIColor clearColor];
    
}

#pragma mark -
#pragma mark Values
- (void)setValuesWithCellItem:(DDBaseCollectionCellItem *)cellItem {
    self.userInteractionEnabled = cellItem.userInteractionEnabled;
    
    if (self.firstAssignValues) {
        [self firstAssignValuesSettingsWithCellItem:cellItem];
        self.firstAssignValues = NO;
    }
}

- (void)firstAssignValuesSettingsWithCellItem:(DDBaseCollectionCellItem *)cellItem {
    if (cellItem.defaultWhiteBgColor) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}



#pragma mark -
#pragma mark Images
- (void)showImagesWithCellItem:(DDBaseCollectionCellItem *)cellItem {
    
}

@end
