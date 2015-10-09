//
//  DDBaseCell.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UITableViewCell+DDTableView.h"


@class DDBaseCellItem;

@protocol DDCellImageShowing <NSObject>

- (void)showImagesWithCellItem:(id)cellItem;

@end


@protocol DDBaseCellActions <NSObject>

@end

@class DDBaseCellItem;

@interface DDBaseCell : UITableViewCell <DDCellImageShowing>

@property (nonatomic, assign, getter=isFirstAssignValues) BOOL firstAssignValues;

- (void)setValuesWithCellItem:(DDBaseCellItem *)cellItem;
- (void)firstAssignValuesSettingsWithCellItem:(DDBaseCellItem *)cellItem;

@end
