//
//  DDBaseCell.m
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseCell.h"
#import "DDBaseCellItem.h"

@interface DDBaseCell ()

@property (nonatomic, copy) DDCellLayoutBlock layoutBlock;

@end

@implementation DDBaseCell

#pragma mark -
#pragma mark Life cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.firstAssignValues = YES;

        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

#pragma mark -
#pragma mark Values
- (void)setValuesWithCellItem:(DDBaseCellItem *)cellItem {
    self.userInteractionEnabled = cellItem.userInteractionEnabled;
    
    if (self.firstAssignValues) {
        [self firstAssignValuesSettingsWithCellItem:cellItem];
        self.firstAssignValues = NO;
    }
    
    if (!cellItem.isStoryBoadCell) {
        self.accessoryType = cellItem.cellAccessoryType;
        self.selectionStyle = cellItem.cellSelectionStyle;
    }
    
    if (!cellItem.isStaticContentCell) {
        self.textLabel.text = cellItem.textLabelText;
        self.detailTextLabel.text = cellItem.detailLabelText;
        self.imageView.image = cellItem.imageName ? [UIImage imageNamed:cellItem.imageName] : nil;
    }
    
    self.layoutBlock = cellItem.cellLayoutBlock;
}

- (void)firstAssignValuesSettingsWithCellItem:(DDBaseCellItem *)cellItem {
    if (cellItem.defaultWhiteBgColor) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.layoutBlock) {
        self.layoutBlock(self);
    }
}


#pragma mark -
#pragma mark Images 
- (void)showImagesWithCellItem:(DDBaseCellItem *)cellItem {

}

@end
