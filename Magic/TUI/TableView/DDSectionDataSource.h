//
//  DDSectionDataSource.h
//  Wuya
//
//  Created by Tong on 09/04/2014.
//  Copyright (c) 2014 Longbeach. All rights reserved.
//

#import "DDBaseItem.h"

@class DDBaseCellItem;

@interface DDSectionDataSource : DDBaseItem


@property (nonatomic, copy) NSString *header;
@property (nonatomic, readonly) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat headerHeightPortrait;
@property (nonatomic, assign) CGFloat headerHeightLandscape;

@property (nonatomic, copy) NSString *footer;
@property (nonatomic, readonly) CGFloat footerHeight;
@property (nonatomic, assign) CGFloat footerHeightPortrait;
@property (nonatomic, assign) CGFloat footerHeightLandscape;

@property (nonatomic, readonly) NSInteger count;
@property (nonatomic, readonly) NSArray *dataSource;
@property (nonatomic, copy) NSString *sectionIndexString;
@property (nonatomic, assign, getter = isPortrait) BOOL portrait;
@property (nonatomic, strong) UIView *headerView;

- (id)initWithHeader:(NSString *)header;
- (id)init;

+ (DDSectionDataSource *)sectionDataSourceWithoutHeader;

- (void)addCellItem:(DDBaseCellItem *)cellItem;
- (void)addCellItems:(NSArray *)cellItems;

@end
